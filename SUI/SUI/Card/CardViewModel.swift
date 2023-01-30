// CardViewModel.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Вью модель экрана добавления карты
final class CardViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let defaultCardNumberName = "0000 0000 0000 0000"
        static let ownerNameOnCardText = "Your Name"
        static let emptyString = ""
        static let months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
        static let years = ["23", "24", "25", "26", "27", "28", "29", "30"]
    }

    // MARK: - Public Properties

    @Published var months = Constants.months
    @Published var years = Constants.years
    @Published var isMonthPickerShown = false
    @Published var isYearPickerShown = false
    @Published var expireMonth = "06"
    @Published var expireYear = "26"
    @Published var monthText = "Month"
    @Published var yearText = "Year"
    @Published var expireMonthOnCardName = "05"
    @Published var expireYearOnCardName = "20"
    @Published var isFrontCardShown = true
    @Published var backDegree = -90.0
    @Published var frontDegree = 0.0
    @Published var lastText = Constants.emptyString
    @Published var isAlertCodeShown = false
    @Published var isCardPlaceholderOn = false
    @Published var isNamePlaceholderOn = false
    @Published var nameText = Constants.emptyString
    @Published var cardNumberText = Constants.emptyString
    @Published var cvcNumberText = Constants.emptyString

    // MARK: - Public methods

    func flipCard() {
        if isFrontCardShown {
            withAnimation(.linear(duration: 0.3)) {
                backDegree = -90
            }
            withAnimation(.linear(duration: 0.3).delay(0.3)) {
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: 0.3)) {
                frontDegree = 90
            }
            withAnimation(.linear(duration: 0.3).delay(0.3)) {
                backDegree = 0
            }
        }
    }

    func getBackDegree() -> Double {
        backDegree
    }

    func getFrontDegree() -> Double {
        frontDegree
    }

    func checkNewValue(newValue: String) {
        cardNumberText = newValue.cardFormat()
    }

    func checkCVCNumberValue(text: String) {
        if cvcNumberText.count <= 3 {
            cvcNumberText = text
            lastText = text
        } else {
            cvcNumberText = lastText
        }
    }
}
