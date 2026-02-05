package com.example.vedaapplication

import android.content.Context
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import androidx.navigation.compose.rememberNavController
import com.example.vedaapplication.local.SettingsManager
import com.example.vedaapplication.local.TokenManager
import com.example.vedaapplication.ui.navigation.Navigation
import com.example.vedaapplication.ui.navigation.Screen
import com.example.vedaapplication.ui.theme.VedaApplicationTheme
import com.example.vedaapplication.util.LocaleHelper

class MainActivity : ComponentActivity() {

    override fun attachBaseContext(newBase: Context) {
        val settingsManager = SettingsManager(newBase)
        val languageCode = settingsManager.getLanguage()
        super.attachBaseContext(LocaleHelper.onAttach(newBase, languageCode))
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        val tokenManager = TokenManager(applicationContext)
        val settingsManager = SettingsManager(applicationContext)

        val isDarkTheme = settingsManager.isDarkTheme()

        val startDestination = if (tokenManager.isUserLoggedIn) {
            Screen.HomeGraph.route
        } else {
            Screen.AuthGraph.route
        }

        setContent {
            VedaApplicationTheme(darkTheme = isDarkTheme) {
                Surface(modifier = Modifier.fillMaxSize()) {
                    val navController = rememberNavController()
                    Navigation(
                        navController = navController,
                        startDestination = startDestination
                    )
                }
            }
        }
    }
}