package com.titsuko.dto.response

import java.time.Instant

data class AccountResponse(
    val firstName: String,
    val lastName: String,
    val role: String,
    val createdAt: Instant?
)
