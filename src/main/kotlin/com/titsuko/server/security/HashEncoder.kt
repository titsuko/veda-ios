package com.titsuko.server.security

import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Component

@Component
class HashEncoder(
    private val passwordEncoder: PasswordEncoder,
) {
    fun encode(raw: CharSequence): String? = passwordEncoder.encode(raw)

    fun matches(raw: CharSequence, encoder: String): Boolean =
        passwordEncoder.matches(raw, encoder)
}