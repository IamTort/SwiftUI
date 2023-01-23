//  PurchaseView.swift
//  SUI
//  Created by angelina on 23.01.2023.

import SwiftUI

/// Экран выбора тарифа
struct PurchaseView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let titleString = "Privacy Matters"
        static let descriptionString = "Protect your online activities with VPN Plus"
        static let oneDayImageName = "1"
        static let thirtyDaysImageName = "2"
        static let oneYearImageName = "3"
        static let buyString = "Buy"
        static let vacationString = "Vacation (1 day)"
        static let dayPriceString = "99 RUB"
        static let standardString = "Standard (1 month)"
        static let standardPriceString = "179 RUB"
        static let yearString = "Year (1 year)"
        static let yearPriceString = "1299 RUB"
        static let lengthSpacerNumber: CGFloat = 60
        static let topSpacerNumber: CGFloat = 40
        static let minSpacerNumber: CGFloat = 30
        static let widthNumber: CGFloat = 150
        static let heightNumber: CGFloat = 150
        static let badgeNumber = 1
        static let kerningNumber: CGFloat = 1
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        ScrollView {
            Text(Constants.titleString).font(.largeTitle)
            Spacer(minLength: Constants.topSpacerNumber)
            Text(Constants.descriptionString)
                .fontWeight(.light)
                .kerning(Constants.kerningNumber)
            Spacer(minLength: Constants.lengthSpacerNumber)
            VStack {
                createOffer(imageName: Constants.oneDayImageName, typeText: Constants.vacationString, priceText: Constants.dayPriceString)
            }
            Spacer(minLength: Constants.lengthSpacerNumber)
            VStack {
                createOffer(imageName: Constants.thirtyDaysImageName, typeText: Constants.standardString, priceText: Constants.standardPriceString)
            }
            Spacer(minLength: Constants.lengthSpacerNumber)
            VStack {
                createOffer(imageName: Constants.oneYearImageName, typeText: Constants.yearString, priceText: Constants.yearPriceString)
            }
        }
    }
    
    // MARK: - Private Properties
    
    @EnvironmentObject private var userBuy: UserBuyRateViewModel
    
    // MARK: - Private methods
    
    private func createOffer(imageName: String, typeText: String, priceText: String) -> some View {
        return VStack {
            Image(imageName)
                .resizable()
                .frame(width: Constants.widthNumber, height: Constants.heightNumber)
            Spacer(minLength: Constants.minSpacerNumber)
            Text("\(typeText) \(priceText)")
                .fontWeight(.light)
                .kerning(Constants.kerningNumber)
            Spacer(minLength: Constants.minSpacerNumber)
            Button {
                self.userBuy.type = typeText
                self.userBuy.price = priceText
                self.userBuy.badge = Constants.badgeNumber
            } label: {
                Text(Constants.buyString)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .padding(.horizontal)
                    .background(.blue)
            }
        }
    }
}
