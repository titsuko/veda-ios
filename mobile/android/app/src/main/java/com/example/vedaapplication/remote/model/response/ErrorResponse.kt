package com.example.vedaapplication.remote.model.response

import kotlinx.serialization.Serializable

@Serializable
data class ErrorResponse(
    val status: Int? = null,
    val message: String? = null
)
