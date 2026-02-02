package com.titsuko.repository

import com.titsuko.model.RefreshToken
import org.springframework.data.jpa.repository.JpaRepository

interface RefreshTokenRepository : JpaRepository<RefreshToken, Long> {
    fun deleteByToken(token: String)
    fun findByToken(token: String): RefreshToken?
}
