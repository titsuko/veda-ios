package com.example.vedaapplication.remote.model.response

import kotlinx.serialization.Serializable

@Serializable
data class AuthResponse(
    val accessToken: String,
    val refreshToken: String,
    val expiresIn: Long
)
