// Color+Extension.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Дополнительные цвета
extension Color {
    // MARK: - Private Constants

    private enum Constants {
        static let lightGrayString = "lightGray"
        static let darkPurpleString = "darkPurple"
        static let lightCyanString = "lightCyan"
        static let lightPinkString = "lightPink"
    }

    // MARK: - Public properties

    static let lightGray = Color(Constants.lightGrayString)
    static let darkPurple = Color(Constants.darkPurpleString)
    static let lightCyan = Color(Constants.lightCyanString)
    static let lightPink = Color(Constants.lightPinkString)
}
