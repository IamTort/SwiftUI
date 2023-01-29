// CardViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftUI

/// Вью модель экрана добавления карты
final class CardViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let defaultCardNumberName = "0000 0000 0000 0000"
        static let ownerNameOnCard = "Your Name"
        static let defaultExpireMonthName = "05"
        static let defaultExpireYearName = "20"
        static let emptyString = ""
        static let months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
        static let years = ["23", "24", "25", "26", "27", "28", "29", "30"]
        static let expireMonthString = "06"
        static let expireYearString = "26"
        static let monthString = "Month"
        static let yearString = "Year"
        static let backDegreeNumber = -90.0
        static let frontDegreeNumber = 0.0
    }

    let months = Constants.months
    let years = Constants.years

    @Published var isMonthPickerShown = false
    @Published var isYearPickerShown = false
    @Published var expireMonth = Constants.expireMonthString
    @Published var expireYear = Constants.expireYearString
    @Published var textMonth = Constants.monthString
    @Published var textYear = Constants.yearString
    @Published var expireMonthOnCardName = Constants.defaultExpireMonthName
    @Published var expireYearOnCardName = Constants.defaultExpireYearName
    @Published var isFrontCardShown = true
    @Published var backDegree = Constants.backDegreeNumber
    @Published var frontDegree = Constants.frontDegreeNumber
    @Published var lastText = Constants.emptyString
    @Published var isAlertCodeShown = false
    @Published var isCardPlaceholderOn = false
    @Published var isNamePlaceholderOn = false
    @Published var nameText = Constants.emptyString
    @Published var cardNumberText = Constants.emptyString
    @Published var cvcNumberText = Constants.emptyString

    func getMonthString(newValue: String) {
        textMonth = newValue
    }

    func getYearString(newValue: String) {
        textYear = newValue
    }

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
