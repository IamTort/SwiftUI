//  HomeView.swift
//  SUI
//  Created by angelina on 23.01.2023.

import SwiftUI

/// Главный экран
struct HomeView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let flagImageName = "flag"
        static let emptyString = ""
        static let propertyString = """
                    IP Address
                    Received
                    Sent
                    """
        static let propertyValueString = """
                    127.0.0.1
                    0 MB
                    0 MB
                    """
        static let alarmString = "Service will expire after 15 days."
        static let basketString = "Basket"
        static let widthImageView: CGFloat = 200
        static let heightImageView: CGFloat = 200
        static let cornerRadiusImageView: CGFloat = 100
        static let basketTagNumber = 2
        static let lineSpacingNumber: CGFloat = 20
        static let fontSizeNumber: CGFloat = 17
        static let paddingNumber: CGFloat = 40
        static let kerningNumber: CGFloat = 1
    }
    
    // MARK: - Public Properties
    
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack {
            Spacer()
            flagImageView
            Spacer()
            VStack {
                Toggle(Constants.emptyString, isOn: $viewModel.isOn)
                    .toggleStyle(CustomToggle())
            }
            Spacer()
            HStack {
                Spacer()
                leftTextView
                Spacer()
                rightTextView
                Spacer()
            }
            Spacer()
            alarmTextView
        }
    }
    
    // MARK: - Private property
    
    @StateObject private var viewModel = HomeViewModel()
    
    private var alarmTextView: some View {
        Text(Constants.alarmString)
            .font(.system(size: Constants.fontSizeNumber, weight: .light, design: .default))
            .kerning(Constants.kerningNumber)
            .padding(Constants.paddingNumber)
            .padding(.horizontal)
            .background()
    }
    
    private var flagImageView: some View {
        Image(Constants.flagImageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundColor(.red)
            .frame(width: Constants.widthImageView, height: Constants.heightImageView, alignment: .center)
            .cornerRadius(Constants.cornerRadiusImageView)
    }
    
    private var leftTextView: some View {
        Text(Constants.propertyString).lineSpacing(Constants.lineSpacingNumber)
            .font(.system(size: Constants.fontSizeNumber, weight: .light, design: .default))
            .frame(alignment: .leading)
    }
    
    private var rightTextView: some View {
        Text(Constants.propertyValueString).lineSpacing(Constants.lineSpacingNumber)
            .multilineTextAlignment(.trailing)
            .font(.system(size: Constants.fontSizeNumber, weight: .bold, design: .default))
    }
}
