package com.titsuko.server.dto.response

data class HealthResponse(
    val status: String,
    val message: String? = null
)