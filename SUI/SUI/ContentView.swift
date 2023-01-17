//  ContentView.swift
//  SUI
//  Created by angelina on 17.01.2023.

import SwiftUI

struct ContentView: View {
    
    // MARK: - Private Constants
    private enum Constants {
        static let moneyCount = 465
        static let walletString = "Кошелек"
        static let currentBalanceText = "Текущий баланс:"
        static let showSettingsText = "Показать настройки"
        static let emptyString = ""
        static let refillTheBalanceButtonTitle = "Пополнить баланс"
        static let actionSheetRefillTheBalanceText = "Вы пополнили счёт на 1000"
        static let transferMoneyTitle = "Перевод средств"
        static let transferMoneyMessage = "Перевeсти 500 деняк?"
        static let profileTitle = "Профиль"
        static let thousandNumber = 1000
        static let fiveHundredNumber = 500
        static let spacerEightyNumber = 80
        static let spacerFourNumber = 400
        static let toggleNumber = 150
        static let zeroNumber = 0
        static let cornerRadiusNumber = 10
        static let transfersMoneyAlertButton = "Перевести"
        static let openBankAccountText = "Открыть счёт"
        static let responseNumber = 0.5
        static let dampingFractionNumber = 0.7
        static let blendDurationNumber = 0.3
    }

    @State var isError = false
    @State var isOnToggle = false
    @State var isAction = false
    @State var isTransferAction = false
    @State var isOpenBankAccount = false
    @State var isTransferMoney = false
    @State private var moneycount: String = Constants.emptyString
    @State private var account: String = Constants.emptyString
    @State var money = Constants.moneyCount
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    VStack {
                        Text(Constants.walletString).frame(maxWidth: .infinity, alignment: .leading)
                        Button {
                            self.isAction = true
                            money += Constants.thousandNumber
                        } label: {
                            Text(Constants.refillTheBalanceButtonTitle).frame(maxWidth: .infinity, alignment: .leading)
                        }.frame(maxWidth: .infinity, alignment: .leading).actionSheet(isPresented: $isAction) {
                            ActionSheet(title: Text(Constants.actionSheetRefillTheBalanceText))
                        }
                        
                        Button {
                            self.isTransferMoney = true
                        } label: {
                            Text(Constants.transferMoneyTitle).frame(maxWidth: .infinity, alignment: .leading)
                        }.alert(isPresented: $isTransferMoney) {
                            Alert(title: Text(Constants.transferMoneyTitle),
                                  message: Text(Constants.transferMoneyMessage),
                                  primaryButton: .cancel(),
                                  secondaryButton: .default(Text(Constants.transferMoneyTitle), action: {
                                guard money >= Constants.fiveHundredNumber else { return }
                                money -= Constants.fiveHundredNumber
                            }))
                        }
                        
                        Spacer().frame(height: CGFloat(Constants.spacerEightyNumber))
                        
                        Text(Constants.profileTitle).frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            isOpenBankAccount = true
                        } label: {
                            Text(Constants.openBankAccountText).frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .alert(isPresented: $isOpenBankAccount) {
                            Alert(title: Text(Constants.openBankAccountText), message: nil, primaryButton: .default(Text(Constants.openBankAccountText)), secondaryButton: .cancel())
                        }
                        Spacer().frame(height: CGFloat(Constants.spacerFourNumber))
                    }
                    Spacer()
                }
                RoundedRectangle(cornerRadius: CGFloat(Constants.cornerRadiusNumber)).fill(Color.green).offset(x: isOnToggle ? CGFloat(Constants.toggleNumber) : CGFloat(Constants.zeroNumber))
                VStack {
                    Text(Constants.currentBalanceText).offset(x: isOnToggle ? CGFloat(Constants.toggleNumber) : CGFloat(Constants.zeroNumber))
                    Text(String(money)).offset(x: isOnToggle ? CGFloat(Constants.toggleNumber) : CGFloat(Constants.zeroNumber))
                }
            }
            Toggle(isOn: $isOnToggle) {
                Text(Constants.showSettingsText)
            }.padding()
        }.animation(.spring(response: Constants.responseNumber, dampingFraction: Constants.dampingFractionNumber, blendDuration: Constants.blendDurationNumber))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
