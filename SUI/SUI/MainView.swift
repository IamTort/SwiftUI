// MainView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран с машинкой
struct MainView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let teslaTitle = "Tesla"
        static let teslaDistanceString = "187 km"
        static let teslaImageName = "teslaMain"
        static let unlockString = "Unlock"
        static let lockString = "Lock"
        static let lockImageName = "lock.fill"
        static let unlockImageName = "lock.open.fill"
        static let backgroundColorString = "backgroundLight"
        static let tagSelectedNumber = 1
        static let twoIndexNumber = 2
        static let buttonNumber = 5
    }

    // MARK: - Public properties

    var body: some View {
        backgroundStackView(isLock: false) {
            VStack {
                headerView
                Spacer()
                carView
                controlPanelView
                navigationLinkView
                Spacer()
                    .frame(height: 40)
//                if mainViewModel.tagSelected == Constants.tagSelectedNumber {
                closeCarControlView
                    .opacity(mainViewModel.tagSelected == Constants.tagSelectedNumber ? 1 : 0)
//                }
                Spacer(minLength: 130)
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    // MARK: - Private properties

    @StateObject private var mainViewModel = MainViewModel()

    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Constants.teslaTitle)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(Constants.teslaDistanceString)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .opacity(0.4)
            }
            Spacer()
        }
        .padding(.all, 25)
    }

    private var carView: some View {
        Image(Constants.teslaImageName)
            .resizable()
            .frame(height: 250)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .white.opacity(0.6), radius: 15, x: 0, y: 10)
    }

    private var gradient: LinearGradient {
        LinearGradient(colors: [.topGradient, .bottomGradient], startPoint: .bottom, endPoint: .top)
    }

    private var controlPanelView: some View {
        HStack(spacing: 30) {
            ForEach(1 ..< 5) { index in
                Button {
                    if index == 2 {
                        mainViewModel.isClimateShown.toggle()
                    }
                    withAnimation {
                        mainViewModel.tagSelected = index
                    }
                } label: {
                    Image("\(index)")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .neumorphismUnSelectedCircleStyle()
                        .overlay(
                            Circle()
                                .stroke(gradient, lineWidth: 2)
                                .opacity(mainViewModel.tagSelected == index ? 1 : 0)
                        )
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 50)
                .fill(Color(Constants.backgroundColorString))
        )
        .neumorphismUnSelectedStyle()
    }

    private var navigationLinkView: some View {
        NavigationLink(isActive: $mainViewModel.isClimateShown) {
            ClimateView()
        } label: {
            EmptyView()
        }
    }

    private var closeCarControlView: some View {
        Button {
            withAnimation {
                mainViewModel.isCarClosed.toggle()
            }
        } label: {
            HStack {
                Label {
                    Text(mainViewModel.isCarClosed ? Constants.lockString : Constants.unlockString)
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: mainViewModel.isCarClosed ? Constants.unlockImageName : Constants.lockImageName)
                        .renderingMode(.template)
                        .neumorphismUnSelectedCircleStyle()
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color(Constants.backgroundColorString))
            )
            .neumorphismSelectedStyle()
        }
        .frame(width: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.colorScheme, .dark)
    }
}
