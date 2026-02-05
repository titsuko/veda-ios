package com.example.vedaapplication.ui.theme

import android.app.Activity
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalView
import androidx.core.view.WindowCompat

// Настройка темной темы
private val DarkColorScheme = darkColorScheme(
    primary = ButtonColor,             // Синий остается синим
    onPrimary = Color.White,
    secondary = ButtonClearColorDark,  // Темно-серый для второстепенных кнопок
    onSecondary = PrimaryTextDark,
    background = BackgroundColorDark,  // Почти черный
    onBackground = PrimaryTextDark,    // Светлый текст
    surface = SurfaceDark,
    onSurface = PrimaryTextDark,
    surfaceVariant = ButtonClearColorDark,
    onSurfaceVariant = PrimaryTextDark
)

// Настройка светлой темы (Использует ваши цвета)
private val LightColorScheme = lightColorScheme(
    primary = ButtonColor,
    onPrimary = Color.White,           // Текст на синей кнопке
    secondary = ButtonClearColor,
    onSecondary = PrimaryText,
    background = BackgroundColor,
    onBackground = PrimaryText,
    surface = BackgroundColor,         // Или SnowWhite, если хотите отличие фона от карточек
    onSurface = PrimaryText,
    surfaceVariant = SnowWhite,        // Добавил SnowWhite сюда для карточек
    onSurfaceVariant = PrimaryText
)

@Composable
fun VedaApplicationTheme(
    darkTheme: Boolean = isSystemInDarkTheme(), // Автоматически определяем тему системы
    content: @Composable () -> Unit
) {
    val colorScheme = if (darkTheme) DarkColorScheme else LightColorScheme
    val view = LocalView.current

    if (!view.isInEditMode) {
        SideEffect {
            val window = (view.context as Activity).window
            // Красим статус бар в цвет фона
            window.statusBarColor = colorScheme.background.toArgb()
            window.navigationBarColor = colorScheme.background.toArgb()

            // Управляем цветом иконок статус бара (черные или белые)
            WindowCompat.getInsetsController(window, view).apply {
                isAppearanceLightStatusBars = !darkTheme
                isAppearanceLightNavigationBars = !darkTheme
            }
        }
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography,
        content = content
    )
}