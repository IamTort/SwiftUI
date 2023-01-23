//  ActivityView.swift
//  SUI
//  Created by angelina on 19.01.2023.

import Foundation
import SwiftUI

/// Активити вью
struct ActivityView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController
    
    // MARK: - Public Properties
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]?
    
    // MARK: - Public Methods
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let viewController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
