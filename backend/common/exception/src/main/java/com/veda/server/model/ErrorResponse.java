package com.veda.server.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import java.time.Instant;

public record ErrorResponse(
        Instant timestamp,
        int status,
        String error,
        String message,
        String path,
        @JsonInclude(JsonInclude.Include.NON_NULL)
        Object details
) {
    public static ErrorResponse of(int status, String error, String message, String path) {
        return new ErrorResponse(Instant.now(), status, error, message, path, null);
    }

    public static ErrorResponse of(int status, String error, String message, String path, Object details) {
        return new ErrorResponse(Instant.now(), status, error, message, path, details);
    }
}