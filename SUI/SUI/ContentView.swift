//  ContentView.swift
//  SUI
//  Created by angelina on 17.01.2023.

import SwiftUI

/// Экран настроек
struct ContentView: View {
    //    MARK: - Private Constatns
    private enum Constants {
        static let onOffBlueToothPickerValue = ["Выкл.", "Вкл."]
        static let wifiPickerValues = ["my_wifi", "thisIsRouter", "122", "daire34"]
        static let onOffPickerBluetoothIndexValue = 0
        static let wifiIndexValue = 0
        static let avatarImageCornerRadius = 40
        static let avatarImageFrameWidth = 80
        static let avatarImageFrameHeight = 80
        static let avatarImageName = "ava"
        static let userName = "Angelina Pozolotina"
        static let userSettingsText = "Apple ID, iCloud, медиаконтент и покупки"
        static let offerAppleText = "Предложения Apple ID"
        static let freeOfferAppleText = "Бесплатные предложения от Apple"
        static let newVersionText = "iOS 16.2 уже доступно"
        static let memoryText = "Память iPhone заполнена"
        static let aviaText = "Авиарежим"
        static let wifiText = "Wi-Fi"
        static let bluetoothTitle = "Bluetooth"
        static let settingsTitle = "Настройки"
        static let bluetoothImageName = "bluetooth"
        static let userOfferFontSize = 11
        static let chevronImageName = "chevron.right"
        static let chevronImageFrameWidth = 7
        static let chevronImageFrameHeight = 11
        static let vpnTitle = "VPN"
        static let vpnImageName = "vpn"
        static let modemTitle = "Режим модема"
        static let modemImageName = "modem"
        static let cellTitle = "Сотовая связь"
        static let cellImageName = "sot"
        static let wifiImageName = "wifi"
        static let aviaImageName = "avia"
        static let twoString = "2"
        static let oneString = "1"
        static let imageCornerRadius = CGFloat(10)
        static let circleWidth = CGFloat(25)
        static let userSettingsLineLimitNumber = 1
        static let userSettingsFontSize = CGFloat(11)
        static let userNameFontSize = CGFloat(26)
    }
    
    @State var wifiIndex = Constants.wifiIndexValue
    @State var blueToothIndex = Constants.onOffPickerBluetoothIndexValue
    @State var isOnAvia = false
    @State var isOnVPN = false
    var wifis = Constants.wifiPickerValues
    var bluTooths = Constants.onOffBlueToothPickerValue
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Image(Constants.avatarImageName)
                            .resizable()
                            .cornerRadius(CGFloat(Constants.avatarImageCornerRadius))
                            .frame(width: CGFloat(Constants.avatarImageFrameWidth), height: CGFloat(Constants.avatarImageFrameHeight))
                            .aspectRatio(contentMode: .fill)
                        VStack {
                            Text(Constants.userName)
                                .font(.system(size: Constants.userNameFontSize)).frame(maxWidth: .infinity, alignment: .leading)
                            Text(Constants.userSettingsText)
                                .font(.system(size: Constants.userSettingsFontSize))
                                .lineLimit(Constants.userSettingsLineLimitNumber).frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer()
                        chewron()
                    }
                    HStack {
                        Text(Constants.offerAppleText)
                        Spacer()
                        ZStack {
                            Circle().frame(width: Constants.circleWidth)
                                .foregroundColor(.red)
                            Text(Constants.twoString)
                                .foregroundColor(.white)
                        }
                        chewron()
                    }
                }
                
                Section {
                    HStack {
                        Text(Constants.freeOfferAppleText)
                        Spacer()
                        ZStack {
                            Circle().frame(width: Constants.circleWidth)
                                .foregroundColor(.red)
                            Text(Constants.twoString)
                                .foregroundColor(.white)
                        }
                        chewron()
                    }
                }
                
                Section {
                    HStack {
                        Text(Constants.newVersionText)
                        Spacer()
                        ZStack {
                            Circle().frame(width: Constants.circleWidth)
                                .foregroundColor(.red)
                            Text(Constants.oneString)
                                .foregroundColor(.white)
                        }
                        chewron()
                    }
                    HStack {
                        Text(Constants.memoryText)
                        Spacer()
                        ZStack {
                            Circle().frame(width: Constants.circleWidth)
                                .foregroundColor(.red)
                            Text(Constants.oneString)
                                .foregroundColor(.white)
                        }
                        chewron()
                    }
                }
                
                Section {
                    HStack {
                        Image(Constants.aviaImageName).cornerRadius(Constants.imageCornerRadius)
                        Text(Constants.aviaText)
                        Toggle(isOn: $isOnAvia) {}
                    }
                    HStack {
                        Image(Constants.wifiImageName).cornerRadius(Constants.imageCornerRadius)
                        Picker(selection: $wifiIndex) {
                            ForEach(0..<wifis.count) {
                                Text(self.wifis[$0])
                            }
                        } label: {
                            Text(Constants.wifiText)
                        }
                    }
                    HStack {
                        Image(Constants.bluetoothImageName).cornerRadius(Constants.imageCornerRadius)
                        Picker(selection: $blueToothIndex) {
                            ForEach(0..<bluTooths.count) {
                                Text(self.bluTooths[$0])
                            }
                        } label: {
                            Text(Constants.bluetoothTitle)
                        }
                    }
                    HStack {
                        Image(Constants.cellImageName).cornerRadius(Constants.imageCornerRadius)
                        Text(Constants.cellTitle)
                        Spacer()
                        chewron()
                    }
                    HStack {
                        Image(Constants.modemImageName).cornerRadius(Constants.imageCornerRadius)
                        Text(Constants.modemTitle)
                        Spacer()
                        chewron()
                    }
                    HStack {
                        Image(Constants.vpnImageName).cornerRadius(Constants.imageCornerRadius)
                        Text(Constants.vpnTitle)
                        Toggle(isOn: $isOnVPN) {}
                    }
                }
            }.navigationTitle(Constants.settingsTitle)
        }
    }
    
    fileprivate func chewron() -> some View {
        return Image(systemName: Constants.chevronImageName)
            .resizable()
            .frame(width: CGFloat(Constants.chevronImageFrameWidth), height: CGFloat(Constants.chevronImageFrameHeight))
            .foregroundColor(.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
