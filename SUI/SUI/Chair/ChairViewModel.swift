// ChairViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана со стулом
final class ChairViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let textString = "kelmv lkanv'ankewl;onv;ejvn ejkwlvejb ewkhilvu;q"
    }

    // MARK: - Public Properties

    @Published var text = Constants.textString
}
