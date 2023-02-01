// ClimateView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран управления климатом
struct ClimateView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let alertTitle = "Tesla support"
        static let alertImageName = "questionmark.circle.fill"
        static let alertLinkString = "https://www.tesla.com/support"
        static let alertButtonString = "Cancel"
        static let climateTitle = "CLIMATE"
        static let emptyString = ""
        static let airConditionString = "Ac"
        static let sliderDotImageName = "slide"
        static let fanString = "Fan"
        static let heatString = "Heat"
        static let avtoString = "Auto"
        static let heatImageName = "heatIcon"
        static let fanImageName = "fanIcon"
        static let avtoImageName = "autoIcon"
        static let acImageName = "snoIcon"
        static let powerImageName = "power"
        static let gearshapeImageName = "gearshapeIcon"
        static let backChevronImageName = "backChevron"
        static let lightShadowString = "lightShadow"
        static let celsusString = "º C"
        static let discGroupPaddingNumber: CGFloat = 40
    }

    // MARK: - Public properties

    var body: some View {
        backgroundStackView(isLock: false) {
            ZStack {
                VStack {
                    titleView
                    circleView
                    disclosureGroupView
                    Spacer()
                }
                climateActionSheet
                if climateViewModel.isAlertShown {
                    alertView
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .environmentObject(climateViewModel)
    }

    // MARK: - Private properties

    @Environment(\.presentationMode) private var presentation

    @StateObject private var climateViewModel = ClimateViewModel()

    @State private var climateActionSheet = ActionSheetView()

    private var disclosureGroupView: some View {
        DisclosureGroup(Constants.emptyString, isExpanded: $climateViewModel.revealDetails) {
            VStack {
                acView
                fanView
                heatView
                autoView
            }
        }
        .frame(width: UIScreen.main.bounds.width - Constants.discGroupPaddingNumber)
    }

    private var titleView: some View {
        HStack {
            Spacer()
            backButtonView
            Spacer()
            Text(Constants.climateTitle)
                .foregroundColor(.white)
                .font(.system(size: 26, weight: .semibold, design: .default))
            Spacer()
            settingsButtonView
            Spacer()
        }
        .padding(.top, 90)
    }

    private var acView: some View {
        HStack(spacing: 30) {
            Text(Constants.airConditionString)
                .fontWeight(.semibold)
                .foregroundColor(climateViewModel.isSliderOn ? .white : .gray)
                .frame(width: 40)
            snowButtonView
            ClimateSliderView()
        }
    }

    private var fanView: some View {
        HStack(spacing: 30) {
            Text(Constants.fanString)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .frame(width: 40)
            makeButtonView(imageName: Constants.fanImageName)
            ZStack {
                lineView
                Image(Constants.sliderDotImageName)
                    .offset(x: -85, y: 5)
            }
        }
    }

    private var heatView: some View {
        HStack(spacing: 30) {
            Text(Constants.heatString)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .frame(width: 40)
            makeButtonView(imageName: Constants.heatImageName)
            ZStack {
                lineView
                Image(Constants.sliderDotImageName)
                    .offset(x: -85, y: 5)
            }
        }
    }

    private var autoView: some View {
        HStack(spacing: 30) {
            Text(Constants.avtoString)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .frame(width: 40)
            makeButtonView(imageName: Constants.avtoImageName)
            ZStack {
                lineView
                Image(Constants.sliderDotImageName)
                    .offset(x: -85, y: 5)
            }
        }
    }

    private var buttonGradient: LinearGradient {
        LinearGradient(
            colors: [.topBlue, .topGradient],
            startPoint: .init(x: 0, y: 0.5),
            endPoint: .init(x: 1, y: 1)
        )
    }

    private var snowButtonView: some View {
        Button {} label: {
            Image(Constants.acImageName)
                .frame(width: 20, height: 20)
                .foregroundColor(climateViewModel.isSliderOn ? .topGradient : .lightGray)
                .neumorphismUnSelectedCircleStyle()
                .overlay(
                    Circle()
                        .stroke(gradient, lineWidth: 2)
                        .opacity(0)
                )
        }
    }

    private var onButtonView: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(
                    colors: [.topGradient, .blue.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(height: 70)
                .neumorphismUnSelectedStyle()
            Button {
                climateViewModel.isOnClimate.toggle()
            } label: {
                Image(Constants.powerImageName)
                    .foregroundColor(.white)
                    .frame(width: 63, height: 63)
                    .background(
                        Circle()
                            .fill(buttonGradient)
                    )
            }
        }
    }

    private var lineView: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(gradient)
            .frame(width: 200, height: 8)
    }

    private var settingsButtonView: some View {
        Button {
            climateViewModel.isAlertShown.toggle()
        } label: {
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

    private var circleView: some View {
        ZStack {
            Circle()
                .fill(circleReverseGradient)
                .frame(width: 200, height: 200)
                .shadow(color: .lightShadow, radius: 13, x: -20, y: -20)
                .shadow(color: .darkShadow, radius: 7, x: 20, y: 20)
                .overlay(
                    Circle()
                        .fill(circleGradient)
                        .frame(width: 140, height: 140)
                        .shadow(color: .lightShadow, radius: 7, x: -7, y: -7)
                        .shadow(color: .darkShadow, radius: 7, x: 7, y: 7)
                )
            Circle()
                .trim(
                    from: 0.0,
                    to: climateViewModel.circleProgress
                )
                .stroke(climateViewModel.selectedColor, style: StrokeStyle(
                    lineWidth: 25,
                    lineCap: .round
                ))
                .shadow(color: climateViewModel.selectedColor, radius: 7)
                .frame(height: 210)
                .rotationEffect(.degrees(-110))
                .padding(40)

            Text(
                climateViewModel.isOnClimate ? "\(climateViewModel.currentCelsus)\(Constants.celsusString)" : Constants
                    .emptyString
            )
            .font(.system(size: 30, weight: .bold, design: .default))
        }
        .padding(.top, 10)
    }

    private var ellipseGradient: LinearGradient {
        LinearGradient(
            colors: [.black, .topGradient.opacity(0.3)],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private var gradient: LinearGradient {
        LinearGradient(
            colors: [.black.opacity(0.5), .lightShadow],
            startPoint: .top,
            endPoint: .init(x: 0.5, y: 0.7)
        )
    }

    private var circleGradient: LinearGradient {
        LinearGradient(
            colors: [.darkShadow, .lightShadow],
            startPoint: .topLeading,
            endPoint: .init(x: 0.5, y: 0.5)
        )
    }

    private var circleReverseGradient: LinearGradient {
        LinearGradient(
            colors: [.lightShadow, .black.opacity(0.2)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var alertView: some View {
        VStack(spacing: 20) {
            alertTextView
            if let url = URL(string: Constants.alertLinkString) {
                Link(Constants.alertTitle, destination: url)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.blue)
                    .padding(.top)
            }
            alertButtonView
        }
        .padding(35)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(Constants.lightShadowString))
        )
        .padding(.top, 100)
        .shadow(radius: 15)
        .transition(
            .move(edge: .trailing)
                .combined(with: .scale(scale: 0.1, anchor: .topTrailing))
        )
    }

    private var alertTextView: some View {
        Text(Constants.alertTitle)
            .foregroundColor(.white)
    }

    private var alertButtonView: some View {
        Button(Constants.alertButtonString) {
            withAnimation {
                climateViewModel.isAlertShown.toggle()
            }
        }
        .foregroundColor(.red)
    }

    // MARK: - Private methods

    private func makeButtonView(imageName: String) -> some View {
        Button {} label: {
            Image(imageName)
                .frame(width: 20, height: 20)
                .neumorphismUnSelectedCircleStyle()
                .overlay(
                    Circle()
                        .stroke(gradient, lineWidth: 2)
                        .opacity(0)
                )
        }
    }
}

struct ClimateView_Previews: PreviewProvider {
    static var previews: some View {
        ClimateView()
            .environment(\.colorScheme, .dark)
    }
}
