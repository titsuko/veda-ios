package com.titsuko.exception

import org.springframework.http.HttpStatus

class CardNotFoundException :
    AppException(HttpStatus.NOT_FOUND, "Card not found")