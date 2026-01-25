package com.titsuko.server.exception

import org.springframework.http.HttpStatus

class UserAlreadyExistsException :
    AppException(HttpStatus.CONFLICT, "User already exists")