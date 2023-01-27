// GradientModifier.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Mодификатор градиента
struct GradientModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    colors: [.yellow, .red.opacity(0.9)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
}
