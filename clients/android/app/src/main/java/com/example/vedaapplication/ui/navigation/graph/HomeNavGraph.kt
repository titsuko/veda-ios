package com.example.vedaapplication.ui.navigation.graph

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import androidx.navigation.navigation
import com.example.vedaapplication.ui.navigation.Screen
import com.example.vedaapplication.ui.screen.home.CollectionScreen
import com.example.vedaapplication.ui.screen.home.HomeScreen
import com.example.vedaapplication.ui.screen.settings.SettingsScreen

fun NavGraphBuilder.homeNavGraph(
    navController: NavHostController
) {
    navigation(
        startDestination = Screen.Home.route,
        route = Screen.HomeGraph.route
    ) {
        composable(route = Screen.Home.route) {
            HomeScreen(navController = navController)
        }

        composable(route = Screen.Collection.route) {
            CollectionScreen(navController = navController)
        }

        composable(route = Screen.Settings.route) {
            SettingsScreen(navController = navController)
        }
    }
}