package com.example.vedaapplication.remote.model.request

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class RegisterRequest(
    @SerialName("fullName")
    val name: String,
    val email: String,
    val password: String
)
