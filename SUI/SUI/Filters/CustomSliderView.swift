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
        static let paddingNumber: CGFloat = 80
        static let maxPriceValNumber: CGFloat = 5000
        static let sliderDotHeightNumber: CGFloat = 20
        static let sliderStepNumber: CGFloat = 500
        static let minimumValueNumber: CGFloat = 4.8
        static let maximumValueNumber: CGFloat = 23.85
    }

    // MARK: - Public Properties

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

    // MARK: - Private Properties

    @State private var maxPriceVal = Constants.maxPriceValNumber
    @State private var sliderDotHeight = Constants.sliderDotHeightNumber
    @State private var sliderStep = Constants.sliderStepNumber
    @State private var minimumValue = Constants.minimumValueNumber
    @State private var maximumValue = Constants.maximumValueNumber
    @State private var totalSliderWidth = UIScreen.main.bounds.width - Constants.paddingNumber

    // MARK: - Private methods

    private func sliderPxPerStep() -> CGFloat {
        sliderStep * (totalSliderWidth / maxPriceVal)
    }
}
