package com.example.vedaapplication.ui.screen.home

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.DateRange
import androidx.compose.material.icons.filled.EmojiEvents
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Landscape
import androidx.compose.material.icons.filled.LocalFireDepartment
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.Security
import androidx.compose.material.icons.filled.Star
import androidx.compose.material.icons.filled.WbSunny
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
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import androidx.navigation.NavGraph.Companion.findStartDestination
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.example.vedaapplication.R
import com.example.vedaapplication.remote.service.CategoryService
import com.example.vedaapplication.ui.component.AppBottomBar
import com.example.vedaapplication.ui.screen.home.component.CardCategory
import com.example.vedaapplication.ui.screen.home.component.HomeHeader
import com.example.vedaapplication.ui.screen.home.state.CategoryUi
import com.example.vedaapplication.ui.screen.home.state.HomeState

@Composable
fun HomeScreen(
    navController: NavController
) {
    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentRoute = navBackStackEntry?.destination?.route

    val categoryService = remember { CategoryService() }
    var state by remember { mutableStateOf(HomeState()) }

    LaunchedEffect(Unit) {
        try {
            val response = categoryService.getCategories()

            val uiCategories = response.mapIndexed { index, item ->
                val style = getCategoryStyle(index)
                CategoryUi(
                    id = item.id,
                    title = item.title,
                    description = item.description,
                    cardsCount = item.cardsCount,
                    icon = style.first,
                    color = style.second
                )
            }

            state = state.copy(
                categories = uiCategories,
                isLoading = false
            )
        } catch (e: Exception) {
            state = state.copy(
                isLoading = false,
                errorMessage = e.localizedMessage ?: "Ошибка загрузки"
            )
        }
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
                .padding(paddingValues),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            HomeHeader(
                title = R.string.home_title,
                icon = Icons.Default.Home,
                onSearchClick = {}
            )

            Spacer(modifier = Modifier.height(8.dp))

            Box(modifier = Modifier.fillMaxSize()) {
                when {
                    state.isLoading -> {
                        CircularProgressIndicator(
                            modifier = Modifier.align(Alignment.Center)
                        )
                    }

                    state.errorMessage != null -> {
                        Text(
                            text = state.errorMessage ?: "Неизвестная ошибка",
                            color = Color.Red,
                            textAlign = TextAlign.Center,
                            modifier = Modifier.align(Alignment.Center)
                        )
                    }

                    state.categories.isEmpty() -> {
                        Text(
                            text = "Карточек пока нет",
                            style = MaterialTheme.typography.bodyLarge,
                            color = Color.Gray,
                            textAlign = TextAlign.Center,
                            modifier = Modifier.align(Alignment.Center)
                        )
                    }

                    else -> {
                        LazyColumn(
                            modifier = Modifier.fillMaxSize()
                        ) {
                            items(state.categories) { category ->
                                CardCategory(
                                    title = category.title,
                                    description = category.description,
                                    cardCount = category.cardsCount,
                                    icon = category.icon,
                                    iconColor = category.color
                                )

                                if (category != state.categories.last()) {
                                    HorizontalDivider(
                                        modifier = Modifier.padding(start = 80.dp, end = 16.dp),
                                        thickness = 0.5.dp,
                                        color = Color.LightGray.copy(alpha = 0.5f)
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

private fun getCategoryStyle(index: Int): Pair<ImageVector, Color> {
    val styles = listOf(
        Icons.Default.WbSunny to Color(0xFFFF9800),
        Icons.Default.Star to Color(0xFF4CAF50),
        Icons.Default.LocalFireDepartment to Color(0xFFF44336),
        Icons.Default.Person to Color(0xFFE040FB),
        Icons.Default.EmojiEvents to Color(0xFF2196F3),
        Icons.Default.Landscape to Color(0xFF00BCD4),
        Icons.Default.Security to Color(0xFF8D6E63),
        Icons.Default.DateRange to Color(0xFF7986CB)
    )
    return styles[index % styles.size]
}

@Preview(showBackground = true)
@Composable
private fun HomeScreenPreview() {
    HomeScreen(navController = rememberNavController())
}