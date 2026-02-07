package com.veda.server.exception;

import org.springframework.http.HttpStatus;

public class InvalidTokenException extends AppException {

    public InvalidTokenException(String message, HttpStatus status) {
        super(message, status);
    }

    public InvalidTokenException(String message) {
        super(message, HttpStatus.FORBIDDEN);
    }
}
