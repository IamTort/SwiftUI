// VerificationView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран верификации
struct VerificationView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let mailImageName = "mail"
        static let verificationString = "Verification Code"
        static let emptyString = ""
        static let checkString = "Check the SMS"
        static let descriptionString = "message to get a verification code"
        static let continueButtonName = "Continue"
        static let actionSheetMessageString = "We already know about the bug and fix it soon"
        static let okButtonTitle = "Ok"
        static let descriptionTitle = "Didn't receive SMS?"
        static let sendButtonString = "Send SMS again"
        static let alertTitle = "Fill in from message"
        static let progressViewTitle = "Processing"
        static let verificationTitle = "Verification"
        static let backImageName = "chevron.backward"
        static let oneNumber = 1
        static let timeIntervalNumber: Float = 1
        static let maxValueNumber: Float = 10
        static let startValueNumber: Float = 0
    }

    // MARK: - Public Properties

    @FocusState private var isFirstNumberFocused: Bool
    @FocusState private var isSecondNumberFocused: Bool
    @FocusState private var isThirdNumberFocused: Bool
    @FocusState private var isForthNumberFocused: Bool

    var body: some View {
        ZStack {
            VStack {
                navigationBarView

                VStack(spacing: 30) {
                    Spacer()
                    mailImageView
                    verificationTextView

                    HStack {
                        firstTextFieldView
                        secondTextFieldView
                        thirdTextFieldView
                        forthTextFieldView
                    }

                    VStack(spacing: 10) {
                        progressView
                        checkTextView
                        descriptionTextView
                    }
                    continueButtonView

                    VStack(spacing: 10) {
                        questionTextView
                        sendCodeButtonView
                    }
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Private Properties

    @Environment(\.presentationMode) private var presentation

    @StateObject private var verificationViewModel = VerificationViewModel()

    private var progressView: some View {
        ProgressView(Constants.progressViewTitle, value: verificationViewModel.value, total: 10)
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
            .onAppear {
                verificationViewModel.hiddenProgress()
            }
            .isHidden(verificationViewModel.isHidden)
    }

    private var navigationBarView: some View {
        Rectangle()
            .fill(Color.clear)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    titleTextView
                }
            }
            .background(
                LinearGradient(
                    colors: [.yellow, .red.opacity(0.9)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                navigationBarButtonView
            )
            .frame(height: 10)
    }

    private var mailImageView: some View {
        Image(systemName: Constants.mailImageName)
            .resizable()
            .frame(width: 100, height: 100)
    }

    private var titleTextView: some View {
        Text(Constants.verificationTitle)
            .font(.system(size: 30, weight: .bold, design: .default))
            .foregroundColor(.white)
    }

    private var verificationTextView: some View {
        Text(Constants.verificationString)
            .font(.system(size: 28, weight: .medium, design: .default))
    }

    private var firstTextFieldView: some View {
        TextField(Constants.emptyString, text: $verificationViewModel.firstNumber)
            .modifier(TextSquireFieldModifier())
            .focused($isFirstNumberFocused)
            .onChange(of: verificationViewModel.firstNumber) { newValue in
                verificationViewModel.firstNumber = newValue
                isSecondNumberFocused = verificationViewModel.changeCodeNumber(newValue: newValue)
            }
    }

    private var secondTextFieldView: some View {
        TextField(Constants.emptyString, text: $verificationViewModel.secondNumber)
            .modifier(TextSquireFieldModifier())
            .focused($isSecondNumberFocused)
            .onChange(of: verificationViewModel.secondNumber) { newValue in
                verificationViewModel.secondNumber = newValue
                isThirdNumberFocused = verificationViewModel.changeCodeNumber(newValue: newValue)
            }
    }

    private var thirdTextFieldView: some View {
        TextField(Constants.emptyString, text: $verificationViewModel.thirdNumber)
            .modifier(TextSquireFieldModifier())
            .focused($isThirdNumberFocused)
            .onChange(of: verificationViewModel.thirdNumber) { newValue in
                verificationViewModel.thirdNumber = newValue
                isForthNumberFocused = verificationViewModel.changeCodeNumber(newValue: newValue)
            }
    }

    private var forthTextFieldView: some View {
        TextField(Constants.emptyString, text: $verificationViewModel.forthNumber)
            .modifier(TextSquireFieldModifier())
            .focused($isForthNumberFocused)
            .onChange(of: verificationViewModel.forthNumber) { newValue in
                verificationViewModel.forthNumber = newValue
            }
    }

    private var checkTextView: some View {
        Text(Constants.checkString)
            .font(.system(size: 28, weight: .bold, design: .default))
    }

    private var descriptionTextView: some View {
        Text(Constants.descriptionString)
            .font(.system(size: 20, weight: .regular, design: .default))
    }

    private var continueButtonView: some View {
        Button(Constants.continueButtonName) {
            verificationViewModel.isContinueVerificationShown = true
        }
        .frame(width: 320, height: 80)
        .background(.red)
        .foregroundColor(.white)
        .font(.system(size: 28, weight: .bold, design: .default))
        .cornerRadius(40)
        .actionSheet(isPresented: $verificationViewModel.isContinueVerificationShown) {
            ActionSheet(
                title: Text(Constants.emptyString),
                message: Text(
                    Constants.actionSheetMessageString
                ),
                buttons: [.cancel(Text(Constants.okButtonTitle), action: {
                    verificationViewModel.isHidden = false
                })]
            )
        }
    }

    private var questionTextView: some View {
        Text(Constants.descriptionTitle)
            .font(.system(size: 20, weight: .regular, design: .default))
    }

    private var navigationBarButtonView: some View {
        Button(action: {
            self.presentation.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Constants.backImageName)
                .resizable()
                .frame(width: 17, height: 35)
                .font(.headline)
                .foregroundColor(.white)
        })
    }

    private var sendCodeButtonView: some View {
        Button {
            verificationViewModel.isAlertCodeShown = true
            verificationViewModel.createRandomCode()

        } label: {
            Text(Constants.sendButtonString)
                .font(.system(size: 22))
                .foregroundColor(.purple)
        }
        .alert(isPresented: $verificationViewModel.isAlertCodeShown) {
            Alert(
                title: Text(Constants.alertTitle),
                message:
                Text(
                    verificationViewModel.getCodeNumber()
                ),
                dismissButton: .default(Text(Constants.okButtonTitle), action: {
                    verificationViewModel.setRandomCode()
                })
            )
        }
    }
}
