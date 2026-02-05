package com.titsuko.dto.request

import com.titsuko.model.ContentBlock
import com.titsuko.model.`object`.CardRarity
import com.titsuko.model.`object`.CardStatus
import jakarta.validation.constraints.NotBlank

data class CardRequest(
    @field:NotBlank(message = "Name is required")
    val title: String? = null,

    val slug: String? = null,
    val description: String? = null,

    val content: List<ContentBlock>? = null,

    val rarity: CardRarity? = null,
    val categoryId: Long? = null,

    @field:NotBlank(message = "Status is required")
    val status: CardStatus? = null
)