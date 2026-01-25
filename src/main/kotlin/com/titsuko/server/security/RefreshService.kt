package com.titsuko.server.security

import com.titsuko.server.exception.InvalidTokenException
import com.titsuko.server.model.RefreshToken
import com.titsuko.server.model.User
import com.titsuko.server.repository.RefreshTokenRepository
import jakarta.transaction.Transactional
import org.springframework.stereotype.Service
import java.security.SecureRandom
import java.time.Instant
import java.time.temporal.ChronoUnit
import java.util.Base64

@Service
class RefreshService(
    private val refreshTokenRepository: RefreshTokenRepository,
) {
    private val refreshExpiryDays: Long = 1
    private val secureRandom = SecureRandom()

    @Transactional
    fun createToken(user: User): String {
        val tokenString = generateRandomToken()
        val refreshToken = RefreshToken(
            user = user,
            token = tokenString,
            expiresAt = Instant.now().plus(refreshExpiryDays, ChronoUnit.DAYS)
        )

        refreshTokenRepository.save(refreshToken)
        return tokenString
    }

    @Transactional
    fun rotateToken(token: String): Pair<User, String> {
        val refreshToken = refreshTokenRepository.findByToken(token)
            ?: throw InvalidTokenException("Refresh token not found")

        if (refreshToken.isRevoked) {
            refreshTokenRepository.delete(refreshToken)
            throw InvalidTokenException("Potential fraud: Token already used")
        }

        if (refreshToken.expiresAt.isBefore(Instant.now())) {
            refreshTokenRepository.delete(refreshToken)
            throw InvalidTokenException("Refresh token expired")
        }

        val user = refreshToken.user

        refreshTokenRepository.delete(refreshToken)
        val newToken = createToken(user)

        return user to newToken
    }

    @Transactional
    fun revokeToken(token: String) {
        refreshTokenRepository.deleteByToken(token)
    }

    private fun generateRandomToken(): String {
        val bytes = ByteArray(64)
        secureRandom.nextBytes(bytes)
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes)
    }
}