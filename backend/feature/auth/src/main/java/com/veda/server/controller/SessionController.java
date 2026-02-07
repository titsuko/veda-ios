package com.veda.server.controller;

import com.veda.server.dto.request.LoginRequest;
import com.veda.server.dto.request.RefreshTokenRequest;
import com.veda.server.dto.response.AuthResponse;
import com.veda.server.service.SessionService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/sessions")
public class SessionController {

    private final SessionService sessionService;

    @PostMapping
    public AuthResponse loginUser(@Valid @RequestBody LoginRequest request) {
        return sessionService.loginUser(request);
    }

    @PostMapping("/refresh")
    public AuthResponse refreshToken(@Valid @RequestBody RefreshTokenRequest request) {
        return sessionService.refreshToken(request);
    }
}
