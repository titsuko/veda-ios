package com.veda.server.dto.response;

public record AvailabilityResponse(
        boolean available,
        String message
) {
}
