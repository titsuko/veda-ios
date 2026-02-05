package com.example.vedaapplication.local

import android.content.Context
import androidx.core.content.edit

class SettingsManager(context: Context) {

    private val sharedPreferences = context.getSharedPreferences("app_settings", Context.MODE_PRIVATE)

    fun saveLanguage(languageCode: String) {
        sharedPreferences.edit {
            putString("app_language", languageCode)
        }
    }

    fun getLanguage(): String {
        return sharedPreferences.getString("app_language", "ru") ?: "ru"
    }

    fun saveThemeMode(isDark: Boolean) {
        sharedPreferences.edit {
            putBoolean("app_is_dark_theme", isDark)
        }
    }

    fun isDarkTheme(): Boolean {
        return sharedPreferences.getBoolean("app_is_dark_theme", false)
    }
}