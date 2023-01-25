//  ContentView.swift
//  SUI
//  Created by angelina on 17.01.2023.

import SwiftUI

/// Таббар
struct MainTabView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let lockImageName = "lock"
        static let vpnString = "VPN"
        static let purchaseImageName = "list.bullet"
        static let purchaseString = "Purchase"
        static let basketImageName = "cart.fill"
        static let basketString = "Basket"
        static let mainPageTagNumber = 0
        static let purchaseTagNumber = 1
        static let basketTagNumber = 2
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        TabView(selection: $tabSelected) {
            HomeView(tabSelection: $tabSelected)
                .tabItem {
                    Image(systemName: Constants.lockImageName)
                    Text(Constants.vpnString)
                }
                .tag(Constants.mainPageTagNumber)
            
            PurchaseView()
                .tabItem {
                    Image(systemName: Constants.purchaseImageName)
                    Text(Constants.purchaseString)
                }
                .tag(Constants.purchaseTagNumber)
            
            BasketView()
                .tabItem {
                    Image(systemName: Constants.basketImageName)
                    Text(Constants.basketString)
                }
                .tag(Constants.basketTagNumber)
                .badge(userBuy.badge)
            
        }
        .font(.headline)
        .accentColor(.red)
        .environmentObject(userBuy)
    }
    
    // MARK: - Private property
    @StateObject private var userBuy = UserBuyRateViewModel()
    
    @State private var tabSelected = Constants.mainPageTagNumber
}


/// Представление тейбл вью
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView().environment(\.colorScheme, .dark)
    }
}
