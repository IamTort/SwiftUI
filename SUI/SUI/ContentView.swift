//  ContentView.swift
//  SUI
//  Created by angelina on 17.01.2023.

import SwiftUI

/// Экран выбора машины
struct ContentView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let carsNames = ["Opel", "Ford", "BMW"]
        static let typeOfSpoilersValues = ["Отсутствует", "Карбоновый", "Фанера"]
        static let carCostsValues = [1000000, 3494949, 5445857]
        static let socialString = "Соцсеть"
        static let activityImageName = "blue"
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
        static let timeNumber = 0.5
        static let zeroNumber = 0
        static let textSizeNumber: CGFloat = 15
        static let zeroInt = 0
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
                            ZStack {
                                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                                    .fill(.gray)
                                    .offset(x: CGFloat(offsetX))
                                    .padding()
                                carImage
                            }.animation(.spring())
                            carPicker
                            HStack {
                                Text(Constants.frontWindowTitle)
                                Toggle(isOn: $isOnEngine) {}
                            }.padding()
                            HStack {
                                spoilerPicker
                            }
                            VStack{
                                Text(Constants.priceTitle).padding()
                                HStack {
                                    Text(Constants.zeroString)
                                    priceSlider
                                    Text("\(self.carCost[segmentIndex])")
                                }
                                Text("\(Int(firstPrice))")
                            }
                        }
                    }.navigationTitle("\(cars[segmentIndex])")
                }
            }
            HStack {
                callButton
                Spacer()
                chooseButton
                Spacer()
                activityButton
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let cars = Constants.carsNames
    private let typeOfSpoiler = Constants.typeOfSpoilersValues
    private let customActivity = CustomActivityView(title: Constants.socialString, imageName: Constants.activityImageName) {
    }
    @State private var pickerIndex: Float = Constants.zeroFloat
    @State private var carCost = Constants.carCostsValues
    @State private var firstPrice: Double = Constants.zeroDouble
    @State private var offsetX = Constants.zeroInt
    @State private var isOnEngine = false
    @State private var isCall = false
    @State private var isMyChoose = false
    @State private var segmentIndex = Constants.zeroInt
    @State private var vEngineIndex = Constants.zeroInt
    @State private var isEditingSlider = false
    @State private var isSharePresented = false
    
    private var carImage: some View {
        Image(cars[segmentIndex])
            .resizable()
            .frame(width: Constants.imageWidth, height: Constants.imageHeight)
            .offset(x: CGFloat(offsetX))
            .cornerRadius(Constants.cornerRadius)
    }
    
    private var carPicker: some View {
        Picker(selection: Binding(get: {
            self.segmentIndex
        }, set: { newValue in
            self.segmentIndex = newValue
            self.offsetX = Constants.offsetXNumber
            self.moveBack()
        }), label: Text("")) {
            ForEach(Constants.zeroNumber ..< cars.count) {
                Text(self.cars[$0]).tag($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    private var spoilerPicker: some View {
        Picker(selection: $vEngineIndex) {
            ForEach(Constants.zeroNumber ..< typeOfSpoiler.count) {
                Text(self.typeOfSpoiler[$0])
            }
        } label: {
            Text(Constants.spolerTitle)
        }.padding()
    }
    
    private var priceSlider: some View {
        Slider(value: Binding(get: {
            firstPrice
        }, set: { newValue in
            firstPrice = newValue
        }), in: 0...Double(carCost[segmentIndex]))
    }
    
    private var callButton: some View {
        Button {
            isCall = true
        } label: {
            Text(Constants.cellButtonName).font(.system(size: Constants.textSizeNumber))
                .padding()
        }.alert(isPresented: $isCall) {
            Alert(title: Text(Constants.alertMessageString), message: nil, primaryButton: .cancel(), secondaryButton: .default(Text(Constants.alertButtonString)))
        }
    }
    
    private var chooseButton: some View {
        Button {
            isMyChoose = true
        } label: {
            Text(Constants.chooseButtonName).font(.system(size: Constants.textSizeNumber))
                .padding()
        }.actionSheet(isPresented: $isMyChoose) {
            ActionSheet(title: Text(Constants.goodChooseString), message: Text("\(cars[segmentIndex]) \(Constants.amazingCarString)"), buttons: [.cancel()])
        }
    }
    
    private var activityButton: some View {
        Button {
            self.isSharePresented = true
        } label: {
            Text(Constants.shareButtonName).font(.system(size: Constants.textSizeNumber))
        }.sheet(isPresented: $isSharePresented) {
            
            let text = """
                \(Constants.dreamString)
                \(Constants.modelString) \(cars[segmentIndex])
                \(Constants.windowString) \(isOnEngine)
                \(Constants.spoilerString) \(typeOfSpoiler[vEngineIndex])
                \(Constants.pledgeString) \(firstPrice) \(Constants.rublesString)
            """
            ActivityView(activityItems: [text], applicationActivities: [self.customActivity])
        }.padding()
    }
    
    // MARK: - Private method
    
    private func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.timeNumber) {
            self.offsetX = Constants.zeroNumber
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
