// ActionSheetView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// friy ibn
struct ActionSheetView: View {
    // MARK: - Public properties

    @EnvironmentObject private var climateViewModel: ClimateViewModel

    @GestureState private var gestureOffset = CGSize.zero

    @State private var currentMenuOffsetY: CGFloat = 0.0
    @State private var lastMenuOffsetY: CGFloat = 0.0

    var body: some View {
        VStack {
            Capsule()
                .fill(.black)
                .frame(width: 80, height: 3)
                .padding(.top)
            HStack(spacing: 60) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("A/C is ON")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.white)

                    Text("Tap to turn off or swipe up for a fast setup")
                        .lineLimit(2)
                        .frame(width: 200, alignment: .leading)
                        .foregroundColor(.gray)
                }
                .padding(.leading)
                onButtonView
            }
            .padding(.bottom, 20)
            HStack(spacing: 30) {
                ColorPicker("", selection: $climateViewModel.selectedColor)
                Spacer()
                decreaseButtonView
                Text("\(climateViewModel.currentCelsus)º")
                    .font(.system(size: 30, weight: .medium, design: .default))
                    .frame(width: 50)
                increaseButtonView
                Spacer()
                Image("carDoor")
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
            HStack {
                Text("On")
                Spacer()
                Text("Vent")
            }
            .padding(.horizontal, 40)

            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
        .background(
            .ultraThinMaterial, in:
            RoundedRectangle(cornerRadius: 40)
        )
        .ignoresSafeArea(.all, edges: .bottom)
        .offset(y: UIScreen.main.bounds.height / 2 + 75)
        .offset(y: currentMenuOffsetY)
        .gesture(dragGesture)
    }

    var dragGesture: some Gesture {
        DragGesture()
            .updating($gestureOffset) { value, state, _ in
                state = value.translation
                onChangeMenuOffset()
            }
            .onEnded { _ in
                let maxHeight = UIScreen.main.bounds.height / 6
                withAnimation {
                    if -currentMenuOffsetY > maxHeight / 2 {
                        currentMenuOffsetY = -maxHeight
                    } else {
                        currentMenuOffsetY = 0
                    }
                    lastMenuOffsetY = currentMenuOffsetY
                }
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

    var decreaseButtonView: some View {
        Button {
            guard climateViewModel.currentCelsus > climateViewModel.minCelsus else { return }
            climateViewModel.currentCelsus -= 1
            climateViewModel.getCircleGradus()
        } label: {
            Image("backChevron")
        }
    }

    var increaseButtonView: some View {
        Button {
            guard climateViewModel.currentCelsus < climateViewModel.maxCelsus else { return }
            climateViewModel.currentCelsus += 1
            climateViewModel.getCircleGradus()
        } label: {
            Image("nextChevron")
        }
    }

    var buttonGradient: LinearGradient {
        LinearGradient(
            colors: [.topBlue, .topGradient],
            startPoint: .init(x: 0, y: 0.5),
            endPoint: .init(x: 1, y: 1)
        )
    }

    func onChangeMenuOffset() {
        DispatchQueue.main.async {
            currentMenuOffsetY = gestureOffset.height + lastMenuOffsetY
        }
    }
}

struct ActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetView()
            .environment(\.colorScheme, .dark)
    }
}
