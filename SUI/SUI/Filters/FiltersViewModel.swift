// FiltersViewModel.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Вью модель экрана фильтрации
final class FiltersViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let grayColorString = "lightGray"
    }

    // MARK: - Public Properties

    @Published var row: [GridItem] = [.init(.fixed(130))]
    @Published var column: [GridItem] = [
        .init(.fixed(40), spacing: 30, alignment: .top),
        .init(.fixed(40), spacing: 30, alignment: .top),
        .init(.fixed(40), spacing: 30, alignment: .top),
        .init(.fixed(40), spacing: 30, alignment: .top),
        .init(.fixed(40), spacing: 30, alignment: .top)
    ]
    @Published var color = Color.black
    @Published var colors = [
        .white,
        .black,
        .gray,
        .darkPurple,
        .yellow,
        .red,
        .purple,
        .blue,
        .cyan,
        .green,
        .indigo,
        .orange,
        .brown,
        .mint,
        .pink,
        .teal,
        Color(Constants.grayColorString),
        .lightPink,
        .lightCyan,
        .secondary
    ]
}
