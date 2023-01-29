// ProductView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран описания товара
struct ProductView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let chairImageName = "dining"
        static let chairString = "Chair"
        static let heartImageName = "heart"
        static let priceString = "$55"
        static let buyButton = "Buy now"
        static let darkPurpleColorName = "darkPurple"
        static let lightGrayColorName = "lightGray"
        static let bagImageName = "bag"
        static let descriptionTitle = "Description"
        static let tenSpaceNumber: CGFloat = 10
        static let progressViewText = "Chars ="
        static let progressViewScoreText = "/ 150"
        static let charCountNumber = 150
        static let squareViewPaddingNumber: CGFloat = 60
        static let heartFillImageName = "heart.fill"
    }

    // MARK: - Public Properties

    var body: some View {
        ZStack {
            VStack {
                navigationBarView
                Spacer(minLength: 20)
                VStack(spacing: 20) {
                    chairImageView
                    squareView
                    HStack {
                        bagImageView
                        descriptionTextView
                        Spacer()
                    }
                    charProgressView
                    textEditorView
                }
                Spacer(minLength: 110)
            }
            .navigationBarBackButtonHidden(true)
        }
        .gesture(magnification)
    }

    // MARK: - Private Properties

    @ObservedObject private var keyboard = KeyboardResponder()

    @StateObject private var chairViewModel = ProductViewModel()

    private var magnification: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                chairViewModel.scale = value
            }
            .onEnded { _ in
                chairViewModel.scale = 1
            }
    }

    private var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                chairViewModel.tapped.toggle()
            }
    }

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

    private var chairImageView: some View {
        Image(Constants.chairImageName)
            .resizable()
            .foregroundColor(.yellow)
            .frame(width: 200, height: 200)
            .scaleEffect(chairViewModel.scale)
    }

    private var squareView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
            VStack {
                HStack {
                    chairTextView
                    Spacer()
                    heartImageView
                }
                .padding(.horizontal, 30)
                HStack {
                    priceTextView
                    Spacer()
                    buyButtonView
                }
                .padding(.horizontal, 30)
                .padding(5)
            }
        }
        .frame(width: UIScreen.main.bounds.width - Constants.squareViewPaddingNumber, height: 120)
        .shadow(color: Color(Constants.lightGrayColorName), radius: 7)
    }

    private var heartImageView: some View {
        Image(systemName: chairViewModel.tapped ? Constants.heartFillImageName : Constants.heartImageName)
            .resizable()
            .frame(width: 45, height: 35)
            .foregroundColor(.red)
            .gesture(tap)
    }

    private var priceTextView: some View {
        Text(Constants.priceString)
            .font(.system(size: 40, weight: .bold, design: .monospaced))
            .foregroundColor(Color(Constants.darkPurpleColorName))
    }

    private var chairTextView: some View {
        VStack(spacing: 5) {
            Text(Constants.chairString)
                .font(.system(size: 28, weight: .bold, design: .default))
            Rectangle()
                .frame(width: 70, height: 3)
                .foregroundColor(.yellow)
        }
    }

    private var buyButtonView: some View {
        Button(Constants.buyButton) {}
            .frame(width: 120, height: 40)
            .background(.red)
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(40)
    }

    private var bagImageView: some View {
        Image(systemName: Constants.bagImageName)
            .resizable()
            .frame(width: 30, height: 30)
            .padding(.leading, 30)
            .padding(.trailing, 10)
    }

    private var descriptionTextView: some View {
        Text(Constants.descriptionTitle)
            .font(.system(size: 20, weight: .bold, design: .default))
    }

    private var textEditorView: some View {
        TextEditor(text: $chairViewModel.text)
            .foregroundColor(.black)
            .font(.system(size: 20, weight: .bold, design: .default))
            .frame(width: UIScreen.main.bounds.width - 60, height: 120)
            .offset(y: -20)
            .padding(.bottom, keyboard.currentHeight)
            .onChange(of: chairViewModel.text) { text in
                chairViewModel.totalChars = chairViewModel.text.count
                if chairViewModel.totalChars <= Constants.charCountNumber {
                    chairViewModel.lastText = text
                } else {
                    chairViewModel.text = chairViewModel.lastText
                }
            }
    }

    private var charProgressView: some View {
        ProgressView(
            "\(Constants.progressViewText)" + " \(chairViewModel.text.count) \(Constants.progressViewScoreText)",
            value: Double(chairViewModel.text.count),
            total: Double(Constants.charCountNumber)
        )
        .frame(width: CGFloat(Constants.charCountNumber))
        .padding()
        .foregroundColor(.blue)
        .accentColor(.blue)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
