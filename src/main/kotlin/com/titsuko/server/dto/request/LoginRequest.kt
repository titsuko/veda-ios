package com.titsuko.server.dto.request

import jakarta.validation.constraints.Email
import jakarta.validation.constraints.NotBlank
import jakarta.validation.constraints.Size

data class LoginRequest(
    @field:NotBlank(message = "Email is required")
    @field:Email(message = "Email should be valid")
    val email: String? = null,

    @field:NotBlank(message = "Password is required")
    @field:Size(min = 8, max = 50, message = "Password too short")
    val password: String? = null
)
