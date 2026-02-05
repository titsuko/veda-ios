package com.example.vedaapplication.remote.api

import com.example.vedaapplication.remote.model.response.CategoryResponse
import retrofit2.http.GET

interface CategoryApi {
    @GET("categories")
    suspend fun getCategories(): List<CategoryResponse>
}