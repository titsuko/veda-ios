//
//  CardCategory+Mock.swift
//  veda
//
//  Created by Евгений Петрукович on 1/30/26.
//

import SwiftUI

extension CardCategory {

    static let mockCategories: [CardCategory] = [

        CardCategory(
            title: "Праздники",
            description: "Традиционные торжества и их смысл",
            quantity: 4,
            color: .orange,
            image: "sun.min",
            items: [
                CardItem(
                    title: "Цветок папоротника",
                    description: "Мифический цветок, который, по легенде, расцветает в ночь на Ивана Купалу и приносит удачу",
                    rarity: .epic
                ),
                CardItem(
                    title: "Ночь Ивана Купалы",
                    description: "Праздник летнего солнцестояния с кострами, гаданиями и древними обрядами",
                    rarity: .rare
                ),
                CardItem(
                    title: "Коляда",
                    description: "Зимний обрядовый праздник, связанный с рождением нового солнца",
                    rarity: .common
                ),
                CardItem(
                    title: "Масленица",
                    description: "Проводы зимы с блинами, гуляниями и сожжением чучела",
                    rarity: .rare
                ),
                CardItem(
                    title: "Дзяды",
                    description: "Древний обряд поминовения предков, сохранившийся в белорусской традиции",
                    rarity: .legendary
                )
            ]
        ),

        CardCategory(
            title: "Символы",
            description: "Знаки и их значения",
            quantity: 3,
            color: .green,
            image: "wand.and.sparkles",
            items: [
                CardItem(title: "Солнце", description: "Источник жизни", rarity: .legendary),
                CardItem(title: "Древо", description: "Связь миров", rarity: .rare)
            ]
        ),

        CardCategory(
            title: "Обряды",
            description: "Ритуалы и священные практики",
            quantity: 2,
            color: .red,
            image: "flame",
            items: []
        ),

        CardCategory(
            title: "Персонажи",
            description: "Мифологические образы и герои",
            quantity: 3,
            color: .purple,
            image: "person",
            items: []
        ),

        CardCategory(
            title: "Боги",
            description: "Высшие божества и покровители",
            quantity: 5,
            color: .blue,
            image: "crown",
            items: []
        ),

        CardCategory(
            title: "Места силы",
            description: "Священные пространства и земли",
            quantity: 4,
            color: .teal,
            image: "mountain.2",
            items: []
        ),

        CardCategory(
            title: "Амулеты",
            description: "Защитные символы и предметы",
            quantity: 6,
            color: .brown,
            image: "shield.lefthalf.filled",
            items: []
        ),

        CardCategory(
            title: "Календари",
            description: "Циклы времени и года",
            quantity: 2,
            color: .indigo,
            image: "calendar",
            items: []
        ),
        
        CardCategory(
            title: "Пророчества",
            description: "Предзнаменования и знаки судьбы",
            quantity: 3,
            color: .pink,
            image: "eye",
            items: []
        ),
        
        CardCategory(
            title: "Тотемы",
            description: "Духи-покровители и священные животные",
            quantity: 6,
            color: .green,
            image: "pawprint",
            items: []
        ),
        
        CardCategory(
            title: "Предания",
            description: "Легенды и устные сказания",
            quantity: 5,
            color: .mint,
            image: "book.closed",
            items: []
        ),
        
        CardCategory(
            title: "Стихии",
            description: "Первоосновы мира и природные силы",
            quantity: 4,
            color: .cyan,
            image: "wind",
            items: []
        )
    ]
}
