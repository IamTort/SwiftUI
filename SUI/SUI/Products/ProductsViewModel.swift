// ProductsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана продуктов
final class ProductsViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var totalPrice = 0
    @Published var isFiltersShown = false
    @Published var products = Product.getProducts()

    // MARK: - Public methods

    func makePlus(item: Int) {
        products[item].count += 1
    }

    func makeMinusCount(item: Int) {
        guard products[item].count > 0 else { return }
        products[item].count -= 1
    }

    // MARK: - Private methods

    private func getTotalPrice() -> Int {
        var summ = 0
        for product in products {
            summ += product.count * product.price
        }
        return summ
    }
}
