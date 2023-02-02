// ChargingViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана с логотипом
final class ChargingViewModel: ObservableObject {
    // MARK: - Public property

    @Published var isButtonPressed = false
    @Published var isTextShown = false
    @Published var isSliderMoved = false
}
