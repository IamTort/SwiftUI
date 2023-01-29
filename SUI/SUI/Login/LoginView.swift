// LoginView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран логина
struct LoginView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let lightGrayColorName = "lightGray"
        static let darkPurpleColorName = "darkPurple"
        static let loginString = "Log in"
        static let singUpString = "Sing up"
        static let textFieldPlaceholderString = "+0(000)-000-00-00"
        static let passwordTitle = "Password"
        static let passwordPlaceholderString = "Введите пароль"
        static let verificationButtonTitle = "CHECK VERIFICATION"
        static let singUpButtonTitle = "SING UP"
        static let alertTitle = "Помощь"
        static let alertMessageString = "Пароль должен содержать от 6 до 15 символов"
        static let alertButtonTitle = "Ok"
        static let questionText = "Forgot your password?"
        static let alertDoTitle = "Что делать?"
        static let alertMessageDoString = "Позвонить по номеру +8 999 99 99 999"
        static let logoViewHeight: CGFloat = 90
        static let twoNumber: CGFloat = 2
        static let phoneCountNumber = 18
        static let titleCornerRadiusNumber: CGFloat = 45
        static let errorImageString = "person.fill.xmark"
        static let emptyString = ""
    }

    // MARK: - Public Properties

    var body: some View {
        ZStack {
            VStack {
                navigationBarView
                Spacer(minLength: 50)
                VStack {
                    titleView
                    phoneTextFieldView
                    lineView
                    passwordTitleView
                    HStack {
                        passwordTextFieldView
                        textFieldImageView
                    }
                    lineView
                        .modifier(ShakeGeometryEffect(animatableData: CGFloat(loginViewModel.attempts)))
                }
                VStack {
                    progressView
                    verificationButtonView
                    singUpButtonView
                    singUpNavigationLinkView
                    alertButtonView
                    verificationNavigationLinkView
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Private Properties

    @StateObject private var loginViewModel = LoginViewModel()

    @FocusState private var loginIsFocused: Bool
    @FocusState private var passwordIsFocused: Bool

    private var navigationBarView: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: 1)
            .background(
                LinearGradient(
                    colors: [.yellow, .red.opacity(0.9)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }

    private var titleView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.titleCornerRadiusNumber)
                .stroke(Color(Constants.lightGrayColorName), lineWidth: 5)
                .frame(width: UIScreen.main.bounds.width - 80, height: Constants.logoViewHeight)
                .cornerRadius(40)
            HStack {
                Rectangle()
                    .fill(.clear)
                    .frame(
                        width: (UIScreen.main.bounds.width - 80) / Constants.twoNumber,
                        height: Constants.logoViewHeight
                    )
                Rectangle()
                    .foregroundColor(Color(Constants.lightGrayColorName))
                    .frame(
                        width: (UIScreen.main.bounds.width - 60) / Constants.twoNumber,
                        height: Constants.logoViewHeight
                    )
                    .cornerRadius(Constants.titleCornerRadiusNumber, corners: .bottomRight)
                    .cornerRadius(Constants.titleCornerRadiusNumber, corners: .topRight)
            }
            HStack(spacing: 58) {
                Text(Constants.loginString)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundColor(.purple)
                Text(Constants.singUpString)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundColor(Color(Constants.darkPurpleColorName))
            }
        }
        .padding(.bottom, 100)
    }

    private var phoneTextFieldView: some View {
        TextField(Constants.textFieldPlaceholderString, text: $loginViewModel.loginText)
            .keyboardType(.numberPad)
            .redTextField()
            .onChange(of: loginViewModel.loginText) { newValue in
                passwordIsFocused = loginViewModel.checkNewValue(newValue: newValue)
            }
            .focused($loginIsFocused)
    }

    private var textFieldImageView: some View {
        Image(systemName: Constants.errorImageString)
            .foregroundColor(.red)
            .padding(.trailing, 60)
            .opacity(loginViewModel.isShowIconError ? 1 : 0)
    }

    private var lineView: some View {
        Rectangle()
            .foregroundColor(Color(Constants.lightGrayColorName))
            .frame(width: UIScreen.main.bounds.width - 60, height: 3)
    }

    private var passwordTitleView: some View {
        HStack {
            Text(Constants.passwordTitle)
                .padding(30)
                .offset(y: 20)
            Spacer()
        }
    }

    private var passwordTextFieldView: some View {
        SecureField(Constants.passwordPlaceholderString, text: $loginViewModel.passwordText)
            .redTextField()
            .focused($passwordIsFocused)
            .keyboardType(.default)
            .foregroundColor(Color(Constants.lightGrayColorName))
            .modifier(ShakeGeometryEffect(animatableData: CGFloat(loginViewModel.attempts)))
    }

    private var verificationButtonView: some View {
        Button(Constants.verificationButtonTitle) {
            loginViewModel.isShowVerificationScreen = true
        }
        .frame(width: 320, height: 80)
        .background(.red)
        .foregroundColor(.white)
        .font(.system(size: 28, weight: .bold, design: .default))
        .cornerRadius(40)
        .padding(.top, 50)
    }

    private var singUpButtonView: some View {
        Button(Constants.singUpButtonTitle) {
            withAnimation(.default) {
                loginViewModel.checkInfo()
            }
        }
        .alert(isPresented: $loginViewModel.isPasswordAlertShown) {
            Alert(
                title: Text(Constants.alertTitle),
                message: Text(Constants.alertMessageString),
                dismissButton: .default(Text(Constants.alertButtonTitle))
            )
        }
        .frame(width: 320, height: 80)
        .background(
            LinearGradient(
                colors: [.orange, .red],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .foregroundColor(.white)
        .font(.system(size: 28, weight: .bold, design: .default))
        .cornerRadius(40)
    }

    private var alertButtonView: some View {
        Button {
            loginViewModel.isAlertShown = true
        } label: {
            Text(Constants.questionText)
                .bold()
                .foregroundColor(Color(Constants.darkPurpleColorName))
        }
        .alert(isPresented: $loginViewModel.isAlertShown) {
            Alert(
                title: Text(Constants.alertDoTitle),
                message: Text(Constants.alertMessageDoString),
                dismissButton: .default(Text(Constants.alertButtonTitle))
            )
        }
        .padding(.top, 20)
        .padding(.bottom, 30)
    }

    private var singUpNavigationLinkView: some View {
        NavigationLink(isActive: $loginViewModel.isShowChairScreen) {
            MainTabView()
                .navigationBarBackButtonHidden(true)
        } label: {
            EmptyView()
        }
    }

    private var verificationNavigationLinkView: some View {
        NavigationLink(isActive: $loginViewModel.isShowVerificationScreen) {
            VerificationView()
        } label: {
            EmptyView()
        }
        .padding(.bottom, 100)
    }

    private var progressView: some View {
        ProgressView(
            Constants.emptyString,
            value: loginViewModel.progressViewCount,
            total: loginViewModel.progressMaxCount
        )
        .padding(.horizontal, 40)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
