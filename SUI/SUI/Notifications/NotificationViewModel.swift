// NotificationViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана уведомлений
final class NotificationViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var isProductUpdatesOn = true
    @Published var isCommentsOn = false
    @Published var isOfferUpdatesOn = true
    @Published var isNotificationsUpdatesOn = false
    @Published var isAlertCodeShown = false
}
