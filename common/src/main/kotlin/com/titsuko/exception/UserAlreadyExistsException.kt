package com.titsuko.exception

import org.springframework.http.HttpStatus

class UserAlreadyExistsException :
    AppException(HttpStatus.CONFLICT, "User already exists")