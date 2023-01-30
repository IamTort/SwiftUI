// ContentView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран с машинкой
struct ContentView: View {
    @State var isCarClose = false
    @State var tagSelected = 0

    var body: some View {
        backgroundStackView {
            VStack {
                headerView
                carView
                controlPanelView
                Spacer()
                    .frame(height: 40)
                if tagSelected == 1 {
                    closeCarControlView
                }
                Spacer()
            }
        }
    }

    var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Tesla")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("187 km")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .opacity(0.4)
            }
            Spacer()
        }
        .padding(.all, 25)
    }

    var carView: some View {
        Image(isCarClose ? "teslaLocked" : "teslaUnlocked")
            .resizable()
            .frame(height: 250)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .white.opacity(0.6), radius: 15, x: 0, y: 10)
    }

    var gradient: LinearGradient {
        LinearGradient(colors: [Color("topGradient"), Color("bottomGradient")], startPoint: .bottom, endPoint: .top)
    }

    var controlPanelView: some View {
        HStack(spacing: 30) {
            ForEach(1 ..< 5) { index in
                Button {
                    withAnimation {
                        tagSelected = index
                    }
                } label: {
                    Image("\(index)")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .neumorphismUnSelectedCircleStyle()
                        .overlay(
                            Circle()
                                .stroke(gradient, lineWidth: 2)
                                .opacity(tagSelected == index ? 1 : 0)
                        )
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 50)
                .fill(Color("background"))
        )
        .neumorphismUnSelectedStyle()
    }

    var closeCarControlView: some View {
        Button {
            withAnimation {
                isCarClose.toggle()
            }
        } label: {
            HStack {
                Label {
                    Text(isCarClose ? "close" : "open")
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: isCarClose ? "lock.open.fill" : "lock.fill")
                        .renderingMode(.template)
                        .neumorphismUnSelectedCircleStyle()
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color("background"))
            )
            .neumorphismSelectedStyle()
        }
        .frame(width: 300)
    }

    func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color("background"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            content()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
