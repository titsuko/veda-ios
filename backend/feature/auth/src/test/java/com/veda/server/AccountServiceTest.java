package com.veda.server;

import com.veda.server.dto.request.CheckEmailRequest;
import com.veda.server.dto.request.RegisterRequest;
import com.veda.server.dto.response.AuthResponse;
import com.veda.server.dto.response.AvailabilityResponse;
import com.veda.server.model.User;
import com.veda.server.repository.UserRepository;
import com.veda.server.service.AccountService;
import com.veda.server.service.TokenService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AccountServiceTest {

    @Mock
    private UserRepository userRepository;
    @Mock
    private HashEncoder encoder;
    @Mock
    private JwtService jwtService;
    @Mock
    private TokenService tokenService;

    @InjectMocks
    private AccountService accountService;

    @Test
    void createAccount_Success() {
        RegisterRequest request = new RegisterRequest("Test User", "test@example.com", "password123");
        User savedUser = new User();
        savedUser.setId(1);
        savedUser.setEmail(request.email());

        when(userRepository.existsByEmail(request.email())).thenReturn(false);
        when(encoder.encode(request.password())).thenReturn("encoded_password");
        when(userRepository.save(any(User.class))).thenReturn(savedUser);

        when(jwtService.generateAccessToken("1")).thenReturn("access_token_123");
        when(jwtService.generateRefreshToken("1")).thenReturn("refresh_token_123");
        when(jwtService.getRefreshTokenValidityMs()).thenReturn(1000L);

        AuthResponse response = accountService.createAccount(request);

        assertNotNull(response);
        assertEquals("access_token_123", response.accessToken());
        assertEquals("refresh_token_123", response.refreshToken());

        verify(userRepository).save(any(User.class));
        verify(tokenService).saveRefreshToken(eq(savedUser), eq("refresh_token_123"), eq(1000L));
    }

    @Test
    void createAccount_EmailTaken_ThrowsException() {
        RegisterRequest request = new RegisterRequest("Test", "taken@example.com", "pass");

        when(userRepository.existsByEmail(request.email())).thenReturn(true);

        RuntimeException exception = assertThrows(RuntimeException.class, () -> accountService.createAccount(request));

        assertEquals("User with email already exists", exception.getMessage());

        verify(userRepository, never()).save(any());
        verify(tokenService, never()).saveRefreshToken(any(), any(), anyLong());
    }

    @Test
    void checkEmail_Exists() {
        CheckEmailRequest request = new CheckEmailRequest("busy@mail.com");
        when(userRepository.existsByEmail(request.email())).thenReturn(true);

        AvailabilityResponse response = accountService.checkEmail(request);

        assertFalse(response.available());
        assertEquals("Email already exists", response.message());
    }

    @Test
    void checkEmail_NotExists() {
        CheckEmailRequest request = new CheckEmailRequest("free@mail.com");
        when(userRepository.existsByEmail(request.email())).thenReturn(false);

        AvailabilityResponse response = accountService.checkEmail(request);

        assertTrue(response.available());
        assertNull(response.message());
    }
}