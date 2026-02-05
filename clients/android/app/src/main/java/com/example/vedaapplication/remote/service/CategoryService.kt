package com.example.vedaapplication.remote.service

import com.example.vedaapplication.di.NetworkClient
import com.example.vedaapplication.remote.api.CategoryApi
import com.example.vedaapplication.remote.model.response.CategoryResponse

class CategoryService {
    private val categoryApi: CategoryApi by lazy {
        NetworkClient.retrofit.create(CategoryApi::class.java)
    }

    suspend fun getCategories(): List<CategoryResponse> {
        return categoryApi.getCategories()
    }
}