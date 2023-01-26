// TextSquireFieldModifier.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Mодификатор для текстфилда пин-кода
struct TextSquireFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .keyboardType(.numberPad)
            .frame(width: 70, height: 70)
            .font(.system(size: 43))
            .multilineTextAlignment(.center)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray)
            )
    }
}
