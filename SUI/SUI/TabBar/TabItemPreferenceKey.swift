// TabItemPreferenceKey.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Хранение TabItem
struct TabItemPreferenceKey: PreferenceKey {
    // MARK: - Public property

    static var defaultValue: [TabItem] = []

    // MARK: - Public Methods

    static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue()
    }
}
