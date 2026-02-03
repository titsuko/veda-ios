package com.example.vedaapplication.remote.service

import com.example.vedaapplication.di.NetworkClient
import com.example.vedaapplication.remote.api.AccountApi
import com.example.vedaapplication.remote.model.request.CheckEmailRequest
import com.example.vedaapplication.remote.model.request.RegisterRequest
import com.example.vedaapplication.remote.model.response.AuthResponse
import com.example.vedaapplication.remote.model.response.AvailabilityResponse

class AccountService {
    private val accountApi: AccountApi by lazy {
        NetworkClient.retrofit.create(AccountApi::class.java)
    }

    suspend fun register(request: RegisterRequest): AuthResponse {
        return accountApi.register(request)
    }

    suspend fun checkEmail(request: CheckEmailRequest): AvailabilityResponse {
        return accountApi.checkEmail(request)
    }
}