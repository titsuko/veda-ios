package com.example.vedaapplication.ui.navigation

sealed class Screen(val route: String) {
    data object AuthGraph : Screen("auth_graph")

    data object Welcome : Screen("welcome")
    data object Login : Screen("login")
    data object Register : Screen("register")
    data object Home : Screen("home")
    data object ServerError : Screen("server_error")
}