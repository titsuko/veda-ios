package com.example.vedaapplication.remote.service

import com.example.vedaapplication.di.NetworkClient
import com.example.vedaapplication.remote.api.SessionApi
import com.example.vedaapplication.remote.model.request.LoginRequest
import com.example.vedaapplication.remote.model.request.RefreshRequest
import com.example.vedaapplication.remote.model.response.AuthResponse

class SessionService {
    private val sessionApi: SessionApi by lazy {
        NetworkClient.retrofit.create(SessionApi::class.java)
    }

    suspend fun login(request: LoginRequest): AuthResponse {
        return sessionApi.login(request)
    }

    suspend fun logout(request: RefreshRequest) {
        return sessionApi.logout(request)
    }

    suspend fun refresh(request: RefreshRequest): AuthResponse {
        return sessionApi.refresh(request)
    }
}