package com.titsuko.repository

import com.titsuko.model.CardCategory
import org.springframework.data.jpa.repository.JpaRepository

interface CardCategoryRepository : JpaRepository<CardCategory, Long> {
    fun existsBySlug(slug: String): Boolean
}