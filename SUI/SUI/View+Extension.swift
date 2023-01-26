// View+Extension.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Расширение вью
extension View {
    // MARK: - Public methods

    func redTextField() -> some View {
        modifier(TextFieldModifier())
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCornerShape(radius: radius, corners: corners))
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            hidden()
        } else {
            self
        }
    }
}
