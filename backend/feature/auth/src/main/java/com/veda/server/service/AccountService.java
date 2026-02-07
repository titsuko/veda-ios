package com.veda.server.service;

import com.veda.server.HashEncoder;
import com.veda.server.JwtService;
import com.veda.server.dto.request.CheckEmailRequest;
import com.veda.server.dto.request.RegisterRequest;
import com.veda.server.dto.response.AuthResponse;
import com.veda.server.dto.response.AvailabilityResponse;
import com.veda.server.exception.UserAlreadyExists;
import com.veda.server.model.User;
import com.veda.server.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final UserRepository userRepository;
    private final HashEncoder encoder;
    private final JwtService jwtService;
    private final TokenService tokenService;

    @Transactional
    public AuthResponse createAccount(RegisterRequest request) {
        if (userRepository.existsByEmail(request.email())) {
            throw new UserAlreadyExists("User already exists");
        }

        User user = new User();
        user.setEmail(request.email());
        user.setPassword(encoder.encode(request.password()));
        user.setCratedAt(Instant.now());
        user.setUpdatedAt(Instant.now());

        User savedUser = userRepository.save(user);

        String accessToken = jwtService.generateAccessToken(savedUser.getId().toString());
        String refreshToken = jwtService.generateRefreshToken(savedUser.getId().toString());

        tokenService.saveRefreshToken(savedUser, refreshToken, jwtService.getRefreshTokenValidityMs());

        return new AuthResponse(refreshToken, accessToken);
    }

    @Transactional(readOnly = true)
    public AvailabilityResponse checkEmail(CheckEmailRequest request) {
        boolean exists = userRepository.existsByEmail(request.email());
        return new AvailabilityResponse(!exists, exists ? "Email already exists" : null);
    }
}