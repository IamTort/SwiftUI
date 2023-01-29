// NotificationChecklistToggleStyle.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Тогл на экране уведомлений
struct NotificationChecklistToggleStyle: ToggleStyle {
    // MARK: - Private Constants

    private enum Constants {
        static let toggleWidthNumber: CGFloat = 70
        static let toggleHeightNumber: CGFloat = 27
        static let twoNumber: CGFloat = 2
        static let circleDecreaseNumber: CGFloat = 5
        static let circleIndentNumber: CGFloat = 2
        static let toggleOffsetYNumber: CGFloat = 10
    }

    // MARK: - Private Properties

    private let width: CGFloat = Constants.toggleWidthNumber
    private let height: CGFloat = Constants.toggleHeightNumber

    // MARK: - Public method

    func makeBody(configuration: Configuration) -> some View {
        let switchBackground = configuration.isOn
            ? LinearGradient(
                colors: [.yellow, .red.opacity(0.9)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            : LinearGradient(
                colors: [.lightGray, .lightGray],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        HStack {
            configuration
                .label
            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                RoundedRectangle(cornerRadius: height / Constants.twoNumber)
                    .fill(.clear)
                    .frame(width: width, height: height)
                    .background(switchBackground)
                    .cornerRadius(12)

                Circle()
                    .frame(
                        width: height - Constants.circleDecreaseNumber,
                        height: height - Constants.circleDecreaseNumber
                    )
                    .padding(Constants.circleIndentNumber)
                    .foregroundColor(configuration.isOn ? .white : .gray)
                    .onTapGesture {
                        withAnimation {
                            configuration.$isOn.wrappedValue.toggle()
                        }
                    }
            }
            .opacity(configuration.isOn ? 100 : 25)
        }
    }
}
