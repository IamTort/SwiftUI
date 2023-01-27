// CustomSliderView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Кастомный слайдер
struct CustomSliderView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let constNumber: CGFloat = 50
        static let dolarString = "$"
        static let dotPaddingNumber: CGFloat = 15
    }

    // MARK: - Public Properties

    @State var maxPriceVal: CGFloat = 6500
    @State var sliderDotHeight: CGFloat = 20
    @State var sliderStep: CGFloat = 500
    @State var minimumValue: CGFloat = 4.8
    @State var maximumValue: CGFloat = 23.85
    @State var totalSliderWidth = UIScreen.main.bounds.width - 80

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray.opacity(0.4))
                .frame(width: totalSliderWidth, height: 12, alignment: .center)
            Rectangle()
                .fill(Color.purple)
                .frame(
                    width: maximumValue - minimumValue + sliderDotHeight + Constants.constNumber,
                    height: 12
                )
                .offset(x: minimumValue)
            HStack {
                VStack {
                    Circle()
                        .fill(.orange)
                        .frame(width: sliderDotHeight, height: sliderDotHeight)

                    let text = minimumValue / sliderPxPerStep() * sliderStep
                    Text("\(Int(text))\(Constants.dolarString)")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .frame(width: 45, height: 30, alignment: .center)
                }
                .offset(x: minimumValue - Constants.dotPaddingNumber, y: 18)
                .gesture(DragGesture().onChanged { value in
                    if
                        value.location.x > 0,
                        value.location.x <= maximumValue
                    {
                        let stpCnt = floorf(Float(value.location.x / sliderPxPerStep()))
                        minimumValue = CGFloat(stpCnt) * sliderPxPerStep()
                    }
                })
                VStack {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: sliderDotHeight, height: sliderDotHeight)
                    let text = maximumValue / sliderPxPerStep() * sliderStep
                    Text("\(Int(text))\(Constants.dolarString)")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .frame(width: 45, height: 30, alignment: .center)
                }
                .offset(x: maximumValue, y: 18)
                .gesture(DragGesture().onChanged { value in
                    if
                        value.location.x >= minimumValue,
                        value.location.x <= totalSliderWidth
                    {
                        let stpCnt = ceil(value.location.x / sliderPxPerStep())
                        maximumValue = stpCnt * sliderPxPerStep()
                    }
                })
            }
        }
        .padding(.horizontal, 30)
    }

    // MARK: - Private methods

    private func sliderPxPerStep() -> CGFloat {
        sliderStep * (totalSliderWidth / maxPriceVal)
    }
}
