// ChargeShape.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Уровень зарядки
struct ChargeShape: Shape {
    // MARK: - Public property

    var scaleValue: CGFloat

    // MARK: - Public Methods

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY - 20))
        path.addLine(to: CGPoint(x: 10, y: rect.maxY - 40))
        path.addLine(to: CGPoint(x: rect.maxX * scaleValue - 10, y: rect.maxY - 40))
        path.addLine(to: CGPoint(x: rect.maxX * scaleValue, y: rect.maxY - 20))
        path.addLine(to: CGPoint(x: rect.maxX * scaleValue, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
