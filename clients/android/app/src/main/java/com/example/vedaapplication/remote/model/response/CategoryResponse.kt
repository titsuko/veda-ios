package com.example.vedaapplication.remote.model.response

import kotlinx.serialization.Serializable

@Serializable
data class CategoryResponse(
    val id: Long,
    val slug: String,
    val title: String,
    val description: String,
    val cardsCount: Int
)