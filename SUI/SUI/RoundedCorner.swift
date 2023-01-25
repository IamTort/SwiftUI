// RoundedCorner.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Закруглитель углов у вью
struct RoundedCorner: Shape {
    // MARK: - Public property

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    // MARK: - Public methods

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
