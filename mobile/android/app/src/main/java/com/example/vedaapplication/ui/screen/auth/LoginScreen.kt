package com.example.vedaapplication.ui.screen.auth

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.vedaapplication.R
import com.example.vedaapplication.remote.service.SessionService
import com.example.vedaapplication.ui.component.AppButton
import com.example.vedaapplication.ui.component.AppTextField
import com.example.vedaapplication.ui.screen.auth.component.AuthHeader
import com.example.vedaapplication.ui.screen.auth.state.LoginState
import kotlinx.coroutines.launch

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun LoginScreen(
    onBackClick: () -> Unit,
    onRedirect: () -> Unit,
    onLoginSuccess: () -> Unit
) {
    val scope = rememberCoroutineScope()
    val sessionService: SessionService = remember { SessionService() }
    var state by remember { mutableStateOf(LoginState()) }

    Scaffold(
        topBar = {
            TopAppBar(
                title = {},
                navigationIcon = {
                    IconButton(onClick = onBackClick) {
                        Icon(
                            Icons.AutoMirrored.Filled.ArrowBack,
                            contentDescription = stringResource(R.string.back)
                        )
                    }
                }
            )
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .padding(horizontal = 24.dp, vertical = 20.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            AuthHeader(
                title = stringResource(R.string.login_to_account),
                subtitle = stringResource(R.string.login_subtitle)
            )

            Spacer(modifier = Modifier.height(26.dp))

            Column(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                AppTextField(
                    value = state.email,
                    onValueChange = { state = state.copy(email = it) },
                    label = stringResource(R.string.email),
                    imeAction = ImeAction.Next
                )

                AppTextField(
                    value = state.password,
                    onValueChange = { state = state.copy(password = it) },
                    label = stringResource(R.string.password),
                    isPassword = true,
                    imeAction = ImeAction.Done
                )

                Column(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalAlignment = Alignment.End
                ) {
                    TextButton(
                        onClick = onRedirect,
                        contentPadding = PaddingValues(0.dp)
                    ) {
                        Text(
                            text = stringResource(R.string.no_account),
                            style = MaterialTheme.typography.bodyLarge,
                            color = MaterialTheme.colorScheme.primary
                        )
                    }
                }

                if (state.errorMessage != null) {
                    Text(
                        text = state.errorMessage!!,
                        color = Color.Red
                    )
                }
            }

            Spacer(modifier = Modifier.weight(1f))

            AppButton(
                modifier = Modifier.fillMaxWidth(),
                enabled = state.isButtonEnabled || state.isLoading,
                onClick = {
                    scope.launch {
                        state = state.copy(isLoading = true, errorMessage = null)

                        try {
                            val request = state.toRequest()
                            val response = sessionService.login(request)

                            state = state.copy(isLoading = false)

                            println(response.accessToken)
                            onLoginSuccess()
                        }
                        catch (e: Exception) {
                            state = state.copy(
                                isLoading = false,
                                errorMessage = e.localizedMessage ?: "Error login"
                            )
                        }
                    }
                },
                title = stringResource(R.string.login)
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
private fun LoginScreenPreview() {
    LoginScreen(onBackClick = {}, onRedirect = {}, onLoginSuccess = {})
}
