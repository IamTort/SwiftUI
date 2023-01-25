// MainView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Главный экран
struct MainView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let titleString = "ONLINE FURNITURE STORE"
        static let startButtonTitle = "GET STARTED"
        static let questionString = "Don't have an account?"
        static let navigationTitleString = "Sing in here"
        static let questionImageName = "questionmark"
        static let darkPurpleColorName = "darkPurple"
        static let opacityNumber = 0.9
        static let spaceNumber: CGFloat = 60
        static let tenSpaceNumber: CGFloat = 10
    }

    // MARK: - Public Properties

    var body: some View {
        NavigationView {
            ZStack {
                gradientView
                VStack {
                    Spacer(minLength: Constants.spaceNumber)
                    titleTextView
                    asyncImageView
                    Spacer()
                    startButtonView
                    navigationLinkView
                    VStack(spacing: Constants.tenSpaceNumber) {
                        questionTextView
                        loginNavigationLinkView
                            .padding(.bottom, Constants.spaceNumber)
                    }
                }
            }
            .ignoresSafeArea()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }

    // MARK: - Private Properties

    @StateObject private var mainViewModel = MainViewModel()

    private var titleTextView: some View {
        Text(Constants.titleString)
            .foregroundColor(.white)
            .font(.system(.largeTitle, design: .default))
            .bold()
            .multilineTextAlignment(.center)
    }

    private var startButtonView: some View {
        Button(Constants.startButtonTitle) {
            mainViewModel.isShowChair = true
        }
        .frame(width: 320, height: 80)
        .background(.white)
        .foregroundColor(Color(Constants.darkPurpleColorName))
        .font(.system(size: 28, weight: .bold, design: .default))
        .cornerRadius(40)
        .padding(30)
        .padding(.bottom, 20)
    }

    private var navigationLinkView: some View {
        NavigationLink(isActive: $mainViewModel.isShowChair) {
            ChairView()
        } label: {
            EmptyView()
        }
    }

    private var questionTextView: some View {
        Text(Constants.questionString)
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .bold, design: .rounded))
    }

    private var loginNavigationLinkView: some View {
        NavigationLink(isActive: $mainViewModel.isShowLogin) {
            LoginView()
        } label: {
            Text(Constants.navigationTitleString)
                .foregroundColor(.white)
                .font(.system(size: 35, weight: .bold, design: .default))
                .underline(true, color: .white)
        }
    }

    private var asyncImageView: some View {
        AsyncImage(
            url: URL(string: mainViewModel.urls[Int.random(in: 0 ... 6)])
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .accentColor(.accentColor)
            case let .success(image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 235, alignment: .center)
            case let .failure(error):
                VStack {
                    Image(systemName: Constants.questionImageName)
                    Text(error.localizedDescription)
                        .font(.headline)
                }
            default:
                EmptyView()
            }
        }
    }

    private var gradientView: some View {
        LinearGradient(
            colors: [.yellow, .red.opacity(Constants.opacityNumber)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
