package com.titsuko

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping

@RestController
@RequestMapping("/api/health")
class HealthController {

    data class HealthResponse(
        val status: String,
        val message: String? = null
    )

    @GetMapping
    fun getInfo(): HealthResponse {
        return HealthResponse(
            status = "UP",
            message = "Server is running"
        )
    }
}
