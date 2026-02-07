package com.veda.server.service;

import com.veda.server.HashEncoder;
import com.veda.server.JwtService;
import com.veda.server.dto.request.LoginRequest;
import com.veda.server.dto.request.RefreshTokenRequest;
import com.veda.server.dto.response.AuthResponse;
import com.veda.server.event.UserAuthorizedEvent;
import com.veda.server.exception.InvalidCredentialsException;
import com.veda.server.exception.InvalidTokenException;
import com.veda.server.model.Token;
import com.veda.server.model.User;
import com.veda.server.repository.TokenRepository;
import com.veda.server.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

@Service
@RequiredArgsConstructor
public class SessionService {

    private final UserRepository userRepository;
    private final TokenRepository tokenRepository;
    private final JwtService jwtService;
    private final TokenService tokenService;
    private final HashEncoder encoder;
    private final ApplicationEventPublisher eventPublisher;

    @Transactional
    public AuthResponse loginUser(LoginRequest request) {
        User user = userRepository.findByEmail(request.email())
                .orElseThrow(InvalidCredentialsException::new);

        if (!encoder.matches(request.password(), user.getPassword())) {
            throw new InvalidCredentialsException();
        }

        eventPublisher.publishEvent(new UserAuthorizedEvent(user));

        String accessToken = jwtService.generateAccessToken(user.getId().toString());
        String refreshToken = jwtService.generateRefreshToken(user.getId().toString());

        tokenService.saveRefreshToken(user, refreshToken, jwtService.getRefreshTokenValidityMs());

        return new AuthResponse(refreshToken, accessToken);
    }

    @Transactional
    public AuthResponse refreshToken(RefreshTokenRequest request) {
        String incomingRefreshToken = request.token();

        if (!jwtService.validateRefreshToken(incomingRefreshToken)) {
            throw new InvalidTokenException("Invalid refresh token");
        }

        Token storedToken = tokenRepository.findByToken(incomingRefreshToken)
                .orElseThrow(() -> new InvalidTokenException("Token not found"));

        if (storedToken.getIsRevoked() == 1) {
            throw new InvalidTokenException("Token has been revoked");
        }

        User user = storedToken.getUser();

        tokenService.revokeRefreshToken(storedToken);

        String newAccessToken = jwtService.generateAccessToken(user.getId().toString());
        String newRefreshToken = jwtService.generateRefreshToken(user.getId().toString());

        tokenService.saveRefreshToken(user, newRefreshToken, jwtService.getRefreshTokenValidityMs());

        return new AuthResponse(newRefreshToken, newAccessToken);
    }
}