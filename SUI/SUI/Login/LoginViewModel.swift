// LoginViewModel.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Вью модель экрана логина
final class LoginViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let phoneCountNumber = 18
        static let emptyString = ""
        static let minimumPasswordCountString = 5
        static let maximumPasswordCountString = 16
        static let startValueNumber: Float = 0
        static let maxValueNumber: Float = 10
        static let progressViewCountNumber = 0.0
        static let progressMaxCountNumber = 5.0
        static let attemptsNumber = 0
        static let oneNumber = 1
        static let timeNumber: TimeInterval = 1
    }

    // MARK: - Public Properties

    @Published var loginText = Constants.emptyString
    @Published var passwordText = Constants.emptyString
    @Published var isAlertShown = false
    @Published var isPasswordAlertShown = false
    @Published var isShowVerificationScreen = false
    @Published var isShowChairScreen = false
    @Published var attempts = Constants.attemptsNumber
    @Published var value: Float = Constants.startValueNumber
    @Published var progressViewCount = Constants.progressViewCountNumber
    @Published var progressMaxCount = Constants.progressMaxCountNumber
    @Published var isShowIconError = false

    // MARK: - Public methods

    func checkInfo() {
        guard passwordText.count > Constants.minimumPasswordCountString,
              passwordText.count < Constants.maximumPasswordCountString
        else {
            attempts += Constants.oneNumber
            withAnimation {
                self.isShowIconError = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isShowIconError = false
                }
            }
            return
        }
        progressViewActivate()
    }

    func checkNewValue(newValue: String) -> Bool {
        loginText = newValue.phoneFormat()
        if newValue.count == Constants.phoneCountNumber {
            return true
        }
        return false
    }

    func progressViewActivate() {
        Timer.scheduledTimer(withTimeInterval: Constants.timeNumber, repeats: true) { timer in
            if self.progressViewCount == self.progressMaxCount {
                timer.invalidate()
                self.isShowChairScreen = true
            } else {
                self.progressViewCount += Double(Constants.oneNumber)
            }
        }
    }
}
