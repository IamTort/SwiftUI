// Profile.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Профиль
struct Profile: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let notificationCount: Int?

    static func getProfileSettings() -> [Profile] {
        let profileTable: [Profile] = [
            .init(imageName: "envelope.fill", title: "Messages", notificationCount: 3),
            .init(imageName: "bell.fill", title: "Notification", notificationCount: 5),
            .init(imageName: "person.fill", title: "Accounts Details", notificationCount: nil),
            .init(imageName: "cart.fill", title: "My purchases", notificationCount: nil),
            .init(imageName: "gearshape.fill", title: "Settings", notificationCount: nil)
        ]
        return profileTable
    }
}
