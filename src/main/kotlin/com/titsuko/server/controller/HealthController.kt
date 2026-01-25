package com.titsuko.server.controller

import com.titsuko.server.dto.response.HealthResponse
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/health")
class HealthController {

    @GetMapping
    fun getInfo(): HealthResponse {
        return HealthResponse(
            status = "UP",
            message = "Server is running"
        )
    }
}