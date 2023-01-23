//  BasketView.swift
//  SUI
//  Created by angelina on 23.01.2023.

import SwiftUI

/// Экран корзины
struct BasketView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let titleString = "Корзина"
        static let typeString = "Вы выбрали тариф:"
        static let priceString = "Цена:"
        static let clearButtonTitle = "Очистить корзину"
        static let emptyString = ""
        static let buyButtonTitle = "Купить"
        static let alertTitleString = "Поздравляем"
        static let alertMessageString = "Вы оплатили тариф - "
        static let titleBaselineOffsetNumber: CGFloat = 50
        static let typeBaselineOffsetNumber: CGFloat = 30
        static let fontSizeNumber: CGFloat = 25
        static let minSpacerNumber: CGFloat = 30
        static let widthButtonNumber: CGFloat = 250
        static let heightButtonNumber: CGFloat = 50
        static let cornerRadiusButtonNumber: CGFloat = 10
        static let badgeNumber = 0
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        VStack {
            Text(Constants.titleString)
                .font(.largeTitle)
                .bold()
                .baselineOffset(Constants.titleBaselineOffsetNumber)
            Spacer()
            Text(Constants.typeString)
                .baselineOffset(Constants.typeBaselineOffsetNumber)
                .font(.system(size: Constants.fontSizeNumber, weight: .light, design: .default))
            
            Text(userBuy.type)
                .baselineOffset(Constants.typeBaselineOffsetNumber)
                .font(.title)
            
            Spacer()
            VStack {
                Text(Constants.priceString)
                    .baselineOffset(Constants.typeBaselineOffsetNumber)
                    .font(.system(size: Constants.fontSizeNumber, weight: .light, design: .default))
                Text(userBuy.price)
                    .baselineOffset(Constants.typeBaselineOffsetNumber)
                    .font(.title)
            }
            Spacer()
            buyButtonView
            cancelButtonView
            Spacer(minLength: Constants.minSpacerNumber)
        }
    }
    
    // MARK: - Private Properties
    
    @EnvironmentObject private var userBuy: UserBuyRateViewModel
    
    @State private var isBuy = false
    
    private var cancelButtonView: some View {
        Button {
            userBuy.badge = Constants.badgeNumber
            userBuy.type = Constants.emptyString
            userBuy.price = Constants.emptyString
        } label: {
            Text(Constants.clearButtonTitle)
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(width: Constants.widthButtonNumber, height: Constants.heightButtonNumber, alignment: .center)
                .background(.blue)
                .cornerRadius(Constants.cornerRadiusButtonNumber)
        }
    }
    
    private var buyButtonView: some View {
        Button {
            guard !userBuy.type.isEmpty else { return }
            self.isBuy = true
        } label: {
            Text(Constants.buyButtonTitle)
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(width: Constants.widthButtonNumber, height: Constants.heightButtonNumber, alignment: .center)
                .background(.blue)
                .cornerRadius(Constants.cornerRadiusButtonNumber)
        }.alert(isPresented: $isBuy) {
            Alert(title: Text(Constants.alertTitleString), message: Text("\(Constants.alertMessageString)\(userBuy.type)"), dismissButton: .cancel())
        }
    }
}
