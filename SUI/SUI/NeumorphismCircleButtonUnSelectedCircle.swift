// NeumorphismCircleButtonUnSelectedCircle.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стиль нейморфизм круглая кнопка
struct NeumorphismCircleButtonUnSelectedCircle: ViewModifier {
    // MARK: - Public property

    func body(content: Content) -> some View {
        content
            .frame(width: 20, height: 20)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(LinearGradient(
                        colors: [.lightShadow, .darkShadow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
            )
            .overlay(
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [.darkShadow, .lightShadow.opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            )
            .neumorphismUnSelectedStyle()
    }
}
