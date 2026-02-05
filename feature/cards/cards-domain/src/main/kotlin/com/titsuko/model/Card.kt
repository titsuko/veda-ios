package com.titsuko.model

import com.titsuko.model.`object`.CardRarity
import com.titsuko.model.`object`.CardStatus
import jakarta.persistence.*

@Entity
@Table(name = "cards")
class Card(
    @Id
    @Column(name = "card_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(unique = true, nullable = false)
    var slug: String = "",

    @Column(nullable = false)
    var title: String = "",

    @Column(columnDefinition = "TEXT")
    var description: String? = null,

    @Column(columnDefinition = "TEXT")
    @Convert(converter = ContentConverter::class)
    var content: List<ContentBlock> = mutableListOf(),

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var status: CardStatus = CardStatus.Hidden,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var rarity: CardRarity = CardRarity.COMMON,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    var category: Category? = null
)