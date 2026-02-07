package com.veda.server.exception;

import org.springframework.http.HttpStatus;

public class UserAlreadyExists extends AppException {

    public UserAlreadyExists(String message) {
        super(message, HttpStatus.CONFLICT);
    }

    public UserAlreadyExists(String message, HttpStatus status) {
        super(message, status);
    }
}
