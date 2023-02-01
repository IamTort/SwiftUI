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
    }

    var body: some View {
        backgroundStackView(isLock: false) {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        backButtonView
                        Spacer()
                        Text("CLIMATE")
                            .foregroundColor(.white)
                            .font(.system(size: 26, weight: .semibold, design: .default))
                        Spacer()
                        settingsButtonView
                        Spacer()
                    }
                    .padding(.top, -10)
                    circleView
                        .padding(.top, 10)
                    DisclosureGroup("", isExpanded: $climateViewModel.revealDetails) {
                        VStack {
                            acView
                            fanView
                            heatView
                            autoView
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 40)
                    Spacer()
                }
                climateActionSheet
                if climateViewModel.isAlertShown {
                    alertView
                }
            }
        }
//        .ignoresSafeArea(edges: .top)
//        .navigationBarBackButtonHidden(true)
    }

//    @Environment(\.presentationMode) private var presentation

    @EnvironmentObject private var climateViewModel: ClimateViewModel

    @State var climateActionSheet = ActionSheetView()
    @State var acSliderOffset: CGFloat = -85.0
    @State var totalWidth: CGFloat = 115
    @State var isSliderOn = false
    var acView: some View {
        HStack(spacing: 30) {
            Text("Ac")
                .fontWeight(.semibold)
                .foregroundColor(isSliderOn ? .white : .gray)
                .frame(width: 40)
            snowButtonView
            ZStack {
                lineView
                RoundedRectangle(cornerRadius: 2)
                    .fill(climateViewModel.selectedColor)
                    .frame(width: acSliderOffset + 85, height: 8)
                    .offset(x: -55 + (acSliderOffset / 2))

                Image("slide")
                    .offset(x: acSliderOffset, y: 5)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if
                                    value.location.x <= totalWidth,
                                    value.location.x > -85
                                {
                                    isSliderOn = true
                                    let stpCnt = floorf(Float(value.location.x / climateViewModel.sliderPxPerStep()))
//                                    DispatchQueue.main.async {
                                    acSliderOffset = CGFloat(stpCnt) * climateViewModel.sliderPxPerStep()
//                                    }
                                    climateViewModel.makeMinimumValueText(sliderOffset: acSliderOffset)
                                }
                            }
                    )
            }
        }
    }

    var fanView: some View {
        HStack(spacing: 30) {
            Text("Fan")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .frame(width: 40)
            makeButtonView(imageName: "fanIcon")
            ZStack {
                lineView
                Image("slide")
                    .offset(x: -85, y: 5)
            }
        }
    }

    var heatView: some View {
        HStack(spacing: 30) {
            Text("Heat")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .frame(width: 40)
            makeButtonView(imageName: "heatIcon")
            ZStack {
                lineView
                Image("slide")
                    .offset(x: -85, y: 5)
            }
        }
    }

    var autoView: some View {
        HStack(spacing: 30) {
            Text("Auto")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .frame(width: 40)
            makeButtonView(imageName: "autoIcon")
            ZStack {
                lineView
                Image("slide")
                    .offset(x: -85, y: 5)
            }
        }
    }

    var buttonGradient: LinearGradient {
        LinearGradient(
            colors: [.topBlue, .topGradient],
            startPoint: .init(x: 0, y: 0.5),
            endPoint: .init(x: 1, y: 1)
        )
    }

    var snowButtonView: some View {
        Button {} label: {
            Image("snoIcon")
                .frame(width: 20, height: 20)
                .foregroundColor(isSliderOn ? .topGradient : .lightGray)
                .neumorphismUnSelectedCircleStyle()
                .overlay(
                    Circle()
                        .stroke(gradient, lineWidth: 2)
                        .opacity(0)
                )
        }
    }

    var onButtonView: some View {
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
                Image("power")
                    .foregroundColor(.white)
                    .frame(width: 63, height: 63)
                    .background(
                        Circle()
                            .fill(buttonGradient)
                    )
            }
        }
    }

    func makeButtonView(imageName: String) -> some View {
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

    var lineView: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(gradient)
            .frame(width: 200, height: 8)
    }

    var settingsButtonView: some View {
        Button {
            climateViewModel.isAlertShown.toggle()
        } label: {
            Image("gearshapeIcon")
                .neumorphismCircleButtonUnSelectedCircleStyle()
        }
    }

    var backButtonView: some View {
        Button {
//            self.presentation.wrappedValue.dismiss()
        } label: {
            Image("backChevron")
                .neumorphismCircleButtonUnSelectedCircleStyle()
        }
    }

    var circleView: some View {
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

            Text(climateViewModel.isOnClimate ? "\(climateViewModel.currentCelsus)º C" : "")
                .font(.system(size: 30, weight: .bold, design: .default))
        }
    }

    var ellipseGradient: LinearGradient {
        LinearGradient(
            colors: [.black, .topGradient.opacity(0.3)],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    var gradient: LinearGradient {
        LinearGradient(
            colors: [.black.opacity(0.5), .lightShadow],
            startPoint: .top,
            endPoint: .init(x: 0.5, y: 0.7)
        )
    }

    var circleGradient: LinearGradient {
        LinearGradient(
            colors: [.darkShadow, .lightShadow],
            startPoint: .topLeading,
            endPoint: .init(x: 0.5, y: 0.5)
        )
    }

    var circleReverseGradient: LinearGradient {
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
                .fill(Color("lightShadow"))
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
}

struct ClimateView_Previews: PreviewProvider {
    static var previews: some View {
        ClimateView()
            .environment(\.colorScheme, .dark)
    }
}
