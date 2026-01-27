package com.titsuko.model

data class ErrorResponse(
    val status: Int = 0,
    val message: String? = null
)