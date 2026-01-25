package com.titsuko.server.service

import com.titsuko.server.dto.request.LoginRequest
import com.titsuko.server.dto.request.RefreshRequest
import com.titsuko.server.dto.response.AuthResponse
import com.titsuko.server.exception.InvalidCredentialsException
import com.titsuko.server.exception.UserNotFoundException
import com.titsuko.server.repository.UserRepository
import com.titsuko.server.security.HashEncoder
import com.titsuko.server.security.JwtService
import com.titsuko.server.security.RefreshService
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class SessionService(
    private val userRepository: UserRepository,
    private val hashEncoder: HashEncoder,
    private val jwtService: JwtService,
    private val refreshService: RefreshService
) {

    @Transactional
    fun login(request: LoginRequest): AuthResponse {
        val user = userRepository.findByEmail(requireNotNull(request.email))
            ?: throw UserNotFoundException(requireNotNull(request.email))

        if (!hashEncoder.matches(requireNotNull(request.password), user.password)) {
            throw InvalidCredentialsException()
        }

        val accessToken = jwtService.generateAccessToken(user.email)
        val refreshToken = refreshService.createToken(user)

        return AuthResponse(
            accessToken.first,
            refreshToken,
            expiresIn = accessToken.second
        )
    }

    @Transactional
    fun logout(request: RefreshRequest) {
        refreshService.revokeToken(requireNotNull(request.token))
    }

    @Transactional
    fun refresh(request: RefreshRequest): AuthResponse {
        val (user, refreshToken) = refreshService.rotateToken(requireNotNull(request.token))
        val accessToken = jwtService.generateAccessToken(user.email)

        return AuthResponse(
            accessToken.first,
            refreshToken,
            expiresIn = accessToken.second
        )
    }
}