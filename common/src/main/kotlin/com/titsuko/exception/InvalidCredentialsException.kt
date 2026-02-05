package com.titsuko.exception

import org.springframework.http.HttpStatus

class InvalidCredentialsException(message: String = "Invalid email or password") :
    AppException(HttpStatus.UNAUTHORIZED, message)