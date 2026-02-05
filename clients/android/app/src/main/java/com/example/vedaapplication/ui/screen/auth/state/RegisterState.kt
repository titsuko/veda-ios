package com.example.vedaapplication.ui.screen.auth.state

import com.example.vedaapplication.remote.model.request.RegisterRequest

data class RegisterState(
    val fullName: String = "",
    val email: String = "",
    val password: String = "",
    var isLoading: Boolean = false,
    val errorMessage: String? = null
) {
    val isButtonEnabled: Boolean
        get() = email.isNotEmpty() && password.isNotEmpty() && fullName.isNotEmpty()

    fun toRequest(): RegisterRequest = RegisterRequest(fullName, email, password)
}