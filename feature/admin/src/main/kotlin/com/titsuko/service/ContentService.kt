package com.titsuko.service

import com.titsuko.model.ContentBlock
import tools.jackson.databind.ObjectMapper
import com.titsuko.exception.CardNotFoundException
import com.titsuko.repository.CardRepository
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class ContentService(
    private val cardRepository: CardRepository,
    private val objectMapper: ObjectMapper
) {

    @Transactional(readOnly = true)
    fun getContentAsJson(cardId: Long): String {
        val card = cardRepository.findByIdOrNull(cardId)
            ?: throw CardNotFoundException()

        return if (card.content.isNotEmpty()) {
            objectMapper.writeValueAsString(card.content)
        } else {
            "[]"
        }
    }

    @Transactional
    fun updateContent(cardId: Long, newBlocks: List<ContentBlock>) {
        val card = cardRepository.findByIdOrNull(cardId)
            ?: throw CardNotFoundException()

        card.content = newBlocks

        cardRepository.save(card)
    }
}