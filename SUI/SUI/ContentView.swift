//  ContentView.swift
//  SUI
//  Created by angelina on 17.01.2023.
import AVFoundation
import SwiftUI

/// Экран плейера
struct ContentView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
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
    
    // MARK: - Public Properties
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                shareButtonView
                saveButtonView
            }
            
            Image(viewModel.setupPhotoName())
                .resizable()
                .cornerRadius(Constants.imageCornerRadius)
                .frame(width: Constants.imageWidth, height: Constants.imageHeight)
            timeSliderView
            
            HStack {
                Text(verbatim: viewModel.getTime().formatted(.dateTime.minute().second())).padding()
                Spacer()
                Text(verbatim: Date(timeIntervalSince1970: viewModel.maxDuration - viewModel.currentDuration).formatted(.dateTime.minute().second())).padding()
            }
            
            HStack {
                startButtonView
                stopButtonView
            }
            
            HStack {
                previousSongButtonView
                nextSongButtonView
            }
        }
    }
    
    // MARK: - Private property
    
    @StateObject private var viewModel = PlayerViewModel()
    
    private var shareButtonView: some View {
        Button {
            viewModel.isSend = true
        } label: {
            Text(Constants.shareButtonText)
                .padding()
        }
        .alert(isPresented: $viewModel.isSend) {
            Alert(title: Text(Constants.shareButtonMessageText), message: nil, primaryButton: .cancel(), secondaryButton: .default(Text(Constants.yesText)))
        }
    }
    
    private var saveButtonView: some View {
        Button {
            viewModel.isSave = true
        } label: {
            Text(Constants.saveButtonTitle)
                .padding()
        }
        .actionSheet(isPresented: $viewModel.isSave) {
            ActionSheet(title: Text(Constants.actionSheetTitle), message: Text("\(viewModel.name) \(Constants.actionSheetMessageString)"), buttons: [.cancel()])
        }
    }
    
    private var timeSliderView: some View {
        Slider(value: Binding(get: {
            Double(viewModel.currentDuration)
        }, set: { newValue in
            viewModel.currentDuration = Double(newValue)
            viewModel.setTime(value: Float(viewModel.currentDuration))
        }), in: 0...viewModel.maxDuration)
    }
    
    private var startButtonView: some View {
        Button {
            viewModel.play()
        } label: {
            Text(Constants.playButtonTitle)
                .foregroundColor(.white)
        }
        .frame(width: Constants.butonWidth, height: Constants.butonHeight)
        .background(.orange)
        .cornerRadius(Constants.butonCornerRadius)
    }
    
    private var stopButtonView: some View {
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
    
    private var previousSongButtonView: some View {
        Button {
            viewModel.previousSong()
        } label: {
            Image(systemName: Constants.previousImageName)
                .foregroundColor(.white)
        }
        .frame(width: Constants.butonWidth, height: Constants.butonHeight)
        .background(.orange)
        .cornerRadius(Constants.butonCornerRadius)
    }
    
    private var nextSongButtonView: some View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
