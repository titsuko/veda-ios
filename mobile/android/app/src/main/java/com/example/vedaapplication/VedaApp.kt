package com.example.vedaapplication

import android.app.Application
import com.example.vedaapplication.di.NetworkClient

class VedaApp : Application() {
    override fun onCreate() {
        super.onCreate()
        NetworkClient.init(this)
    }
}