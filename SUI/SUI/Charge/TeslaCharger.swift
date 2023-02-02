// TeslaCharger.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Станция зарядки
struct TeslaCharger: Identifiable, Equatable {
    /// Идентификатор
    var id = UUID()
    /// Адрес
    var place: String
    /// Расстояние
    var mileage: String
    /// Кол-во доступных станций
    var availableCount: Int
    /// Всего станций
    var count: Int

    // MARK: - Public methods

    static func getChargers() -> [TeslaCharger] {
        [
            TeslaCharger(place: "Tesla SuperCharger - Montreal, QC", mileage: "1.7 km", availableCount: 2, count: 4),
            TeslaCharger(place: "Tesla SuperCharger - Mascouch, QC", mileage: "1.7 km", availableCount: 2, count: 2)
        ]
    }
}
