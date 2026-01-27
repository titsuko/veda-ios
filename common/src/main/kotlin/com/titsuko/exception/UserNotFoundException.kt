package com.titsuko.exception

import org.springframework.http.HttpStatus

class UserNotFoundException(email: String) :
    AppException(HttpStatus.NOT_FOUND, "User with email $email not found")