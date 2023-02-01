// NeumorphismUnSelectedCircle.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стиль нейморфизм не выбранный круг
struct NeumorphismUnSelectedCircle: ViewModifier {
    // MARK: - Private Constants

    private enum Constants {
        static let backgroundColorString = "backgroundLight"
    }

    // MARK: - Public property

    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(
                Circle()
                    .fill(Color(Constants.backgroundColorString))
            )
            .neumorphismUnSelectedStyle()
    }
}
