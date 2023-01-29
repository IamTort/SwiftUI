// ColorSliderView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Кастомный слайдер
struct ColorSliderView: View {
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
            backSliderView
            sliderColorView
            HStack {
                VStack {
                    dotView
                    makeTextView(text: colorSliderViewModel.makeMinimumValueText())
                }
                .offset(x: colorSliderViewModel.minimumValue - Constants.dotPaddingNumber, y: 18)
                .gesture(DragGesture()
                    .onChanged { value in
                        colorSliderViewModel.makeChangeMinimumValue(value: value)
                    })
                VStack {
                    dotView
                    makeTextView(text: colorSliderViewModel.makeMaximumValueText())
                }
                .offset(x: colorSliderViewModel.maximumValue, y: 18)
                .gesture(DragGesture()
                    .onChanged { value in
                        colorSliderViewModel.makeChangeMaximumValue(value: value)
                    })
            }
        }
        .padding(.horizontal, 30)
    }

    // MARK: - Private Properties
    
    @StateObject private var colorSliderViewModel = ColorSliderViewModel()
    
    private var backSliderView: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.4))
            .frame(width: colorSliderViewModel.totalSliderWidth, height: 12, alignment: .center)
    }
    
    private var sliderColorView: some View {
        Rectangle()
            .fill(Color.purple)
            .frame(
                width: colorSliderViewModel.makeWidthSlider(),
                height: 12
            )
            .offset(x: colorSliderViewModel.minimumValue)
    }
    
    private var dotView: some View {
        Circle()
            .fill(.orange)
            .frame(width: colorSliderViewModel.sliderDotHeight, height: colorSliderViewModel.sliderDotHeight)
    }
    
    // MARK: - Private methods
    
    private func makeTextView(text: String) -> some View {
        Text(text)
            .font(.system(size: 12))
            .fontWeight(.bold)
            .frame(width: 45, height: 30, alignment: .center)
    }
}
