package com.example.vedaapplication.ui.navigation.graph

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import androidx.navigation.navigation
import com.example.vedaapplication.ui.navigation.Screen
import com.example.vedaapplication.ui.screen.home.HomeScreen

fun NavGraphBuilder.homeNavGraph(
    navController: NavHostController
) {
    navigation(
        startDestination = Screen.Home.route,
        route = "home_graph"
    ) {
        composable(Screen.Home.route) {
            HomeScreen()
        }
    }
}