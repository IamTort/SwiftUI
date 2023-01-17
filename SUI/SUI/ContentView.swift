//  ContentView.swift
//  SUI
//  Created by angelina on 17.01.2023.

import SwiftUI

struct ContentView: View {
    @State var isError = false
    @State var isBlueRed = false
    @State var isActionSheet = false
    @State var isActionSheetColor = false
    @State var textToUpdate = "Hello, world!"
    @State var colorText = "Hello, world!"
    
    var body: some View {
        VStack {
            
            Button {
                self.isError = true
            } label: {
                Text("Показать")
            }.alert(isPresented: $isError) {
                Alert(title: Text("Пример Alert"))
            }.padding(30)

            Button {
                self.isBlueRed = true
            } label: {
                Text("Показать")
            }.alert(isPresented: $isBlueRed) {
                Alert(title: Text("Выбери кнопку"), message: Text("Красная или синяя"), primaryButton: .destructive(Text("Красная"), action: {
                    self.textToUpdate = "Ты выбрал красную!"
                }), secondaryButton: .default(Text("Blue"), action: {
                    self.textToUpdate = "Ты выбрал синюю!"
                }))
            }.padding(30)
            
            Button {
                self.isActionSheet = true
            } label: {
                Text("Показать")
            }.actionSheet(isPresented: $isActionSheet) {
                ActionSheet(title: Text("Loading..."),
                            message: Text("Are you ready load photo?"),
                            buttons: [.cancel(), .default(Text("ok"))])
            }.padding(30)
            
            Button {
                self.isActionSheetColor = true
            } label: {
                Text("Показать")
            }.actionSheet(isPresented: $isActionSheetColor) {
                ActionSheet(title: Text("Loading..."),
                            message: Text("Change color?"),
                            buttons: [.cancel(), .default(Text("Желтый"), action: {
                    self.colorText = "Ты выбрал Желтый!"
                }), .default(Text("Красный"), action: {
                    self.colorText = "Ты выбрал Красный!"
                })])
            }.padding(30)
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(textToUpdate)
            Text(colorText)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
