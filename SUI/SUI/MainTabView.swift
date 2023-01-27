// MainTabView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Таб бар
struct MainTabView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let houseImageName = "house"
        static let bagImageName = "bag"
        static let personImageName = "person"
        static let gearshapeImageName = "gearshape.fill"
        static let ellipsImageName = "ellipsis"
        static let titleText = "Another Tab"
        static let zeroNumber = 0
        static let oneNumber = 1
        static let twoNumber = 2
        static let threeNumber = 3
        static let fourNumber = 4
    }

    // MARK: - Public property

    var body: some View {
        TabView(selection: $tabSelected) {
            Text(Constants.titleText)
                .tabItem {
                    Image(systemName: Constants.houseImageName)
                }
                .tag(Constants.zeroNumber)

            ProductsView()
                .tabItem {
                    Image(systemName: Constants.bagImageName)
                }
                .tag(Constants.oneNumber)

            ProfileView()
                .tabItem {
                    Image(systemName: Constants.personImageName)
                }
                .tag(Constants.twoNumber)

            Text(Constants.titleText)
                .tabItem {
                    Image(systemName: Constants.gearshapeImageName)
                }
                .tag(Constants.threeNumber)

            NotificationView()
                .tabItem {
                    Image(systemName: Constants.ellipsImageName)
                }
                .tag(Constants.fourNumber)
        }
        .accentColor(.yellow)
    }

    // MARK: - Private property

    @State private var tabSelected = Constants.zeroNumber
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
