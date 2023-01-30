// NeumorphismUnSelectedCircle.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стиль нейморфизм не выбранный круг
struct NeumorphismUnSelectedCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(
                Circle()
                    .fill(Color("background"))
            )
            .neumorphismUnSelectedStyle()
    }
}
