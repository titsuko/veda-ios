package com.titsuko.dto.response

data class AuthResponse(
    val accessToken: String,
    val refreshToken: String,
    val expiresIn: Long
)
