package com.titsuko.dto.response

import com.titsuko.model.ContentBlock

data class CardResponse(
    val id: Long,
    val slug: String,
    val title: String,
    val description: String?,
    val content: List<ContentBlock>?,
    val status: String,
    val rarity: String,
    val category: CategoryResponse?
)