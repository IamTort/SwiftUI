// MainTabBarView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран таб бара
struct MainTabBarView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let carImageName = "carIcon"
        static let chargeImageName = "charge"
        static let markImageName = "markIcon"
        static let emptyString = ""
        static let personImageName = "person"
    }

    // MARK: - Public property

    var body: some View {
        TeslaTabBarView(selection: $selection) {
            MainView()
                .myTabItem {
                    TabItem(iconName: Constants.carImageName)
                }
                .opacity(selection == 0 ? 1 : 0)
            ChargingView()
                .myTabItem {
                    TabItem(iconName: Constants.chargeImageName)
                }
                .opacity(selection == 1 ? 1 : 0)
            Text(Constants.emptyString)
                .myTabItem {
                    TabItem(iconName: Constants.emptyString)
                }
                .opacity(selection == 2 ? 1 : 0)
            Text(Constants.emptyString)
                .myTabItem {
                    TabItem(iconName: Constants.markImageName)
                }
                .opacity(selection == 2 ? 1 : 0)
            Text(Constants.emptyString)
                .myTabItem {
                    TabItem(iconName: Constants.personImageName)
                }
                .opacity(selection == 3 ? 1 : 0)
        }
    }

    // MARK: - Private property

    @State private var selection = 0
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
            .environment(\.colorScheme, .dark)
    }
}
