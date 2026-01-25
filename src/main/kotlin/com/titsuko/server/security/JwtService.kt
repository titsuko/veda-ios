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

    fun generateAccessToken(email: String): Pair<String, Long> {
        val now = System.currentTimeMillis()
        return Jwts.builder()
            .subject(email)
            .issuedAt(Date(now))
            .expiration(Date(now + accessExpiry * 1000))
            .signWith(secretKey)
            .compact() to accessExpiry
    }

    fun extractEmail(token: String): String? {
        return getClaims(token)?.subject
    }

    fun isTokenValid(token: String): Boolean {
        val claims = getClaims(token) ?: return false
        return !claims.expiration.before(Date())
    }

    private fun getClaims(token: String): Claims? {
        return try {
            Jwts.parser()
                .verifyWith(secretKey)
                .build()
                .parseSignedClaims(token)
                .payload
        } catch (e: Exception) {
            null
        }
    }
}
