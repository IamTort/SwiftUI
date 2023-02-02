// TeslaTabBarView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Kacтомный таббар
struct TeslaTabBarView<Content: View>: View {
    
    // MARK: - Public property

    @Binding var selection: Int

    var body: some View {
        ZStack(alignment: .bottom) {
            content
            ZStack {
                TeslaTabBarShape()
                    .fill(.black)
                    .neumorphismUnSelectedStyle()
                HStack {
                    tabsView
                }
            }
            .frame(width: UIScreen.main.bounds.width - 10, height: 80)
            .offset(y: -10)
            .ignoresSafeArea(.all)
        }
        .onPreferenceChange(TabItemPreferenceKey.self) { value in
            self.tabs = value
        }
    }

    // MARK: - Inizializer

    init(selection: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.content = content()
        _selection = selection
    }

    // MARK: - Private property

    @Namespace private var tabBarItem

    @State private var tabs: [TabItem] = []

    private var content: Content

    private var tabsView: some View {
        HStack {
            ForEach(Array(tabs.enumerated()), id: \.offset) { index, element in
                Spacer()
                ZStack {
                    Circle()
                        .fill(.clear)
                        .background(
                            ZStack {
                                if selection == index {
                                    Circle()
                                        .fill(Color.topGradient.opacity(0.8))
                                        .matchedGeometryEffect(id: "tabBarItem", in: tabBarItem)
                                        .frame(width: 70, height: 50)
                                }
                            }
                        )
                        .blur(radius: 20)
                    Image(element.iconName)
                        .foregroundColor(selection == index ? .topGradient : .white)
                        .onTapGesture {
                            withAnimation {
                                selection = index
                            }
                        }
                }
                Spacer()
            }
        }
    }
}
