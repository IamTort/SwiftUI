// KeyboardResponder.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Поднятие экрана при появлении клавиатуры
final class KeyboardResponder: ObservableObject {
    // MARK: - Private property

    @Published private(set) var currentHeight: CGFloat = 0

    private var notificationCenter: NotificationCenter

    // MARK: - Initializer

    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(
            self,
            selector:
            #selector(keyBoardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector:
            #selector(keyBoardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    // MARK: - Public methods

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue
        )?.cgRectValue {
            currentHeight = keyboardSize.height
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
    }
}
