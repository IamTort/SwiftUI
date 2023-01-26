// MainViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель главного экрана
final class MainViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let imageUrlStrings = [
            "https://i.postimg.cc/nr6RgPGW/icons8-sofa-100.png",
            "https://i.postimg.cc/htSvCfTR/bedRoom.png",
            "https://i.postimg.cc/mkLQMMCX/buffet.png",
            "https://i.postimg.cc/B6G5SR6G/icons8-coffee-table-100.png",
            "https://i.postimg.cc/MpNb4nJH/schkaf.png",
            "https://i.postimg.cc/s2W9R33c/stul.png",
            "https://i.postimg.cc/W36GhSFq/stol.png"
        ]
        static let zeroNumber = 0
    }

    // MARK: - Public Properties

    @Published var isLoginShown = false
    @Published var isChairShown = false
    @Published var urls = Constants.imageUrlStrings

    func generateUrl() -> URL? {
        URL(string: urls[Int.random(in: Constants.zeroNumber ... urls.count)])
    }
}
