package com.example.vedaapplication.local

import android.content.Context
import androidx.core.content.edit
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey

class TokenManager(context: Context) {

    private val masterKey = MasterKey.Builder(context)
        .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
        .build()

    private val sharedPreferences = EncryptedSharedPreferences.create(
        context,
        "secure_prefs",
        masterKey,
        EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
        EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
    )

    val isUserLoggedIn: Boolean
        get() = getRefreshToken() != null

    fun saveTokens(accessToken: String, refreshToken: String, expiresInSeconds: Long = 900) {
        val expiresAt = System.currentTimeMillis() + (expiresInSeconds - 60) * 1000
        sharedPreferences.edit {
            putString("access_token", accessToken)
            putString("refresh_token", refreshToken)
            putLong("access_token_expires_at", expiresAt)
        }
    }

    fun getAccessToken(): String? = sharedPreferences.getString("access_token", null)

    fun getRefreshToken(): String? = sharedPreferences.getString("refresh_token", null)

    fun isAccessTokenExpired(): Boolean {
        val expiresAt = sharedPreferences.getLong("access_token_expires_at", 0)
        return System.currentTimeMillis() > expiresAt
    }

    fun clearTokens() {
        sharedPreferences.edit { clear() }
    }
}