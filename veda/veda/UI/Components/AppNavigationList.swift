//
//  AppList.swift
//  veda
//
//  Created by Евгений Петрукович on 2/1/26.
//

import SwiftUI

struct NavigationList<Item, Row: View, Destination: View, Background: View>: View {
    let items: [Item]
    let row: (Item) -> Row
    let destination: (Item) -> Destination
    let background: (Item) -> Background

    init(
        items: [Item],
        @ViewBuilder row: @escaping (Item) -> Row,
        @ViewBuilder destination: @escaping (Item) -> Destination,
        @ViewBuilder background: @escaping (Item) -> Background
    ) {
        self.items = items
        self.row = row
        self.destination = destination
        self.background = background
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
                let item = items[index]

                VStack(spacing: 0) {
                    if index == 0 { Divider() }

                    NavigationLink(destination: destination(item)) {
                        row(item)
                    }
                    .buttonStyle(ButtonPressStyle())

                    Divider()
                }
                .background(background(item))
            }
        }
    }
}

extension NavigationList where Background == EmptyView {
    init(
        items: [Item],
        @ViewBuilder row: @escaping (Item) -> Row,
        @ViewBuilder destination: @escaping (Item) -> Destination
    ) {
        self.init(
            items: items,
            row: row,
            destination: destination,
            background: { _ in EmptyView() }
        )
    }
}
