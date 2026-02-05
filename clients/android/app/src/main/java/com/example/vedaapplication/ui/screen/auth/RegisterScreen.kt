package com.example.vedaapplication.ui.screen.auth

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
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
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.vedaapplication.R
import com.example.vedaapplication.local.TokenManager
import com.example.vedaapplication.remote.model.request.CheckEmailRequest
import com.example.vedaapplication.remote.service.AccountService
import com.example.vedaapplication.ui.component.AppButton
import com.example.vedaapplication.ui.component.AppDialog
import com.example.vedaapplication.ui.component.AppTextField
import com.example.vedaapplication.ui.screen.auth.component.AuthHeader
import com.example.vedaapplication.ui.screen.auth.state.RegisterState
import com.example.vedaapplication.util.ErrorHandler
import kotlinx.coroutines.launch

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RegisterScreen(
    onBackClick: () -> Unit,
    onRedirect: () -> Unit,
    onRegisterSuccess: () -> Unit
) {
    val context = LocalContext.current
    val scope = rememberCoroutineScope()

    val accountService = remember { AccountService() }
    val tokenManager = remember { TokenManager(context) }

    var state by remember { mutableStateOf(RegisterState()) }

    if (state.errorMessage != null) {
        AppDialog(
            onConfirmation = { state = state.copy(errorMessage = null) },
            dialogTitle = stringResource(id = R.string.error_title),
            dialogText = state.errorMessage!!
        )
    }

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
                title = stringResource(R.string.create_account),
                subtitle = stringResource(R.string.register_subtitle)
            )

            Spacer(modifier = Modifier.height(26.dp))

            Column(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                AppTextField(
                    value = state.fullName,
                    onValueChange = { state = state.copy(fullName = it) },
                    label = stringResource(R.string.full_name),
                    imeAction = ImeAction.Next
                )

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
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Text(text = stringResource(R.string.already_have_account))
                        TextButton(
                            onClick = onRedirect,
                            contentPadding = PaddingValues(horizontal = 4.dp)
                        ) {
                            Text(
                                text = stringResource(R.string.login),
                                style = MaterialTheme.typography.bodyLarge,
                                color = MaterialTheme.colorScheme.primary
                            )
                        }
                    }
                }
            }

            Spacer(modifier = Modifier.weight(1f))

            AppButton(
                modifier = Modifier.fillMaxWidth(),
                enabled = state.isButtonEnabled && !state.isLoading,
                onClick = {
                    scope.launch {
                        state = state.copy(isLoading = true, errorMessage = null)
                        try {
                            val emailCheckResponse = accountService.checkEmail(
                                CheckEmailRequest(state.email)
                            )

                            if (!emailCheckResponse.available) {
                                state = state.copy(
                                    isLoading = false,
                                    errorMessage = context.getString(R.string.email_already_registered)
                                )
                                return@launch
                            }

                            val authResponse = accountService.register(state.toRequest())

                            tokenManager.saveTokens(
                                accessToken = authResponse.accessToken,
                                refreshToken = authResponse.refreshToken
                            )

                            state = state.copy(isLoading = false)
                            onRegisterSuccess()
                        } catch (e: Exception) {
                            state = state.copy(
                                isLoading = false,
                                errorMessage = ErrorHandler.getUserMessage(context, e)
                            )
                        }
                    }
                },
                title = stringResource(R.string.register_button)
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
private fun RegisterScreenPreview() {
    RegisterScreen(
        onBackClick = {},
        onRedirect = {},
        onRegisterSuccess = {}
    )
}