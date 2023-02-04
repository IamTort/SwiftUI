// TeslaLogoShape.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Логотип компании Тесла
struct TeslaLogoShape: Shape {
    // MARK: - Public Methods

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width / 2, y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width / 2 + 20, y: rect.height / 2 - 20))
        path.addQuadCurve(
            to: CGPoint(x: rect.width / 2 + 120, y: rect.height / 2),
            control: CGPoint(x: rect.width / 2 + 60, y: rect.height / 2 - 20)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.width / 2 + 90, y: rect.height / 2 + 20),
            control: CGPoint(x: rect.width / 2 + 110, y: rect.height / 2 + 15)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.width / 2 + 35, y: rect.height / 2 + 10),
            control: CGPoint(x: rect.width / 2 + 90, y: rect.height / 2 + 5)
        )
        path.addLine(to: CGPoint(x: rect.width / 2, y: rect.height / 2 + 180))
        path.addLine(to: CGPoint(x: rect.width / 2 - 35, y: rect.height / 2 + 10))
        path.addQuadCurve(
            to: CGPoint(x: rect.width / 2 - 90, y: rect.height / 2 + 20),
            control: CGPoint(x: rect.width / 2 - 90, y: rect.height / 2 + 5)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.width / 2 - 120, y: rect.height / 2),
            control: CGPoint(x: rect.width / 2 - 110, y: rect.height / 2 + 15)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.width / 2 - 20, y: rect.height / 2 - 20),
            control: CGPoint(x: rect.width / 2 - 60, y: rect.height / 2 - 20)
        )
        path.closeSubpath()

        path.move(to: CGPoint(x: rect.width / 2, y: rect.height / 2 - 30))
        path.addQuadCurve(
            to: CGPoint(x: rect.width / 2 + 125, y: rect.height / 2 - 10),
            control: CGPoint(x: rect.width / 2 + 60, y: rect.height / 2 - 30)
        )
        path.addLine(to: CGPoint(x: rect.width / 2 + 135, y: rect.height / 2 - 20))
        path.addQuadCurve(
            to: CGPoint(x: rect.width / 2 - 135, y: rect.height / 2 - 20),
            control: CGPoint(x: rect.width / 2, y: rect.height / 2 - 70)
        )
        path.addLine(to: CGPoint(x: rect.width / 2 - 125, y: rect.height / 2 - 10))
        path.addQuadCurve(
            to: CGPoint(x: rect.width / 2, y: rect.height / 2 - 30),
            control: CGPoint(x: rect.width / 2 - 60, y: rect.height / 2 - 30)
        )
        path.closeSubpath()
        return path
    }
}
