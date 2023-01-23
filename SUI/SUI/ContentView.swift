//  ContentView.swift
//  SUI
//  Created by angelina on 17.01.2023.

import SwiftUI

/// Экран выбора машины
struct ContentView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let socialString = "Соцсеть"
        static let activityImageName = "roadmap"
        static let frontWindowTitle = "Тонированная лобовуха"
        static let spolerTitle = "Спойлер"
        static let priceTitle = "Цена"
        static let shareButtonName = "Поделиться"
        static let cellButtonName = "Позвонить"
        static let chooseButtonName = "Выбрать"
        static let goodChooseString = "Прекрасный выбор"
        static let amazingCarString = "отличная машина"
        static let alertMessageString = "Мы вам перезвоним"
        static let alertButtonString = "Хорошо"
        static let zeroString = "0"
        static let dreamString = "Ваша машина мечты!"
        static let modelString = "Модель:"
        static let windowString = "Тонированная лобовуха:"
        static let spoilerString = "Спойлер:"
        static let pledgeString = "Залог:"
        static let rublesString = "рубасов"
        static let imageWidth:CGFloat = 300
        static let imageHeight:CGFloat = 240
        static let cornerRadius:CGFloat = 10
        static let offsetXNumber = -500
        static let textSizeNumber: CGFloat = 15
        static let zeroInt = 0
        static let zeroNumber = 0
        static let zeroFloat: Float = 0
        static let zeroDouble: Double = 0
    }
    
    // MARK: - Public Properties

    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section {
                        VStack {
                            carImageView
                                .animation(.spring())
                            carPickerView
                            HStack {
                                Toggle(Constants.frontWindowTitle, isOn: $isOnEngine)
                            }.padding()
                            HStack {
                                spoilerPickerView
                            }
                            VStack{
                                Text(Constants.priceTitle).padding()
                                HStack {
                                    Text(Constants.zeroString)
                                    priceSliderView
                                    Text("\(viewModel.carCost[viewModel.segmentIndex])")
                                }
                                Text("\(Int(firstPrice))")
                            }
                        }
                    }
                    .navigationTitle("\(viewModel.cars[viewModel.segmentIndex])")
                }
            }
            HStack {
                callButtonView
                Spacer()
                chooseButtonView
                Spacer()
                activityButtonView
            }
        }
    }
    
    // MARK: - Private Properties
    @StateObject private var viewModel = CarsViewModel()
    
    private let customActivity = CustomActivityView(title: Constants.socialString, imageName: Constants.activityImageName) {
    }
    @State private var pickerIndex: Float = Constants.zeroFloat
    @State private var firstPrice: Double = Constants.zeroDouble
    @State private var isOnEngine = false
    @State private var isCall = false
    @State private var isMyChoose = false
    @State private var isEditingSlider = false
    @State private var isSharePresented = false
    
    private var carImageView: some View {
        Image(viewModel.cars[viewModel.segmentIndex])
            .resizable()
            .frame(width: Constants.imageWidth, height: Constants.imageHeight)
            .offset(x: CGFloat(viewModel.offsetX))
            .cornerRadius(Constants.cornerRadius)
    }
    
    private var carPickerView: some View {
        Picker(selection: Binding(get: {
            viewModel.segmentIndex
        }, set: { newValue in
            viewModel.segmentIndex = newValue
            viewModel.offsetX = Constants.offsetXNumber
            viewModel.moveBack()
        }), label: Text("")) {
            ForEach(Constants.zeroNumber ..< viewModel.cars.count) {
                Text(viewModel.cars[$0]).tag($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    private var spoilerPickerView: some View {
        Picker(selection: $viewModel.vEngineIndex) {
            ForEach(Constants.zeroNumber ..< viewModel.typeOfSpoiler.count) {
                Text(viewModel.typeOfSpoiler[$0])
            }
        } label: {
            Text(Constants.spolerTitle)
        }
        .padding()
    }
    
    private var priceSliderView: some View {
        Slider(value: Binding(get: {
            firstPrice
        }, set: { newValue in
            firstPrice = newValue
        }), in: 0...Double(viewModel.carCost[viewModel.segmentIndex]))
    }
    
    private var callButtonView: some View {
        Button {
            isCall = true
        } label: {
            Text(Constants.cellButtonName).font(.system(size: Constants.textSizeNumber))
                .padding()
        }.alert(isPresented: $isCall) {
            Alert(title: Text(Constants.alertMessageString), message: nil, primaryButton: .cancel(), secondaryButton: .default(Text(Constants.alertButtonString)))
        }
    }
    
    private var chooseButtonView: some View {
        Button {
            isMyChoose = true
        } label: {
            Text(Constants.chooseButtonName).font(.system(size: Constants.textSizeNumber))
                .padding()
        }.actionSheet(isPresented: $isMyChoose) {
            ActionSheet(title: Text(Constants.goodChooseString), message: Text("\(viewModel.cars[viewModel.segmentIndex]) \(Constants.amazingCarString)"), buttons: [.cancel()])
        }
    }
    
    private var activityButtonView: some View {
        Button {
            self.isSharePresented = true
        } label: {
            Text(Constants.shareButtonName).font(.system(size: Constants.textSizeNumber))
        }.sheet(isPresented: $isSharePresented) {
            
            let text = """
                \(Constants.dreamString)
                \(Constants.modelString) \(viewModel.cars[viewModel.segmentIndex])
                \(Constants.windowString) \(isOnEngine)
                \(Constants.spoilerString) \(viewModel.typeOfSpoiler[viewModel.vEngineIndex])
                \(Constants.pledgeString) \(firstPrice) \(Constants.rublesString)
            """
            ActivityView(activityItems: [text], applicationActivities: [self.customActivity])
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
