// ClimateViewModel.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Вью модель экрана климата
final class ClimateViewModel: ObservableObject {
    // MARK: - Public properties

    @Published var isOnClimate = false
    @Published var minCelsus = 15
    @Published var maxCelsus = 30
    @Published var currentCelsus = 15
    @Published var isAlertShown = false
    @Published var revealDetails = true
    @Published var circleProgress: CGFloat = 0.0
    @Published var selectedColor: Color = .topGradient

    // MARK: - Private properties

    func getCircleGradus() {
        circleProgress = 1.0 - ((30 - CGFloat(currentCelsus)) * (1 / 15))
    }

    func makeMinimumValueText(sliderOffset: CGFloat) {
        currentCelsus = Int((sliderOffset + 100) / sliderPxPerStep()) + 15
        getCircleGradus()
    }

    func sliderPxPerStep() -> CGFloat {
        1 * (200 / 15)
    }
}
