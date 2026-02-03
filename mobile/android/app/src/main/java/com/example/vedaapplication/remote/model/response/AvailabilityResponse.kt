package com.example.vedaapplication.remote.model.response

import kotlinx.serialization.Serializable

@Serializable
data class AvailabilityResponse(
    // true - email is available, false - email is not available
    val available: Boolean,
    val message: String
)
