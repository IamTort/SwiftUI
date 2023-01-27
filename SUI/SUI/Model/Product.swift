// Product.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель продукта
struct Product: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let price: Int
    var count = 0

    static func getProducts() -> [Product] {
        let products: [Product] = [
            .init(imageName: "couch", title: "Sofa", price: 505),
            .init(imageName: "armchair", title: "Armchair", price: 220),
            .init(imageName: "bed", title: "Bed", price: 760),
            .init(imageName: "dining", title: "Chair", price: 45),
            .init(imageName: "couch", title: "Sofa", price: 505)
        ]
        return products
    }
}
