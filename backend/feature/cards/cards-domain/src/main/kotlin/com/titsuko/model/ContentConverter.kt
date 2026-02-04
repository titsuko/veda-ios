package com.titsuko.model

import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import jakarta.persistence.AttributeConverter
import jakarta.persistence.Converter

@Converter
class ContentConverter : AttributeConverter<List<ContentBlock>, String> {

    private val objectMapper = jacksonObjectMapper()

    override fun convertToDatabaseColumn(attribute: List<ContentBlock>?): String {
        return try {
            objectMapper.writeValueAsString(attribute ?: emptyList<ContentBlock>())
        } catch (e: Exception) {
            "[]"
        }
    }

    override fun convertToEntityAttribute(dbData: String?): List<ContentBlock> {
        if (dbData.isNullOrBlank()) {
            return mutableListOf()
        }
        return try {
            objectMapper.readValue(dbData, object : TypeReference<List<ContentBlock>>() {})
        } catch (e: Exception) {
            mutableListOf()
        }
    }
}