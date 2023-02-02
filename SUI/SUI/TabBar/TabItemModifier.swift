// TabItemModifier.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Модификатор для добавления вкладок в таббар
struct TabItemModifier: ViewModifier {
    // MARK: - Public property

    let tabBarItem: TabItem

    // MARK: - Public Methods

    func body(content: Content) -> some View {
        content
            .preference(key: TabItemPreferenceKey.self, value: [tabBarItem])
    }
}
