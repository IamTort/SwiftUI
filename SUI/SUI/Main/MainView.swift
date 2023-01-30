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
        static let developmentString = "Разработано под чутким наблюдением Евгения Зверика и Александра Коха"
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
                    if mainViewModel.isLongTap {
                        developmentView
                    }
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

    private var longGesture: some Gesture {
        LongPressGesture(minimumDuration: 2)
            .onEnded { _ in
                mainViewModel.isLongTap.toggle()
                mainViewModel.longTapViewHide()
            }
    }

    private var titleTextView: some View {
        Text(Constants.titleString)
            .foregroundColor(.white)
            .font(.system(.largeTitle, design: .default))
            .bold()
            .multilineTextAlignment(.center)
            .opacity(mainViewModel.isLoadingScreen ? 1 : 0)
            .animation(.linear(duration: 0.5).delay(1), value: mainViewModel.isLoadingScreen)
    }

    private var startButtonView: some View {
        ZStack {
            Button(Constants.startButtonTitle) {
                mainViewModel.isChairShown = true
            }
            .frame(width: 320, height: 80)
            .background(.white)
            .foregroundColor(Color(Constants.darkPurpleColorName))
            .font(.system(size: 28, weight: .bold, design: .default))
            .cornerRadius(40)
            .padding(30)
            .padding(.bottom, 20)
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .opacity(0.01)
                .frame(width: 320, height: 80)
                .gesture(longGesture)
        }
        .offset(x: mainViewModel.isLoadingScreen ? 0 : 600)
        .animation(.linear(duration: 0.5).delay(1.5), value: mainViewModel.isLoadingScreen)
    }

    private var navigationLinkView: some View {
        NavigationLink(isActive: $mainViewModel.isChairShown) {
            MainTabView()
                .navigationBarBackButtonHidden(true)
        } label: {
            EmptyView()
        }
    }

    private var questionTextView: some View {
        Text(Constants.questionString)
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .offset(x: mainViewModel.isLoadingScreen ? 0 : 500)
            .animation(.linear(duration: 0.5).delay(2.5), value: mainViewModel.isLoadingScreen)
    }

    private var loginNavigationLinkView: some View {
        NavigationLink(isActive: $mainViewModel.isLoginShown) {
            LoginView()
        } label: {
            Text(Constants.navigationTitleString)
                .foregroundColor(.white)
                .font(.system(size: 35, weight: .bold, design: .default))
                .underline(true, color: .white)
        }
        .offset(x: mainViewModel.isLoadingScreen ? 0 : 500)
        .animation(.linear(duration: 0.5).delay(3.5), value: mainViewModel.isLoadingScreen)
    }

    private var asyncImageView: some View {
        AsyncImage(
            url: mainViewModel.generateUrl()
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .accentColor(.accentColor)
                    .onAppear {
                        mainViewModel.isLoadingScreen = true
                    }
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

    private var developmentView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: 300, height: 100, alignment: .center)
            Text(Constants.developmentString)
                .lineLimit(3)
                .frame(width: 250, height: 100)
                .font(.system(size: 15, weight: .bold, design: .default))
        }
        .opacity(mainViewModel.isLongTap ? 1 : 0)
        .gesture(longGesture)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
