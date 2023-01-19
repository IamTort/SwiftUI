//  CustomActivityView.swift
//  SUI
//  Created by angelina on 19.01.2023.


import Foundation
import UIKit

/// Кастомное активити вью
final class CustomActivityView: UIActivity {
    
    // MARK: - Constants
    
    private enum Constants {
        static let actionString = "Action"
    }
    
    // MARK: - Private property
    
    private var customActivityType: UIActivity.ActivityType
    private var activityName: String
    private var activityImageName: String
    private var customActionWhenTapped: () -> Void
    
    // MARK: - Initializers
    
    init(title: String, imageName: String, performAction: @escaping () -> ()) {
        self.activityName = title
        self.activityImageName = imageName
        self.customActivityType = UIActivity.ActivityType("\(Constants.actionString) \(title)")
        self.customActionWhenTapped = performAction
        super.init()
    }
    
    override var activityType: UIActivity.ActivityType? {
        customActivityType
    }
    
    override var activityTitle: String? {
        activityName
    }
    
    override class var activityCategory: UIActivity.Category {
        .share
    }
    
    override var activityImage: UIImage? {
        UIImage(named: activityImageName)
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
    }
    
    override func perform() {
        customActionWhenTapped()
    }
}
