//  ContentView.swift
//  SUI
//  Created by angelina on 17.01.2023.

import SwiftUI

/// Главный экран
struct ContentView: View {
    
    // MARK: - Private Constants
    private enum Constants {
        static let helloText = "Hello, world!"
        static let showText = "Показать"
        static let exampleText = "Пример Alert"
        static let chooseButtonText = "Выбери кнопку"
        static let redOrBlueText = "Красная или синяя?"
        static let redText = "Красная"
        static let blueText = "Синяя"
        static let youChooseRedText = "Ты выбрал красную!"
        static let youChooseBlueText = "Ты выбрал синюю!"
        static let loadingString = "Loading..."
        static let loadPhotoText = "Are you ready load photo?"
        static let okText = "ok"
        static let changeColorTitle = "Изменить цвет?"
        static let yellowString = "Желтый"
        static let redString = "Красный"
        static let youChooseTitle = "Ты выбрал"
        static let thirtyNumber: CGFloat = 30
    }
    
    // MARK: - Public property
    
    var body: some View {
        VStack {
            Button {
                self.isError = true
            } label: {
                Text(Constants.showText)
            }.alert(isPresented: $isError) {
                Alert(title: Text(Constants.exampleText))
            }.padding(Constants.thirtyNumber)

            Button {
                self.isBlueRedShow = true
            } label: {
                Text(Constants.showText)
            }.alert(isPresented: $isBlueRedShow) {
                Alert(title: Text(Constants.chooseButtonText), message: Text(Constants.redOrBlueText), primaryButton: .destructive(Text(Constants.redText), action: {
                    self.textToUpdate = Constants.youChooseRedText
                }), secondaryButton: .default(Text(Constants.blueText), action: {
                    self.textToUpdate = Constants.youChooseBlueText
                }))
            }.padding(Constants.thirtyNumber)
            
            Button {
                self.isActionSheet = true
            } label: {
                Text(Constants.showText)
            }.actionSheet(isPresented: $isActionSheet) {
                ActionSheet(title: Text(Constants.loadingString),
                            message: Text(Constants.loadPhotoText),
                            buttons: [.cancel(), .default(Text(Constants.okText))])
            }.padding(Constants.thirtyNumber)
            
            Button {
                self.isActionSheetColor = true
            } label: {
                Text(Constants.showText)
            }.actionSheet(isPresented: $isActionSheetColor) {
                ActionSheet(title: Text(Constants.loadingString),
                            message: Text(Constants.changeColorTitle),
                            buttons: [.cancel(), .default(Text(Constants.yellowString), action: {
                    self.colorText = "\(Constants.youChooseTitle) \(Constants.yellowString)!"
                }), .default(Text(Constants.redString), action: {
                    self.colorText = "\(Constants.youChooseTitle) \(Constants.redString)!"
                })])
            }.padding(Constants.thirtyNumber)
            
            Text(textToUpdate)
            Text(colorText)
        }
        .padding()
    }
    
    // MARK: - Private property
    
    @State private var isError = false
    @State private var isBlueRedShow = false
    @State private var isActionSheet = false
    @State private var isActionSheetColor = false
    @State private var textToUpdate = Constants.helloText
    @State private var colorText =  Constants.helloText
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
