package com.example.vedaapplication.di

import android.content.Context
import com.example.vedaapplication.local.TokenManager
import com.example.vedaapplication.remote.api.SessionApi
import com.example.vedaapplication.remote.model.request.RefreshRequest
import com.jakewharton.retrofit2.converter.kotlinx.serialization.asConverterFactory
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import okhttp3.Authenticator
import okhttp3.Interceptor
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import okhttp3.Route
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit

object NetworkClient {

    private const val BASE_URL = "http://project.veda.webtm.ru/api/"
    private var tokenManager: TokenManager? = null
    private val coroutineScope = CoroutineScope(Dispatchers.IO)

    private val publicPaths = setOf(
        "/api/accounts",
        "/api/accounts/check-email",
        "/api/sessions",
        "/api/sessions/refresh",
        "/api/health"
    )

    fun init(context: Context) {
        if (tokenManager == null) {
            tokenManager = TokenManager(context)
        }
    }

    private val json = Json { ignoreUnknownKeys = true }

    private val refreshApi: SessionApi by lazy {
        Retrofit.Builder()
            .baseUrl(BASE_URL)
            .client(
                OkHttpClient.Builder()
                    .addInterceptor(HttpLoggingInterceptor().apply { level = HttpLoggingInterceptor.Level.BODY })
                    .build()
            )
            .addConverterFactory(json.asConverterFactory("application/json".toMediaType()))
            .build()
            .create(SessionApi::class.java)
    }

    private val Response.responseCount: Int
        get() {
            var result = 1
            var prior = priorResponse
            while (prior != null) {
                result++
                prior = prior.priorResponse
            }
            return result
        }

    private val authInterceptor = Interceptor { chain ->
        val originalRequest = chain.request()
        val path = originalRequest.url.encodedPath

        if (publicPaths.any { path.endsWith(it) }) {
            return@Interceptor chain.proceed(originalRequest)
        }

        val tm = tokenManager ?: return@Interceptor chain.proceed(originalRequest)

        if (tm.isUserLoggedIn && tm.isAccessTokenExpired()) {
            synchronized(this) {
                if (tm.isAccessTokenExpired()) {
                    tm.getRefreshToken()?.let { refreshToken ->
                        try {
                            val response = runBlocking {
                                refreshApi.refresh(RefreshRequest(refreshToken))
                            }
                            tm.saveTokens(
                                accessToken = response.accessToken,
                                refreshToken = response.refreshToken,
                                expiresInSeconds = response.expiresIn ?: 900L
                            )
                        } catch (e: Exception) {
                            e.printStackTrace()
                        }
                    }
                }
            }
        }

        val token = tm.getAccessToken()
        val newRequest = if (token != null) {
            originalRequest.newBuilder()
                .header("Authorization", "Bearer $token")
                .build()
        } else {
            originalRequest
        }

        chain.proceed(newRequest)
    }

    private val tokenAuthenticator = object : Authenticator {
        override fun authenticate(route: Route?, response: Response): Request? {
            if (response.request.url.encodedPath.endsWith("/refresh") || response.responseCount > 2) {
                return null
            }

            val tm = tokenManager ?: return null
            val refreshToken = tm.getRefreshToken() ?: return null

            return synchronized(this) {
                val newToken = tm.getAccessToken()
                val headerToken = response.request.header("Authorization")?.replace("Bearer ", "")

                if (newToken != null && newToken != headerToken) {
                    return@synchronized response.request.newBuilder()
                        .header("Authorization", "Bearer $newToken")
                        .build()
                }

                val refreshResult = runBlocking {
                    try {
                        refreshApi.refresh(RefreshRequest(refreshToken))
                    } catch (e: Exception) {
                        null
                    }
                }

                if (refreshResult != null) {
                    tm.saveTokens(
                        accessToken = refreshResult.accessToken,
                        refreshToken = refreshResult.refreshToken,
                        expiresInSeconds = refreshResult.expiresIn ?: 900L
                    )
                    response.request.newBuilder()
                        .header("Authorization", "Bearer ${refreshResult.accessToken}")
                        .build()
                } else {
                    coroutineScope.launch {
                        tm.clearTokens()
                    }
                    null
                }
            }
        }
    }

    private val okHttpClient by lazy {
        OkHttpClient.Builder()
            .addInterceptor(HttpLoggingInterceptor().apply { level = HttpLoggingInterceptor.Level.BODY })
            .addInterceptor(authInterceptor)
            .authenticator(tokenAuthenticator)
            .build()
    }

    val retrofit: Retrofit by lazy {
        Retrofit.Builder()
            .baseUrl(BASE_URL)
            .client(okHttpClient)
            .addConverterFactory(json.asConverterFactory("application/json".toMediaType()))
            .build()
    }
}