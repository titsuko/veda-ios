package com.titsuko.model

import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import jakarta.persistence.AttributeConverter
import jakarta.persistence.Converter

@Converter
class ContentConverter : AttributeConverter<List<ContentBlock>, String> {

    private val mapper = jacksonObjectMapper()

    override fun convertToDatabaseColumn(attribute: List<ContentBlock>?): String {
        return try {
            if (attribute.isNullOrEmpty()) "[]"
            else mapper.writeValueAsString(attribute)
        } catch (e: Exception) {
            "[]"
        }
    }

    override fun convertToEntityAttribute(dbData: String?): List<ContentBlock> {
        if (dbData.isNullOrBlank()) return emptyList()
        return try {
            mapper.readValue(dbData, object : TypeReference<List<ContentBlock>>() {})
        } catch (e: Exception) {
            emptyList()
        }
    }
}