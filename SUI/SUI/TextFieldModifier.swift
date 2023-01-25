// TextFieldModifier.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Mодификатор для текстфилда
struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.plain)
            .font(.system(size: 30))
            .keyboardType(.emailAddress)
            .padding(.horizontal, 30)
    }
}
