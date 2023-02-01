// NeumorphismSelected.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стиль нейморфизм выбранный
struct NeumorphismSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .lightShadow, radius: 5, x: 5, y: 5)
            .shadow(color: .darkShadow, radius: 5, x: -5, y: -5)
    }
}
