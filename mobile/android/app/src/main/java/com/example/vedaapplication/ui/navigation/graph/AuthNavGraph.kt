package com.example.vedaapplication.ui.navigation.graph

import androidx.compose.animation.AnimatedContentTransitionScope
import androidx.compose.animation.core.tween
import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import androidx.navigation.navigation
import com.example.vedaapplication.ui.navigation.Screen
import com.example.vedaapplication.ui.screen.auth.AuthScreen
import com.example.vedaapplication.ui.screen.auth.LoginScreen
import com.example.vedaapplication.ui.screen.auth.RegisterScreen

fun NavGraphBuilder.authNavGraph(
    navController: NavHostController
) {
    navigation(
        startDestination = Screen.Welcome.route,
        route = Screen.AuthGraph.route
    ) {
        composable(
            route = Screen.Welcome.route,
            exitTransition = {
                slideOutOfContainer(
                    towards = AnimatedContentTransitionScope.SlideDirection.Left,
                    animationSpec = tween(500)
                )
            },
            enterTransition = {
                slideIntoContainer(
                    towards = AnimatedContentTransitionScope.SlideDirection.Right,
                    animationSpec = tween(400)
                )
            },
        ) {
            AuthScreen(
                onLoginClick = { navController.navigate(Screen.Login.route) },
                onRegisterClick = { navController.navigate(Screen.Register.route) }
            )
        }

        composable(
            route = Screen.Login.route,
            enterTransition = {
                slideIntoContainer(
                    towards = AnimatedContentTransitionScope.SlideDirection.Left,
                    animationSpec = tween(500)
                )
            },
            popExitTransition = {
                slideOutOfContainer(
                    towards = AnimatedContentTransitionScope.SlideDirection.Right,
                    animationSpec = tween(500)
                )
            }
        ) {
            LoginScreen(
                onBackClick = {
                    navController.popBackStack()
                },
                onRedirect = {
                    navController.navigate(Screen.Register.route)
                },
                onLoginSuccess = {
                    navController.navigate(Screen.Home.route)
                }
            )
        }

        composable(
            route = Screen.Register.route,
            enterTransition = {
                slideIntoContainer(
                    towards = AnimatedContentTransitionScope.SlideDirection.Left,
                    animationSpec = tween(500)
                )
            },
            popExitTransition = {
                slideOutOfContainer(
                    towards = AnimatedContentTransitionScope.SlideDirection.Right,
                    animationSpec = tween(500)
                )
            }
        ) {
            RegisterScreen(
                onBackClick = {
                    navController.popBackStack()
                },
                onRedirect = {
                    navController.navigate(Screen.Login.route)
                },
                onRegisterSuccess = {
                    navController.navigate(Screen.Home.route)
                }
            )
        }
    }
}
