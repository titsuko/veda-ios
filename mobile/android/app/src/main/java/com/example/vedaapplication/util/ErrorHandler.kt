package com.example.vedaapplication.util

import android.content.Context
import com.example.vedaapplication.R
import retrofit2.HttpException
import java.io.IOException
import java.net.SocketTimeoutException
import java.net.UnknownHostException

object ErrorHandler {

    fun getUserMessage(context: Context, e: Throwable): String {
        return when (e) {
            is HttpException -> getHttpErrorMessage(context, e.code())
            is SocketTimeoutException -> context.getString(R.string.error_timeout)
            is UnknownHostException, is IOException -> context.getString(R.string.error_no_internet)
            else -> context.getString(R.string.error_unknown)
        }
    }

    private fun getHttpErrorMessage(context: Context, code: Int): String {
        return when (code) {
            400 -> context.getString(R.string.error_invalid_input)
            401, 403, 404 -> context.getString(R.string.error_wrong_credentials)
            409 -> context.getString(R.string.error_conflict)
            in 500..599 -> context.getString(R.string.error_server_unavailable)
            else -> context.getString(R.string.error_unknown)
        }
    }
}