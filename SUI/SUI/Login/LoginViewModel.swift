// LoginViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана логина
final class LoginViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let phoneCountNumber = 18
        static let emptyString = ""
        static let minimumPasswordCountString = 5
        static let maximumPasswordCountString = 16
    }

    // MARK: - Public Properties

    @Published var loginText = Constants.emptyString
    @Published var passwordText = Constants.emptyString
    @Published var isAlertShown = false
    @Published var isPasswordAlertShown = false
    @Published var isShowVerificationScreen = false
    @Published var isShowChairScreen = false

    // MARK: - Public methods

    func checkInfo() {
        guard passwordText.count > Constants.minimumPasswordCountString,
              passwordText.count < Constants.maximumPasswordCountString
        else {
            isPasswordAlertShown = true
            return
        }
        isShowChairScreen = true
    }

    func checkNewValue(newValue: String) -> Bool {
        loginText = newValue.phoneFormat()
        if newValue.count == Constants.phoneCountNumber {
            return true
        }
        return false
    }
}
