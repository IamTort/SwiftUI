//  ContentView.swift
//  SUI
//  Created by angelina on 17.01.2023.
import AVFoundation
import SwiftUI

/// Экран плейера
struct ContentView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let songName = "gori"
        static let songTypeString = "mp3"
        static let shareButtonText = "Поделиться"
        static let shareButtonMessageText = "Поделиться песней?"
        static let yesText = "Да"
        static let saveButtonTitle = "Скачать"
        static let actionSheetTitle = "Скачивание"
        static let actionSheetMessageString = "сохранен в папку Загрузки"
        static let formatString = "%.2f"
        static let playButtonTitle = "Play"
        static let stopButtonTitle = "Stop"
        static let previousImageName = "backward"
        static let nextImageName = "forward"
        static let imageCornerRadius: CGFloat = 20
        static let imageWidth: CGFloat = 350
        static let imageHeight: CGFloat = 400
        static let minutesNumber: Double = 60
        static let butonWidth: CGFloat = 100
        static let butonHeight: CGFloat = 50
        static let butonCornerRadius: CGFloat = 50
    }
    
    // MARK: - Private property
    
    @ObservedObject private var viewModel = PlayerViewModel()
    @State private var progress: Float = 0
    @State private var name = Constants.songName
    @State private var isSend = false
    @State private var isSave = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isSend = true
                } label: {
                    Text(Constants.shareButtonText)
                        .padding()
                }.alert(isPresented: $isSend) {
                    Alert(title: Text(Constants.shareButtonMessageText), message: nil, primaryButton: .cancel(), secondaryButton: .default(Text(Constants.yesText)))
                }

                Button {
                    isSave = true
                } label: {
                    Text(Constants.saveButtonTitle)
                        .padding()
                }.actionSheet(isPresented: $isSave) {
                    ActionSheet(title: Text(Constants.actionSheetTitle), message: Text("\(name) \(Constants.actionSheetMessageString)"), buttons: [.cancel()])
                }
            }

            Image(viewModel.setupPhotoName())
                .resizable()
                .cornerRadius(Constants.imageCornerRadius)
                .frame(width: Constants.imageWidth, height: Constants.imageHeight)
            
            
            Slider(value: Binding(get: {
                Double(viewModel.currentDuration)
            }, set: { newValue in
                viewModel.currentDuration = Double(newValue)
                viewModel.setTime(value: Float(viewModel.currentDuration))
            }), in: 0...viewModel.maxDuration)
            
            HStack {
                Text("\(Int(viewModel.currentDuration) / 60):\(Int(viewModel.currentDuration) % 60)")
                    .padding()
                Spacer()
                Text("\(Int(viewModel.maxDuration) / 60):\(Int(viewModel.maxDuration) % 60)")
                    .padding()
            }
            
            HStack {
                Button {
                    viewModel.play()
                } label: {
                    Text(Constants.playButtonTitle)
                        .foregroundColor(.white)
                }
                .frame(width: Constants.butonWidth, height: Constants.butonHeight)
                .background(.orange)
                .cornerRadius(Constants.butonCornerRadius)
                
                Button {
                    viewModel.stop()
                } label: {
                    Text(Constants.stopButtonTitle)
                        .foregroundColor(.white)
                }
                .frame(width: Constants.butonWidth, height: Constants.butonHeight)
                .background(.orange)
                .cornerRadius(Constants.butonCornerRadius)
            }
            
            HStack {
                Button {
                    viewModel.previousSong()
                } label: {
                    Image(systemName: Constants.previousImageName)
                        .foregroundColor(.white)
                }
                .frame(width: Constants.butonWidth, height: Constants.butonHeight)
                .background(.orange)
                .cornerRadius(Constants.butonCornerRadius)
                
                Button {
                    viewModel.nextSong()
                } label: {
                    Image(systemName: Constants.nextImageName)
                        .foregroundColor(.white)
                }
                .frame(width: Constants.butonWidth, height: Constants.butonHeight)
                .background(.orange)
                .cornerRadius(Constants.butonCornerRadius)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
