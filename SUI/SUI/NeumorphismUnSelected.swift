// NeumorphismUnSelected.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стиль нейморфизм не выбранный
struct NeumorphismUnSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("lightShadow"), radius: 5, x: -5, y: -5)
            .shadow(color: Color("darkShadow"), radius: 5, x: 5, y: 5)
    }
}
