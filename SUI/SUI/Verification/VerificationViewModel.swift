// VerificationViewModel.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Вью модель экрана верификации
final class VerificationViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
        static let startValueNumber: Float = 0
        static let maxValueNumber: Float = 10
        static let timeIntervalNumber: Float = 1
        static let oneNumber = 1
    }

    // MARK: - Public properties

    @Published var isHidden = true
    @Published var value: Float = Constants.startValueNumber
    @Published var isContinueVerificationShown = false
    @Published var isAlertCodeShown = false

    @Published var firstNumber = Constants.emptyString
    @Published var secondNumber = Constants.emptyString
    @Published var thirdNumber = Constants.emptyString
    @Published var forthNumber = Constants.emptyString

    @Published var firstRandomNumber = Constants.emptyString
    @Published var secondRandomNumber = Constants.emptyString
    @Published var thirdRandomNumber = Constants.emptyString
    @Published var forthRandomNumber = Constants.emptyString

    // MARK: - Public methods

    func hiddenProgress() {
        value = Constants.startValueNumber
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.value < Constants.maxValueNumber {
                self.value += Constants.timeIntervalNumber
            } else {
                self.isHidden = true
            }
        }
    }

    func changeCodeNumber(newValue: String) -> Bool {
        if newValue.count == Constants.oneNumber {
            return true
        }
        return false
    }

    func getCodeNumber() -> String {
        "\(firstRandomNumber)\(secondRandomNumber)" +
            "\(thirdRandomNumber)\(forthRandomNumber)"
    }

    func createRandomCode() {
        firstRandomNumber = createRandomNumber()
        secondRandomNumber = createRandomNumber()
        thirdRandomNumber = createRandomNumber()
        forthRandomNumber = createRandomNumber()
    }

    func setRandomCode() {
        firstNumber = firstRandomNumber
        secondNumber = secondRandomNumber
        thirdNumber = thirdRandomNumber
        forthNumber = forthRandomNumber
    }

    // MARK: - Private methods

    private func createRandomNumber() -> String {
        String(Int.random(in: 0 ... 9))
    }
}
