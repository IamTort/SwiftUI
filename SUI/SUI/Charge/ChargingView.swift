// ChargingView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран зарядки
struct ChargingView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let chargingTitle = "CHARGING"
        static let emptyString = ""
        static let greenColorString = "green"
        static let underSliderString = "Set Charge Limit"
        static let chargeString = "65"
        static let percentString = "%"
        static let seventyPercentString = "75%"
        static let teslaImageName = "teslaOnSide"
        static let dotImageName = "sliderThumb"
        static let hundredString = "100%"
        static let superChargersTitle = "Nearby Superchargers"
        static let placeImageName = "location"
        static let gearshapeImageName = "gearshapeIcon"
        static let backChevronImageName = "backChevron"
        static let upChevronImageName = "upChevron"
        static let chargeImageName = "charge"
        static let availableString = "available"
        static let slashString = "/"
    }

    // MARK: - Public properties

    let chargers = TeslaCharger.getChargers()

    var body: some View {
        backgroundStackView(isLock: false) {
            VStack {
                titleView
                carImageView
                ZStack {
                    percentTitleTextView
                    chargeView
                    fillChargeView
                }
                .padding(.top, -120)
                .frame(height: 1)
                .padding(.bottom, 5)

                percentTextView
                sliderView
                boxView
                Spacer()
            }
        }
    }

    // MARK: - Private properties

    @Environment(\.presentationMode) private var presentation

    @StateObject private var chargingViewModel = ChargingViewModel()

    @Namespace private var nameSpace

    private var chargeView: some View {
        Rectangle()
            .fill(.clear)
            .background(
                ZStack {
                    ChargeShape(scaleValue: 1)
                        .stroke(Color(uiColor: .systemGray3), style: StrokeStyle(lineWidth: 1))
                    ChargeShape(scaleValue: 1)
                        .fill(LinearGradient(
                            colors: [.white.opacity(0.2), .lightShadow, .darkShadow.opacity(1), .lightShadow],
                            startPoint: .init(x: 0.5, y: 0.65),
                            endPoint: .init(x: 0.5, y: 1)
                        ))
                }
            )
            .frame(width: 300)
    }

    private var fillChargeView: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .background(
                    ChargeShape(scaleValue: 0.55)
                        .fill(LinearGradient(
                            colors: [.topGradient, Color(Constants.greenColorString), .bottomGradient],
                            startPoint: .init(x: 0.5, y: 0.7),
                            endPoint: .init(x: 0.5, y: 1.1)
                        ))
                        .shadow(color: .bottomGradient, radius: 5)
                )
                .frame(width: 300)
            Rectangle()
                .fill(LinearGradient(
                    colors: [.clear, .bottomGradient.opacity(0.1)],
                    startPoint: .top,
                    endPoint: .init(x: 0.5, y: 0.4)
                ))
                .frame(width: 300 * 0.55, height: 130)
                .offset(x: -68, y: 0)
        }
    }

    private var sliderView: some View {
        VStack {
            ZStack {
                lineView
                dotImageView
                    .onTapGesture {
                        chargingViewModel.isSliderMoved.toggle()
                    }
                    .padding(.top, 12)
                    .padding(.leading, chargingViewModel.isSliderMoved ? 290 : 140)
            }
            .padding(.top, -20)
            Text(Constants.underSliderString)
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .padding(.top, -20)
        }
    }

    private var carImageView: some View {
        Image(Constants.teslaImageName)
            .resizable()
            .frame(width: 350, height: 200)
            .offset(y: -30)
    }

    private var dotImageView: some View {
        Image(Constants.dotImageName)
    }

    private var lineView: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(gradient)
            .frame(width: 300, height: 10)
    }

    private var gradient: LinearGradient {
        LinearGradient(
            colors: [.black.opacity(0.5), .lightShadow],
            startPoint: .top,
            endPoint: .init(x: 0.5, y: 0.7)
        )
    }

    private var titleView: some View {
        HStack {
            Spacer()
            backButtonView
            Spacer()
            Text(Constants.chargingTitle)
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .semibold, design: .default))
            Spacer()
            settingsButtonView
            Spacer()
        }
        .padding(.top, -20)
    }

    private var settingsButtonView: some View {
        Button {} label: {
            Image(Constants.gearshapeImageName)
                .neumorphismCircleButtonUnSelectedCircleStyle()
        }
    }

    private var backButtonView: some View {
        Button {
            self.presentation.wrappedValue.dismiss()
        } label: {
            Image(Constants.backChevronImageName)
                .neumorphismCircleButtonUnSelectedCircleStyle()
        }
    }

    private var upButtonView: some View {
        Button {} label: {
            Image(Constants.upChevronImageName)
                .rotationEffect(chargingViewModel.isButtonPressed ? .degrees(180) : .degrees(0))
                .onTapGesture {
                    withAnimation(.easeOut) {
                        chargingViewModel.isButtonPressed.toggle()
                    }
                }
                .neumorphismCircleButtonUnSelectedCircleStyle()
        }
    }

    private var serifView: some View {
        Rectangle()
            .fill(LinearGradient(
                colors: [.topGradient, .bottomGradient],
                startPoint: .top,
                endPoint: .bottom
            ))
            .frame(width: 2, height: 7)
    }

    private var percentTitleTextView: some View {
        HStack {
            Text(Constants.chargeString)
                .font(.system(size: 35, weight: .bold, design: .default))
            Text(Constants.percentString)
                .font(.system(size: 25))
                .foregroundColor(.gray)
                .offset(x: -5, y: 5)
        }
        .offset(y: -10)
    }

    private var percentTextView: some View {
        VStack {
            HStack {
                serifView
                    .padding(.leading, 220)
                serifView
                    .padding(.leading, 65)
            }
            HStack {
                Text(Constants.seventyPercentString)
                    .padding(.leading, 215)
                Text(Constants.hundredString)
                    .frame(width: 50)
                    .padding(.leading, 25)
            }
            .font(.system(size: 12))
            .padding(.top, -5)
        }
    }

    private var boxView: some View {
        VStack {
            HStack(spacing: 40) {
                Text(Constants.superChargersTitle)
                    .font(.system(size: 20))
                    .bold()
                upButtonView
            }
            if chargingViewModel.isButtonPressed {
                withAnimation(.linear.delay(1)) {
                    listTextView
                }
            }
        }
        .padding()
        .frame(width: 340, height: chargingViewModel.isButtonPressed ? 298 : 130)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color.black, lineWidth: 10)
                .blur(radius: 10)
                .mask(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(
                            LinearGradient(
                                colors: [Color.darkShadow, Color.clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.white.opacity(0.11), lineWidth: 8)
                        .blur(radius: 4)
                        .offset(x: -5, y: -2)
                        .mask(
                            RoundedRectangle(cornerRadius: 50)
                                .fill(LinearGradient(
                                    colors: [Color.clear, Color.black],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ))
                        )
                        .neumorphismUnSelectedStyle()
                )
        )
    }

    private var listTextView: some View {
        VStack {
            ForEach(chargers) { element in
                HStack {
                    VStack(alignment: .leading) {
                        Text(element.place)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.gray)
                            .frame(width: 200)
                            .offset(x: -10)
                        HStack {
                            Text("\(element.availableCount)")
                            Text(Constants.slashString)
                                .foregroundColor(.gray)
                                .offset(x: -5)
                            Text("\(element.count) \(Constants.availableString)")
                                .foregroundColor(.gray)
                                .offset(x: -10)
                        }
                        .font(.system(size: 14))
                        .offset(x: 15)
                    }
                    .offset(x: -10)
                    Spacer()
                    VStack {
                        ZStack {
                            Image(Constants.placeImageName)
                            Image(Constants.chargeImageName)
                                .resizable()
                                .frame(width: 11, height: 18)
                                .foregroundColor(.black.opacity(1))
                                .offset(y: -5)
                        }
                        Text(element.mileage)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.bottom, 15)
            }
        }
    }
}

struct ChargingView_Previews: PreviewProvider {
    static var previews: some View {
        ChargingView()
            .environment(\.colorScheme, .dark)
    }
}
