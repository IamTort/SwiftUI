//  CarViewModel.swift
//  SUI
//  Created by angelina on 23.01.2023.

import Foundation

final class CarsViewModel: ObservableObject {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let carsNames = ["Opel", "Ford", "BMW"]
        static let typeOfSpoilersValues = ["Отсутствует", "Карбоновый", "Фанера"]
        static let carCostsValues = [1000000, 3494949, 5445857]
        static let zeroInt = 0
        static let timeNumber = 0.5
        static let zeroNumber = 0
    }
    
    @Published var cars = Constants.carsNames
    @Published var carCost = Constants.carCostsValues
    @Published var typeOfSpoiler = Constants.typeOfSpoilersValues
    @Published var segmentIndex = Constants.zeroInt
    @Published var offsetX = Constants.zeroInt
    @Published var vEngineIndex = Constants.zeroInt
    
    func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.timeNumber) {
            self.offsetX = Constants.zeroNumber
        }
    }
}
