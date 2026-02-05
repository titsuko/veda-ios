package com.titsuko.controller

import com.titsuko.dto.request.LoginRequest
import com.titsuko.dto.request.RefreshRequest
import com.titsuko.dto.response.AuthResponse
import com.titsuko.service.SessionService
import jakarta.validation.Valid
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/sessions")
class SessionController(
    private val sessionService: SessionService
) {

    @PostMapping
    fun login(@Valid @RequestBody request: LoginRequest): AuthResponse {
        return sessionService.login(request)
    }

    @DeleteMapping("/logout")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    fun logout(@Valid @RequestBody request: RefreshRequest) {
        sessionService.logout(request)
    }

    @PostMapping("/refresh")
    fun refresh(@Valid @RequestBody request: RefreshRequest): AuthResponse {
        return sessionService.refresh(request)
    }
}