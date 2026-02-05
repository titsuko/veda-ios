package com.example.vedaapplication.ui.screen.settings

import android.app.Activity
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.Logout
import androidx.compose.material.icons.filled.DarkMode
import androidx.compose.material.icons.filled.Language
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import androidx.navigation.NavGraph.Companion.findStartDestination
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.example.vedaapplication.R
import com.example.vedaapplication.local.SettingsManager
import com.example.vedaapplication.local.TokenManager
import com.example.vedaapplication.remote.model.request.RefreshRequest
import com.example.vedaapplication.remote.model.response.AccountResponse
import com.example.vedaapplication.remote.service.AccountService
import com.example.vedaapplication.remote.service.SessionService
import com.example.vedaapplication.ui.component.AppBottomBar
import com.example.vedaapplication.ui.navigation.Screen
import com.example.vedaapplication.ui.screen.home.component.HomeHeader
import com.example.vedaapplication.ui.screen.settings.component.LogoutDialog
import com.example.vedaapplication.ui.screen.settings.component.ProfileCard
import com.example.vedaapplication.ui.screen.settings.component.SettingsActionItem
import com.example.vedaapplication.ui.screen.settings.component.SettingsSwitchItem
import kotlinx.coroutines.launch

@Composable
fun SettingsScreen(
    navController: NavController
) {
    val context = LocalContext.current
    val scope = rememberCoroutineScope()
    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentRoute = navBackStackEntry?.destination?.route

    val tokenManager = remember { TokenManager(context) }
    val settingsManager = remember { SettingsManager(context) }
    val sessionService = remember { SessionService() }
    val accountService = remember { AccountService() }

    var profile by remember { mutableStateOf<AccountResponse?>(null) }
    var isLoading by remember { mutableStateOf(true) }
    var showLogoutDialog by remember { mutableStateOf(false) }

    var isDarkTheme by remember { mutableStateOf(settingsManager.isDarkTheme()) }

    val currentLangCode = remember { settingsManager.getLanguage() }
    val currentLangLabel = if (currentLangCode == "ru") "Русский" else "English"

    LaunchedEffect(Unit) {
        try {
            profile = accountService.getProfile()
        } catch (e: Exception) {
            e.printStackTrace()
        } finally {
            isLoading = false
        }
    }

    if (showLogoutDialog) {
        LogoutDialog(
            onDismiss = { showLogoutDialog = false },
            onConfirm = {
                scope.launch {
                    showLogoutDialog = false
                    try {
                        val refreshToken = tokenManager.getRefreshToken()
                        if (refreshToken != null) {
                            sessionService.logout(RefreshRequest(refreshToken))
                        }
                    } catch (e: Exception) {
                        e.printStackTrace()
                    } finally {
                        tokenManager.clearTokens()
                        navController.navigate(Screen.AuthGraph.route) {
                            popUpTo(0) { inclusive = true }
                            launchSingleTop = true
                        }
                    }
                }
            }
        )
    }

    Scaffold(
        bottomBar = {
            AppBottomBar(
                currentRoute = currentRoute,
                onNavigate = { route ->
                    navController.navigate(route) {
                        popUpTo(navController.graph.findStartDestination().id) {
                            saveState = true
                        }
                        launchSingleTop = true
                        restoreState = true
                    }
                }
            )
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .background(MaterialTheme.colorScheme.background),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            HomeHeader(
                title = R.string.settings_title,
                icon = Icons.Default.Settings,
                onSearchClick = {}
            )

            Spacer(modifier = Modifier.height(16.dp))

            if (isLoading) {
                Box(
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(100.dp),
                    contentAlignment = Alignment.Center
                ) {
                    CircularProgressIndicator()
                }
            } else {
                profile?.let { user ->
                    ProfileCard(
                        user = user,
                        modifier = Modifier.padding(horizontal = 16.dp)
                    )
                }
            }

            Spacer(modifier = Modifier.height(24.dp))

            Text(
                text = stringResource(R.string.app_settings),
                style = MaterialTheme.typography.titleMedium,
                color = MaterialTheme.colorScheme.primary,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 20.dp, vertical = 8.dp)
            )

            Card(
                modifier = Modifier.padding(horizontal = 16.dp),
                shape = RoundedCornerShape(16.dp),
                colors = CardDefaults.cardColors(
                    containerColor = MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.5f)
                )
            ) {
                Column {
                    SettingsSwitchItem(
                        icon = Icons.Default.DarkMode,
                        title = stringResource(R.string.dark_theme),
                        checked = isDarkTheme,
                        onCheckedChange = { isChecked ->
                            isDarkTheme = isChecked
                            settingsManager.saveThemeMode(isChecked)
                            (context as? Activity)?.recreate()
                        }
                    )

                    HorizontalDivider(
                        modifier = Modifier.padding(horizontal = 16.dp),
                        color = MaterialTheme.colorScheme.outlineVariant
                    )

                    SettingsActionItem(
                        icon = Icons.Default.Language,
                        title = stringResource(R.string.language),
                        value = currentLangLabel,
                        onClick = {
                            val newLang = if (currentLangCode == "ru") "en" else "ru"
                            settingsManager.saveLanguage(newLang)
                            (context as? Activity)?.recreate()
                        }
                    )
                }
            }

            Spacer(modifier = Modifier.height(24.dp))

            Card(
                modifier = Modifier.padding(horizontal = 16.dp),
                shape = RoundedCornerShape(16.dp),
                colors = CardDefaults.cardColors(
                    containerColor = MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.5f)
                )
            ) {
                SettingsActionItem(
                    icon = Icons.AutoMirrored.Filled.Logout,
                    title = stringResource(R.string.logout),
                    titleColor = MaterialTheme.colorScheme.error,
                    iconColor = MaterialTheme.colorScheme.error,
                    showArrow = false,
                    onClick = { showLogoutDialog = true }
                )
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
private fun SettingsScreenPreview() {
    SettingsScreen(navController = rememberNavController())
}