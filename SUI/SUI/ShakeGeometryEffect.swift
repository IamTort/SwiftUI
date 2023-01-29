// ShakeGeometryEffect.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Эффект дрожания
struct ShakeGeometryEffect: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(
            translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0
        ))
    }
}
