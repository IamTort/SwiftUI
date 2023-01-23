//  UserBuyRateViewModel.swift
//  SUI
//  Created by angelina on 23.01.2023.

import Foundation

/// Модель выбора тарифа
class UserBuyRateViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var type = ""
    @Published var price = ""
    @Published var badge = 0
}
