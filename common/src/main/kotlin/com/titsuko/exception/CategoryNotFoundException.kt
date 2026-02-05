package com.titsuko.exception

import org.springframework.http.HttpStatus

class CategoryNotFoundException :
    AppException(HttpStatus.NOT_FOUND, "Category not found")