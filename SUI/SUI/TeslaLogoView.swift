// TeslaLogoView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран загрузки приложения
struct TeslaLogoView: View {
    // MARK: - Public property

    var body: some View {
        NavigationView {
            backgroundStackView(isLock: false) {
                VStack {
                    TeslaLogoShape()
                        .fill(teslaLogoViewModel.isTeslaLogoShown ? .white : .clear)
                        .shadow(color: .black, radius: 20)
                        .offset(x: 0, y: -100)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.linear(duration: 2)) {
                                    teslaLogoViewModel.isTeslaLogoShown.toggle()
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                teslaLogoViewModel.isStartScreenShown.toggle()
                            }
                        }
                    navigationLinkView
                    Spacer()
                }
            }
        }
    }

    // MARK: - Public property

    @StateObject private var teslaLogoViewModel = TeslaLogoViewModel()

    private var navigationLinkView: some View {
        NavigationLink(isActive: $teslaLogoViewModel.isStartScreenShown) {
            StartView()
        } label: {
            EmptyView()
        }
    }
}

struct TeslaLogoView_Previews: PreviewProvider {
    static var previews: some View {
        TeslaLogoView()
            .environment(\.colorScheme, .dark)
    }
}
