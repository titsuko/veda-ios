package com.example.vedaapplication.ui.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.rememberNavController
import com.example.vedaapplication.ui.navigation.graph.authNavGraph
import com.example.vedaapplication.ui.navigation.graph.homeNavGraph

@Composable
fun Navigation(
    navController: NavHostController = rememberNavController(),
    startDestination: String
) {
    NavHost(
        navController = navController,
        startDestination = startDestination
    ) {
        authNavGraph(navController)
        homeNavGraph(navController)
    }
}
