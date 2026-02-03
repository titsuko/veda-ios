package com.example.vedaapplication.remote.api

import com.example.vedaapplication.remote.model.response.HealthResponse
import retrofit2.http.GET

interface HealthApi {
    @GET("health")
    suspend fun getStatus(): HealthResponse
}