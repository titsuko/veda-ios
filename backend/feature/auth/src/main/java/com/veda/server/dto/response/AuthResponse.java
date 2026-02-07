package com.veda.server.dto.response;

public record AuthResponse(
        String refreshToken,
        String accessToken
) {
}
