// View+Extension.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Расширение вью
extension View {
    func neumorphismUnSelectedStyle() -> some View {
        modifier(NeumorphismUnSelected())
    }

    func neumorphismSelectedStyle() -> some View {
        modifier(NeumorphismSelected())
    }

    func neumorphismUnSelectedCircleStyle() -> some View {
        modifier(NeumorphismUnSelectedCircle())
    }

    func neumorphismCircleButtonUnSelectedCircleStyle() -> some View {
        modifier(NeumorphismCircleButtonUnSelectedCircle())
    }

    func backgroundStackView<Content: View>(isLock: Bool = true, content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(
                    isLock ?
                        LinearGradient(
                            colors: [.lightShadow, .black],
                            startPoint: .top,
                            endPoint: .init(x: 0.5, y: 0.4)
                        ) :
                        LinearGradient(
                            colors: [.backgroundLight],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            content()
        }
    }
}
