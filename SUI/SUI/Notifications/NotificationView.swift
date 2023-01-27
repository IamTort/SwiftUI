// NotificationView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран уведомлений
struct NotificationView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let backImageName = "chevron.backward"
        static let okButtonTitle = "Ok"
        static let oneNumber = 1
        static let emptyString = ""
        static let productTitle = "Product updates"
        static let productDescriptionString = "Stair lifts free the freedom of your home"
        static let commentsTitle = "Comments"
        static let commentsDescriptionString = "Adversting relationships vs business"
        static let offerTitle = "Offer updates"
        static let offerDescriptionString = "A right media mix can make"
        static let notificationTitle = "Notifications"
        static let notificationDescriptionString = "Create remarkable poster prints"
        static let buttonTitle = "Update Settings"
        static let alertTitle = "Settings apply"
        static let fortyNumber: CGFloat = 40
        static let seventyNumber: CGFloat = 70
    }

    // MARK: - Public Properties

    var body: some View {
        NavigationView {
            VStack {
                navigationBarView
                ZStack {
                    backgroundView
                    backgroundSquareView
                    scrollRowsView
                }
                updateButtonView
                Spacer(minLength: 130)
            }
            .background(.white)
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Private Properties

    @Environment(\.presentationMode) private var presentation

    @StateObject private var notificationViewModel = NotificationViewModel()

    private var navigationBarView: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .navigationBarTitleDisplayMode(.inline)
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
                .navigationBarItems(
                    leading:
                    navigationBarButtonView
                )
                .frame(height: 4)
        }
    }

    private var titleTextView: some View {
        Text(Constants.notificationTitle)
            .font(.system(size: 30, weight: .bold, design: .default))
            .foregroundColor(.white)
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

    private var updateButtonView: some View {
        Button(Constants.buttonTitle) {
            notificationViewModel.isAlertCodeShown = true
        }
        .frame(width: 320, height: 80)
        .background(.red)
        .foregroundColor(.white)
        .font(.system(size: 28, weight: .bold, design: .default))
        .cornerRadius(40)
        .padding(.top, 50)
        .alert(isPresented: $notificationViewModel.isAlertCodeShown) {
            Alert(
                title: Text(Constants.alertTitle),
                message:
                nil,
                dismissButton: .default(Text(Constants.okButtonTitle))
            )
        }
    }

    private var backgroundView: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width)
            .foregroundColor(.white)
    }

    private var backgroundSquareView: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(
                width: UIScreen.main.bounds.width - Constants.fortyNumber,
                height: UIScreen.main.bounds.width - Constants.seventyNumber
            )
            .foregroundColor(.white)
            .shadow(radius: 7)
            .padding(.top, 10)
    }

    private var scrollRowsView: some View {
        ScrollView {
            makeRowView(
                title: Constants.productTitle,
                description: Constants.productDescriptionString,
                binding: $notificationViewModel.isProductUpdatesOn
            )
            makeRowView(
                title: Constants.commentsTitle,
                description: Constants.commentsDescriptionString,
                binding: $notificationViewModel.isCommentsOn
            )
            makeRowView(
                title: Constants.offerTitle,
                description: Constants.offerDescriptionString,
                binding: $notificationViewModel.isOfferUpdatesOn
            )
            VStack {
                HStack {
                    Text(Constants.notificationTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Toggle(Constants.emptyString, isOn: $notificationViewModel.isNotificationsUpdatesOn)
                        .toggleStyle(NotificationChecklistToggleStyle())
                }
                Text(Constants.notificationDescriptionString)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(30)
        .padding(.top, 45)
        .padding(.bottom, 30)
    }

    // MARK: - Private methods

    private func makeRowView(title: String, description: String, binding: Binding<Bool>) -> some View {
        VStack {
            HStack {
                Text(title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Toggle(Constants.emptyString, isOn: binding)
                    .toggleStyle(NotificationChecklistToggleStyle())
            }
            Text(description)
                .frame(maxWidth: .infinity, alignment: .leading)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.lightGray)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
