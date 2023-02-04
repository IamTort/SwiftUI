// StartView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стартовый экран
struct StartView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let teslaLockedImageName = "teslaLocked"
        static let teslaUnlockedImageName = "teslaUnlocked"
        static let gearshapeImageName = "gearshapeIcon"
        static let hiString = "Hi"
        static let welcomeString = "Welcome back"
        static let unlockString = "Unlock"
        static let lockString = "Lock"
        static let lockImageName = "lock.fill"
        static let unlockImageName = "lock.open.fill"
        static let backgroundColorString = "backgroundLight"
    }

    // MARK: - Public properties

    var body: some View {
        backgroundStackView(isLock: startViewModel.isCarClose) {
            VStack(spacing: 50) {
                HStack {
                    Spacer()
                    settingsButtonView
                        .padding(.top, 40)
                    navigationLinkView
                        .padding(.trailing, 40)
                }
                VStack {
                    hiTextView
                    titleTextView
                }
                carImageView
                closeCarControlView
                Spacer(minLength: 100)
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    // MARK: - Private properties

    @StateObject private var startViewModel = StartViewModel()

    private var carImageView: some View {
        Image(startViewModel.isCarClose ? Constants.teslaLockedImageName : Constants.teslaUnlockedImageName)
            .resizable()
            .frame(height: 250)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: startViewModel.isCarShadowClose ? .black : .white.opacity(0.6), radius: 15, x: 0, y: 10)
            .shadow(
                color: startViewModel.isCarShadowClose ? .black : .topGradient.opacity(0.1),
                radius: 55,
                x: 0,
                y: -50
            )
    }

    private var settingsButtonView: some View {
        Button {
            startViewModel.isSettingsScreenShown = true
        } label: {
            Image(Constants.gearshapeImageName)
                .neumorphismCircleButtonUnSelectedCircleStyle()
        }
    }

    private var navigationLinkView: some View {
        NavigationLink(isActive: $startViewModel.isSettingsScreenShown) {
            MainTabBarView()
        } label: {
            EmptyView()
        }
    }

    private var hiTextView: some View {
        Text(Constants.hiString)
            .foregroundColor(.gray)
            .font(.system(size: 20))
            .padding(.bottom, 10)
            .opacity(startViewModel.isCarClose ? 0 : 1)
    }

    private var titleTextView: some View {
        Text(Constants.welcomeString)
            .foregroundColor(.white)
            .font(.system(size: 35, weight: .bold, design: .default))
            .opacity(startViewModel.isCarClose ? 0 : 1)
    }

    private var closeCarControlView: some View {
        Button {
            withAnimation {
                startViewModel.isCarClose.toggle()
            }
            startViewModel.isCarShadowClose.toggle()
        } label: {
            HStack {
                Text(startViewModel.isCarClose ? Constants.unlockString : Constants.lockString)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: startViewModel.isCarClose ? Constants.lockImageName : Constants.unlockImageName)
                    .foregroundColor(.bottomGradient)
                    .neumorphismUnSelectedCircleStyle()
            }
            .padding()
            .frame(width: 140)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color(Constants.backgroundColorString))
            )
            .neumorphismSelectedStyle()
        }
        .frame(width: 300)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environment(\.colorScheme, .dark)
    }
}
