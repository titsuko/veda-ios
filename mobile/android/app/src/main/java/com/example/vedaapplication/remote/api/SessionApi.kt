package com.example.vedaapplication.remote.api

import com.example.vedaapplication.remote.model.request.LoginRequest
import com.example.vedaapplication.remote.model.request.RefreshRequest
import com.example.vedaapplication.remote.model.response.AuthResponse
import retrofit2.http.Body
import retrofit2.http.DELETE
import retrofit2.http.POST

interface SessionApi {
    @POST("sessions")
    suspend  fun login(@Body request: LoginRequest): AuthResponse

    @DELETE("sessions/logout")
    suspend fun logout(@Body request: RefreshRequest)

    @POST("sessions/refresh")
    suspend fun refresh(@Body request: RefreshRequest): AuthResponse
}