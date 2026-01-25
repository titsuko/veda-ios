package com.titsuko.server.service

import com.titsuko.server.dto.request.CheckEmailRequest
import com.titsuko.server.dto.request.RegisterRequest
import com.titsuko.server.dto.response.AccountResponse
import com.titsuko.server.dto.response.AuthResponse
import com.titsuko.server.dto.response.AvailabilityResponse
import com.titsuko.server.exception.InvalidTokenException
import com.titsuko.server.exception.UserAlreadyExistsException
import com.titsuko.server.exception.UserNotFoundException
import com.titsuko.server.model.Profile
import com.titsuko.server.model.User
import com.titsuko.server.repository.ProfileRepository
import com.titsuko.server.repository.UserRepository
import com.titsuko.server.security.HashEncoder
import com.titsuko.server.security.JwtService
import com.titsuko.server.security.RefreshService
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class AccountService(
    private val userRepository: UserRepository,
    private val profileRepository: ProfileRepository,
    private val jwtService: JwtService,
    private val refreshService: RefreshService,
    private val hashEncoder: HashEncoder
) {

    @Transactional
    fun register(request: RegisterRequest): AuthResponse {
        if (userRepository.findByEmail(requireNotNull(request.email)) != null) {
            throw UserAlreadyExistsException()
        }

        val hashedPassword = hashEncoder.encode(requireNotNull(request.password)).toString()
        val (firstName, lastName) = parseFullName(requireNotNull(request.fullName))

        val profile = profileRepository.save(Profile(
            firstName = firstName,
            lastName = lastName
        ))

        val user = userRepository.save(User(
            email = request.email,
            password = hashedPassword,
            profile = profile
        ))

        val accessToken = jwtService.generateAccessToken(user.email)
        val refreshToken = refreshService.createToken(user)

        return AuthResponse(
            accessToken = accessToken.first,
            refreshToken = refreshToken,
            expiresIn = accessToken.second
        )
    }

    private fun parseFullName(fullName: String): Pair<String, String> {
        val parts = fullName.trim().split("\\s+".toRegex(), 2)
        return parts[0] to (parts.getOrNull(1) ?: "")
    }

    @Transactional(readOnly = true)
    fun getProfile(): AccountResponse {
        val authentication = SecurityContextHolder.getContext().authentication
        val email = authentication?.name
            ?: throw InvalidTokenException("Session expired or invalid")

        val user = userRepository.findByEmail(email)
            ?: throw UserNotFoundException(email)

        return AccountResponse(
            firstName = user.profile.firstName,
            lastName = user.profile.lastName,
            createdAt = user.createdAt
        )
    }

    @Transactional(readOnly = true)
    fun checkEmail(request: CheckEmailRequest): AvailabilityResponse {
        val exists = userRepository.findByEmail(requireNotNull(request.email)) != null
        return AvailabilityResponse(
            available = !exists,
            message = if (exists) "Email already exists" else "Email is available"
        )
    }
}
