package com.titsuko.server.security

import com.titsuko.server.dto.response.AuthResponse
import io.jsonwebtoken.Claims
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.security.Keys
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import java.util.Base64
import java.util.Date

@Service
class JwtService(
    @Value($$"${jwt.secret}") private val jwtSecret: String
) {
    private val secretKey = Keys.hmacShaKeyFor(Base64.getDecoder().decode(jwtSecret))

    private val accessExpiry = 15L * 60

    fun generateTokenResponse(email: String): AuthResponse {
        return AuthResponse(
            accessToken = generateToken(email, "access", accessExpiry),
            expiresIn = accessExpiry
        )
    }

    fun validateToken(token: String, expectedType: String): Claims? {
        val claims = parseAllClaims(token) ?: return null
        val actualType = claims["type"] as? String

        return if (actualType == expectedType) claims else null
    }

    private fun generateToken(email: String, type: String, expirySeconds: Long): String {
        val now = System.currentTimeMillis()
        return Jwts.builder()
            .subject(email)
            .claim("type", type)
            .issuedAt(Date(now))
            .expiration(Date(now + expirySeconds * 1000))
            .signWith(secretKey)
            .compact()
    }

    private fun parseAllClaims(token: String): Claims? {
        val rawToken = token.removePrefix("Bearer ").trim()
        return try {
            Jwts.parser()
                .verifyWith(secretKey)
                .build()
                .parseSignedClaims(rawToken)
                .payload
        } catch (_: Exception) {
            null
        }
    }
}
