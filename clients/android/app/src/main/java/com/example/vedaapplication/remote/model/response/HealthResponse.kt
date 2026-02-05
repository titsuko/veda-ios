package com.example.vedaapplication.remote.model.response

import kotlinx.serialization.Serializable

@Serializable
data class HealthResponse(
    val status: String,
    val message: String? = null
)
