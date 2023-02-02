// MainViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана c машинкой
final class MainViewModel: ObservableObject {
    // MARK: - Public properties

    @Published var isCarClosed = false
    @Published var isClimateShown = false
    @Published var tagSelected = 0
}
