package com.example.vedaapplication.ui.navigation

import androidx.annotation.StringRes
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.LibraryBooks
import androidx.compose.material.icons.filled.Description
import androidx.compose.material.icons.filled.Settings
import androidx.compose.ui.graphics.vector.ImageVector
import com.example.vedaapplication.R

sealed class BottomNavItem(
    val route: String,
    @StringRes val titleResId: Int,
    val icon: ImageVector
) {
    data object Home : BottomNavItem(
        route = Screen.Home.route,
        titleResId = R.string.home_title,
        icon = Icons.AutoMirrored.Filled.LibraryBooks
    )

    data object Collections : BottomNavItem(
        route = Screen.Collection.route,
        titleResId = R.string.collections_title,
        icon = Icons.Filled.Description
    )

    data object Settings : BottomNavItem(
        route = Screen.Settings.route,
        titleResId = R.string.settings_title,
        icon = Icons.Filled.Settings
    )
}