package com.titsuko.server.exception

import org.springframework.http.HttpStatus

class InvalidTokenException(message: String = "Token is invalid or expired") :
    AppException(HttpStatus.UNAUTHORIZED, message)