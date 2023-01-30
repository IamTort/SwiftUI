// ColorSliderViewModel.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Вью модель cлайдера
final class ColorSliderViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let constNumber: CGFloat = 50
        static let dolarString = "$"
        static let dotPaddingNumber: CGFloat = 15
        static let paddingNumber: CGFloat = 80
        static let maxPriceValNumber: CGFloat = 5000
        static let sliderDotHeightNumber: CGFloat = 20
        static let sliderStepNumber: CGFloat = 500
        static let minimumValueNumber: CGFloat = 4.8
        static let maximumValueNumber: CGFloat = 23.85
    }

    // MARK: - Private Properties

    @Published var maxPriceVal = Constants.maxPriceValNumber
    @Published var sliderDotHeight = Constants.sliderDotHeightNumber
    @Published var sliderStep = Constants.sliderStepNumber
    @Published var minimumValue = Constants.minimumValueNumber
    @Published var maximumValue = Constants.maximumValueNumber
    @Published var totalSliderWidth = UIScreen.main.bounds.width - Constants.paddingNumber

    // MARK: - Public methods

    func sliderPxPerStep() -> CGFloat {
        sliderStep * (totalSliderWidth / maxPriceVal)
    }

    func makeWidthSlider() -> CGFloat {
        maximumValue - minimumValue + sliderDotHeight + Constants.constNumber
    }

    func makeMinimumValueText() -> String {
        "\(Int(minimumValue / sliderPxPerStep() * sliderStep))\(Constants.dolarString)"
    }

    func makeMaximumValueText() -> String {
        "\(Int(maximumValue / sliderPxPerStep() * sliderStep))\(Constants.dolarString)"
    }

    func makeChangeMaximumValue(value: DragGesture.Value) {
        if
            value.location.x >= minimumValue,
            value.location.x <= totalSliderWidth
        {
            let stpCnt = ceil(value.location.x / sliderPxPerStep())
            maximumValue = stpCnt * sliderPxPerStep()
        }
    }

    func makeChangeMinimumValue(value: DragGesture.Value) {
        if
            value.location.x > 0,
            value.location.x <= maximumValue
        {
            let stpCnt = floorf(Float(value.location.x / sliderPxPerStep()))
            minimumValue = CGFloat(stpCnt) * sliderPxPerStep()
        }
    }
}
