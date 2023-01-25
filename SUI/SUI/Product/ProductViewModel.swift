// ProductViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана описания товара
final class ProductViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let textString = "kelmv lkanv'ankewl;onv;ejvn ejkwlvejb ewkhilvu;q"
        static let zeroNumber = 0
        static let emptyString = ""
    }

    // MARK: - Public Properties

    @Published var text = Constants.textString
    @Published var totalChars = Constants.zeroNumber
    @Published var lastText = Constants.emptyString
}
