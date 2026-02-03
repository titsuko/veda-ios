package com.example.vedaapplication.remote.model.request

import kotlinx.serialization.Serializable

@Serializable
data class RefreshRequest(
    val token: String
)
