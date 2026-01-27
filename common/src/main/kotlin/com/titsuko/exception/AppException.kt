package com.titsuko.exception

import org.springframework.http.HttpStatus

abstract class AppException(
    val status: HttpStatus,
    override val message: String
): RuntimeException(message)
