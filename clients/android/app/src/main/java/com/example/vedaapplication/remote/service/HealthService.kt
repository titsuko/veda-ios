package com.example.vedaapplication.remote.service

import com.example.vedaapplication.di.NetworkClient
import com.example.vedaapplication.remote.api.HealthApi
import com.example.vedaapplication.remote.model.response.HealthResponse

class HealthService {
    private val healthApi: HealthApi by lazy {
        NetworkClient.retrofit.create(HealthApi::class.java)
    }

    suspend fun healthCheck(): HealthResponse {
        return healthApi.getStatus()
    }
}