// ProfileView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран профиля
struct ProfileView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let envelopeImageName = "envelope.fill"
        static let bellImageName = "bell.fill"
        static let personImageName = "person.fill"
        static let cartImageName = "cart.fill"
        static let gearshapeImageName = "gearshape.fill"
        static let messagesText = "Messages"
        static let notificationText = "Notification"
        static let accountText = "Accounts Details"
        static let purchasesText = "My purchases"
        static let settingsText = "Settings"
        static let oneNumber = 1
        static let twoNumber = 2
        static let threeNumber = 3
        static let fourNumber = 4
        static let fiveNumber = 5
        static let avatarImageName = "1"
        static let usernameText = "Your Name"
        static let placeholderImageName = "placeholder"
        static let cityText = "Sity"
    }

    // MARK: - Public property

    var body: some View {
        VStack {
            navigationBarView
            List {
                sectionView
            }
            .listStyle(.inset)
            .navigationBarTitleDisplayMode(.inline)
            .listRowSeparator(.hidden)
            Spacer()
        }
    }

    // MARK: - Private Properties

    private var navigationBarView: some View {
        Rectangle()
            .fill(.clear)
            .frame(height: 0)
            .background(
                LinearGradient(
                    colors: [.yellow, .red.opacity(0.9)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }

    private var sectionView: some View {
        Section {
            makeRowView(
                imageName: Constants.envelopeImageName,
                title: Constants.messagesText,
                notificationCount: Constants.threeNumber
            )
            ZStack {
                makeRowView(
                    imageName: Constants.bellImageName,
                    title: Constants.notificationText,
                    notificationCount: Constants.fiveNumber
                )
                NavigationLink {
                    NotificationView()
                } label: {
                    EmptyView()
                }
                .opacity(0)
            }
            makeRowView(
                imageName: Constants.personImageName,
                title: Constants.accountText,
                notificationCount: nil
            )
            makeRowView(
                imageName: Constants.cartImageName,
                title: Constants.purchasesText,
                notificationCount: nil
            )
            ZStack {
                makeRowView(
                    imageName: Constants.gearshapeImageName,
                    title: Constants.settingsText,
                    notificationCount: nil
                )
                NavigationLink {
                    CardView()
                } label: {
                    EmptyView()
                }
                .opacity(0)
            }
        } header: {
            VStack {
                userImageView
                userNameTextView
                HStack {
                    Spacer()
                    userLocationImageView
                    userLocationTextView
                    Spacer()
                }
                .offset(y: -10)
            }
        }
        .font(.system(size: 20, weight: .medium, design: .default))
        .padding(.horizontal, 20)
        .listRowSeparator(.hidden)
    }

    private var userImageView: some View {
        Image(Constants.avatarImageName)
            .resizable()
            .frame(height: 150)
            .cornerRadius(10)
            .clipShape(Circle())
    }

    private var userNameTextView: some View {
        Text(Constants.usernameText)
            .font(.system(size: 20, weight: .bold, design: .default))
            .foregroundColor(.black)
    }

    private var userLocationImageView: some View {
        Image(Constants.placeholderImageName)
            .resizable()
            .frame(width: 20, height: 20)
    }

    private var userLocationTextView: some View {
        Text(Constants.cityText)
            .font(.system(size: 20, weight: .regular, design: .default))
            .foregroundColor(.black)
    }

    private var badgeBackView: some View {
        Circle()
            .fill(Color.clear)
            .modifier(GradientModifier())
            .clipShape(Circle())
            .frame(width: 45)
    }

    private var lineView: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.lightGray)
    }

    // MARK: - Private methods

    private func makeRowView(imageName: String, title: String, notificationCount: Int?) -> some View {
        HStack {
            makeRowImageView(imageName: imageName)
            VStack {
                HStack {
                    makeRowTextView(title: title)
                    Spacer()
                    if let notificationCount = notificationCount {
                        ZStack {
                            badgeBackView
                            Text(String(notificationCount))
                                .bold()
                                .foregroundColor(.white)
                        }
                        .offset(y: 8)
                    }
                }
                lineView
            }
        }
    }

    private func makeRowImageView(imageName: String) -> some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: 30, height: 25, alignment: .center)
            .offset(x: -10, y: 7)
            .foregroundColor(.lightGray)
    }

    private func makeRowTextView(title: String) -> some View {
        Text(title)
            .offset(y: 8)
            .font(.system(size: 23, weight: .regular, design: .default))
    }
}
