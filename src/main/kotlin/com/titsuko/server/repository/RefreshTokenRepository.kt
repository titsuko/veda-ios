package com.titsuko.server.repository

import com.titsuko.server.model.RefreshToken
import org.springframework.data.jpa.repository.JpaRepository

interface RefreshTokenRepository : JpaRepository<RefreshToken, Long> {
    fun deleteByToken(token: String)
    fun findByToken(token: String): RefreshToken?
}
