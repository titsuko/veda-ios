package com.example.vedaapplication.ui.screen.auth.state

import com.example.vedaapplication.remote.model.request.LoginRequest

data class LoginState(
    val email: String = "",
    val password: String = "",
    var isLoading: Boolean = false,
    val errorMessage: String? = null
) {
    val isButtonEnabled: Boolean
        get() = email.isNotEmpty() && password.isNotEmpty()

    fun toRequest(): LoginRequest = LoginRequest(email, password)
}
