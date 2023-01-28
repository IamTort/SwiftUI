// FiltersViewModel.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Вью модель экрана фильтрации
final class FiltersViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let rowWidthViewNumber: CGFloat = 130
        static let columnWidthViewNumber: CGFloat = 40
        static let columnSpacingNumber: CGFloat = 30
        static let grayColorString = "lightGray"
    }

    // MARK: - Public Properties

    @Published var row: [GridItem] = [.init(.fixed(Constants.rowWidthViewNumber))]
    @Published var column: [GridItem] = [
        .init(.fixed(Constants.columnWidthViewNumber), spacing: Constants.columnSpacingNumber, alignment: .top),
        .init(.fixed(Constants.columnWidthViewNumber), spacing: Constants.columnSpacingNumber, alignment: .top),
        .init(.fixed(Constants.columnWidthViewNumber), spacing: Constants.columnSpacingNumber, alignment: .top),
        .init(.fixed(Constants.columnWidthViewNumber), spacing: Constants.columnSpacingNumber, alignment: .top),
        .init(.fixed(Constants.columnWidthViewNumber), spacing: Constants.columnSpacingNumber, alignment: .top)
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
