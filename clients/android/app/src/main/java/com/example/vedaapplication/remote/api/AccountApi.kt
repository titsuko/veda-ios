package com.example.vedaapplication.remote.api

import com.example.vedaapplication.remote.model.request.CheckEmailRequest
import com.example.vedaapplication.remote.model.request.RegisterRequest
import com.example.vedaapplication.remote.model.response.AccountResponse
import com.example.vedaapplication.remote.model.response.AuthResponse
import com.example.vedaapplication.remote.model.response.AvailabilityResponse
import retrofit2.http.Body
import retrofit2.http.POST

interface AccountApi {
    @POST("accounts")
    suspend fun register(@Body request: RegisterRequest): AuthResponse

    @POST("accounts/me")
    suspend fun getProfile(): AccountResponse

    @POST("accounts/check-email")
    suspend  fun checkEmail(@Body request: CheckEmailRequest): AvailabilityResponse
}