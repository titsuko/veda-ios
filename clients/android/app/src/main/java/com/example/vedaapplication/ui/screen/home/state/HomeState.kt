package com.example.vedaapplication.ui.screen.home.state

import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector

data class HomeState(
    val categories: List<CategoryUi> = emptyList(),
    val isLoading: Boolean = true,
    val errorMessage: String? = null
)

data class CategoryUi(
    val id: Long,
    val title: String,
    val description: String,
    val cardsCount: Int,
    val icon: ImageVector,
    val color: Color
)