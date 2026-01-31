//
//  View+HideKeyboard.swift
//  veda
//
//  Created by Евгений Петрукович on 1/27/26.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
