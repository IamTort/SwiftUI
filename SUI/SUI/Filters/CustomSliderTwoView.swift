// CustomSliderTwoView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Кастомный слайдер
struct CustomSliderTwoView: View {
    // MARK: - Public properties

    @State var minValue: CGFloat
    @State var maxValue: CGFloat
    var totalWidth: CGFloat = UIScreen.main.bounds.width - 80

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(.purple.opacity(0.2))
                .frame(height: 10)
            Rectangle()
                .fill(.purple)
                .frame(width: (maxValue - minValue) + 30, height: 10)
                .offset(x: minValue + 30)
            HStack {
                makeMinValueCircleView()
                makeMaxValueCircleView()
            }
        }
        .offset(y: -80)
        .padding()
    }

    // MARK: - Private methods

    private func makeMaxValueCircleView() -> some View {
        VStack {
            Circle()
                .fill(.orange)
                .frame(width: 30, height: 30)
                .background(
                    Circle()
                        .stroke(.white, lineWidth: 5)
                )
                .offset(x: maxValue)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.location.x <= totalWidth, value.location.x >= minValue, value.location.x > 8 {
                                maxValue = value.location.x
                            }
                        }
                )
            Spacer()
                .frame(height: 5)
            let text = "\(Int(maxValue / calculatePerStep()) * 500)$"
            Text(text)
                .font(.system(size: 10))
                .fontWeight(.bold)
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(Color(.darkGray))
                .offset(x: maxValue)
        }
        .offset(y: 15)
    }

    private func makeMinValueCircleView() -> some View {
        VStack {
            Circle()
                .fill(.orange)
                .frame(width: 30, height: 30)
                .background(
                    Circle()
                        .stroke(.white, lineWidth: 5)
                )
                .offset(x: minValue)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.location.x >= 0, value.location.x <= maxValue {
                                minValue = value.location.x
                            }
                        }
                )
            Spacer()
                .frame(height: 5)
            let text = "\(Int(minValue / calculatePerStep()) * 500)$"
            Text(text)
                .font(.system(size: 10))
                .fontWeight(.bold)
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(Color(.darkGray))
                .offset(x: CGFloat(minValue))
        }
        .offset(y: 15)
    }

    private func calculatePerStep() -> CGFloat {
        (totalWidth / 5500) * 500
    }
}
