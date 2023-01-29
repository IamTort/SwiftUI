// ShakeGeometryEffect.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Эффект дрожания
struct ShakeGeometryEffect: GeometryEffect {
    
    // MARK: - Private Constants

    private enum Constants {
        static let amountNumber: CGFloat = 10
        static let shakesPerUnitNumber = 3
        static let defaultExpireMonthName = "05"
        static let defaultExpireYearName = "20"
        static let emptyString = ""
    }
    
    var amount: CGFloat = Constants.amountNumber
    var shakesPerUnit = Constants.shakesPerUnitNumber
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(
            translationX:
                amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0
        ))
    }
}
