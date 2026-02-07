package com.veda.server;

import com.veda.server.dto.request.LoginRequest;
import com.veda.server.dto.request.RefreshTokenRequest;
import com.veda.server.dto.response.AuthResponse;
import com.veda.server.event.UserAuthorizedEvent;
import com.veda.server.model.Token;
import com.veda.server.model.User;
import com.veda.server.repository.TokenRepository;
import com.veda.server.repository.UserRepository;
import com.veda.server.service.SessionService;
import com.veda.server.service.TokenService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class SessionServiceTest {

    @Mock private UserRepository userRepository;
    @Mock private TokenRepository tokenRepository;
    @Mock private JwtService jwtService;
    @Mock private TokenService tokenService;
    @Mock private HashEncoder encoder;
    @Mock private ApplicationEventPublisher eventPublisher;

    @InjectMocks
    private SessionService sessionService;

    @Test
    void loginUser_Success() {
        LoginRequest request = new LoginRequest("test@mail.com", "password");
        User user = new User();
        user.setId(1);
        user.setEmail("test@mail.com");
        user.setPassword("encoded_pass");

        when(userRepository.findByEmail(request.email())).thenReturn(Optional.of(user));
        when(encoder.matches(request.password(), user.getPassword())).thenReturn(true);
        when(jwtService.generateAccessToken("1")).thenReturn("access_token");
        when(jwtService.generateRefreshToken("1")).thenReturn("refresh_token");
        when(jwtService.getRefreshTokenValidityMs()).thenReturn(1000L);

        AuthResponse response = sessionService.loginUser(request);

        assertNotNull(response);
        assertEquals("access_token", response.accessToken());
        assertEquals("refresh_token", response.refreshToken());

        verify(eventPublisher).publishEvent(any(UserAuthorizedEvent.class));
        verify(tokenService).saveRefreshToken(eq(user), eq("refresh_token"), eq(1000L));
    }

    @Test
    void loginUser_UserNotFound() {
        LoginRequest request = new LoginRequest("unknown@mail.com", "pass");
        when(userRepository.findByEmail(request.email())).thenReturn(Optional.empty());

        ResponseStatusException ex = assertThrows(ResponseStatusException.class,
                () -> sessionService.loginUser(request));

        assertEquals(HttpStatus.UNAUTHORIZED, ex.getStatusCode());
        assertEquals("Invalid credentials", ex.getReason());
    }

    @Test
    void loginUser_WrongPassword() {
        LoginRequest request = new LoginRequest("test@mail.com", "wrong_pass");
        User user = new User();
        user.setPassword("encoded_real_pass");

        when(userRepository.findByEmail(request.email())).thenReturn(Optional.of(user));
        when(encoder.matches(request.password(), user.getPassword())).thenReturn(false);

        ResponseStatusException ex = assertThrows(ResponseStatusException.class,
                () -> sessionService.loginUser(request));

        assertEquals(HttpStatus.UNAUTHORIZED, ex.getStatusCode());
    }

    @Test
    void refreshToken_Success() {
        String oldTokenStr = "valid_old_refresh_token";
        RefreshTokenRequest request = new RefreshTokenRequest(oldTokenStr);

        User user = new User();
        user.setId(100);

        Token storedToken = new Token();
        storedToken.setUser(user);
        storedToken.setIsRevoked((byte) 0);

        when(jwtService.validateRefreshToken(oldTokenStr)).thenReturn(true);
        when(tokenRepository.findByToken(oldTokenStr)).thenReturn(Optional.of(storedToken));

        when(jwtService.generateAccessToken("100")).thenReturn("new_access");
        when(jwtService.generateRefreshToken("100")).thenReturn("new_refresh");

        AuthResponse response = sessionService.refreshToken(request);

        assertEquals("new_access", response.accessToken());
        assertEquals("new_refresh", response.refreshToken());

        verify(tokenService).revokeRefreshToken(storedToken);
        verify(tokenService).saveRefreshToken(eq(user), eq("new_refresh"), anyLong()); // Новый сохранен
    }

    @Test
    void refreshToken_InvalidSignature() {
        String tokenStr = "invalid_sign_token";
        when(jwtService.validateRefreshToken(tokenStr)).thenReturn(false);

        ResponseStatusException ex = assertThrows(ResponseStatusException.class,
                () -> sessionService.refreshToken(new RefreshTokenRequest(tokenStr)));

        assertEquals(HttpStatus.FORBIDDEN, ex.getStatusCode());
        assertEquals("Invalid refresh token", ex.getReason());

        verifyNoInteractions(tokenRepository);
    }

    @Test
    void refreshToken_NotFoundInDb() {
        String tokenStr = "valid_sign_but_missing_db";
        when(jwtService.validateRefreshToken(tokenStr)).thenReturn(true);
        when(tokenRepository.findByToken(tokenStr)).thenReturn(Optional.empty());

        ResponseStatusException ex = assertThrows(ResponseStatusException.class,
                () -> sessionService.refreshToken(new RefreshTokenRequest(tokenStr)));

        assertEquals(HttpStatus.FORBIDDEN, ex.getStatusCode());
        assertEquals("Token not found", ex.getReason());
    }

    @Test
    void refreshToken_AlreadyRevoked() {
        String tokenStr = "revoked_token";
        Token revokedToken = new Token();
        revokedToken.setIsRevoked((byte) 1);

        when(jwtService.validateRefreshToken(tokenStr)).thenReturn(true);
        when(tokenRepository.findByToken(tokenStr)).thenReturn(Optional.of(revokedToken));

        ResponseStatusException ex = assertThrows(ResponseStatusException.class,
                () -> sessionService.refreshToken(new RefreshTokenRequest(tokenStr)));

        assertEquals(HttpStatus.FORBIDDEN, ex.getStatusCode());
        assertEquals("Token revoked", ex.getReason());

        verify(tokenService, never()).saveRefreshToken(any(), any(), anyLong());
    }
}