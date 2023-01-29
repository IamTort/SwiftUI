// CardView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран добавления карты
struct CardView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let backImageName = "chevron.backward"
        static let navigationTitle = "Account/Payment"
        static let namePlaceholderString = "Cardholder name"
        static let cardPlaceholderString = "0000 0000 0000 0000"
        static let nameCardString = "Your Name"
        static let addCardTitle = "Add new card"
        static let cardNumberTitle = "Card number"
        static let emptyString = ""
        static let cvcTitle = "CVC"
        static let cardString = "CARD"
        static let cardholderString = "cardholder"
        static let validString = "valid"
        static let alertTitle = "Need more CVC numbers"
        static let alertImageName = "questionmark.circle.fill"
        static let alertButtonString = "Cancel"
        static let pickerImageName = "chevron.right"
        static let addButtonTitle = "Add now"
        static let slashString = "/"
        static let sixtyNumber: CGFloat = 60
    }

    var body: some View {
        ZStack {
            VStack {
                navigationBarView
                ZStack {
                    frontCardView
                    backCardView
                }
                .padding(.top, 40)
                ScrollViewReader { scrollViewProxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        addTextView
                        nameTextFieldView
                        lineView
                        cardTextView
                        cardNumberTextFieldView
                        lineView
                        makeDataPickerView(scrollViewProxy: scrollViewProxy)
                        cvcTextView
                        cvcNumberTextFieldView
                        makeShortLineView(width: 50)
                    }
                    .frame(width: 300, height: 290)
                }
                addButtonView
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            if cardViewModel.isAlertCodeShown {
                alertView
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }

    // MARK: - Private Properties

    @Environment(\.presentationMode) private var presentation

    @StateObject private var cardViewModel = CardViewModel()

    @FocusState private var cardIsFocused: Bool
    @FocusState private var nameIsFocused: Bool
    @FocusState private var cvcIsFocused: Bool

    private var navigationBarView: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .navigationBarTitleDisplayMode(.inline)
                .background(
                    LinearGradient(
                        colors: [.yellow, .red.opacity(0.9)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .navigationBarItems(
                    leading:
                    navigationBarButtonView
                )
                .frame(height: 4)
            Text(Constants.navigationTitle)
                .font(.system(size: 30, weight: .bold, design: .default))
                .foregroundColor(.white)
                .offset(y: -20)
        }
    }

    private var navigationBarButtonView: some View {
        Button(action: {
            self.presentation.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Constants.backImageName)
                .resizable()
                .frame(width: 17, height: 35)
                .font(.headline)
                .foregroundColor(.white)
        })
    }

    private var addTextView: some View {
        Text(Constants.addCardTitle)
            .font(.system(size: 27, weight: .bold, design: .default))
            .frame(maxWidth: 330, alignment: .leading)
    }

    private var cardTextView: some View {
        Text(Constants.cardNumberTitle)
            .frame(maxWidth: 330, alignment: .leading)
    }

    private var cvcTextView: some View {
        Text(Constants.cvcTitle)
            .frame(maxWidth: 330, alignment: .leading)
            .offset(x: 147, y: -220)
    }

    private var frontCardView: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [.yellow, .red.opacity(0.9)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: UIScreen.main.bounds.width - Constants.sixtyNumber, height: 200)
                .shadow(radius: 5)
            cardItemView
        }
        .padding()
        .rotation3DEffect(
            Angle(degrees: cardViewModel.getFrontDegree()),
            axis: (x: 0, y: 1, z: 0)
        )
        .onTapGesture {
            cardViewModel.isFrontCardShown.toggle()
            cardViewModel.flipCard()
        }
    }

    private var backCardView: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [.yellow, .red.opacity(0.9)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: UIScreen.main.bounds.width - Constants.sixtyNumber, height: 200)
                .shadow(radius: 5)
            backCardItemView
                .frame(width: 100, height: 50)
                .padding(.top, 80)
                .padding(.leading, 180)
        }
        .padding()
        .rotation3DEffect(
            Angle(degrees: cardViewModel.getBackDegree()),
            axis: (x: 0, y: 1, z: 0)
        )
        .onTapGesture {
            cardViewModel.isFrontCardShown.toggle()
            cardViewModel.flipCard()
        }
    }

    private var backCardItemView: some View {
        VStack {
            Spacer()
            Text(Constants.cvcTitle)
                .font(.headline)
            Text(cardViewModel.cvcNumberText)
                .foregroundColor(.white)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
        }
    }

    private var cardItemView: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                ZStack {
                    cardLogoView
                    cardLogoTextView
                }
                .padding(.trailing, 10)
            }
            VStack(alignment: .leading) {
                cardNumberTextView
                cardNumberTitleTextView
                HStack {
                    nameTextView
                    Spacer()
                    validTextView
                    Spacer()
                }
            }
            .padding(.leading, 40)
            Spacer()
        }
        .frame(height: 170)
        .padding()
    }

    private var cardNumberTextView: some View {
        Text(cardViewModel.isCardPlaceholderOn ? cardViewModel.cardNumberText : Constants.cardPlaceholderString)
            .foregroundColor(.white)
            .font(.title2)
            .fontWeight(.bold)
    }

    private var cardNumberTitleTextView: some View {
        Text(Constants.cardNumberTitle)
            .font(.title3)
            .padding(.bottom, 15)
    }

    private var nameTextView: some View {
        VStack(alignment: .leading) {
            Text(cardViewModel.isNamePlaceholderOn ? cardViewModel.nameText : Constants.nameCardString)
                .foregroundColor(.white)
                .font(.title2)
                .fontWeight(.bold)
            Text(Constants.cardholderString)
                .font(.title3)
        }
    }

    private var validTextView: some View {
        VStack(alignment: .leading) {
            Text("\(cardViewModel.textMonth) \(Constants.slashString) \(cardViewModel.textYear)")
                .foregroundColor(.white)
                .font(.title2)
                .fontWeight(.bold)
            Text(Constants.validString)
                .font(.title3)
        }
    }

    private var cardLogoTextView: some View {
        Text(Constants.cardString)
            .font(.system(size: 22, weight: .bold, design: .default))
            .foregroundColor(.darkPurple)
            .padding(.trailing, 10)
    }

    private var cardLogoView: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(.white)
            .frame(width: 70, height: 40)
            .padding(.trailing, 10)
    }

    private var nameTextFieldView: some View {
        TextField(Constants.namePlaceholderString, text: $cardViewModel.nameText)
            .foregroundColor(.black)
            .focused($nameIsFocused)
            .keyboardType(.default)
            .onChange(of: cardViewModel.nameText) { _ in
                cardViewModel.isNamePlaceholderOn = true
            }
            .frame(width: 330)
    }

    private var alertView: some View {
        VStack(spacing: 20) {
            alertTextView
            alertImageView
            alertButtonView
        }
        .padding(35)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.gray)
        )
        .padding(.top, 100)
        .shadow(radius: 15)
        .transition(
            .move(edge: .trailing)
                .combined(with: .scale(scale: 0.1, anchor: .topTrailing))
        )
    }

    private var alertImageView: some View {
        Image(systemName: Constants.alertImageName)
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundColor(.white)
    }

    private var alertTextView: some View {
        Text(Constants.alertTitle)
            .foregroundColor(.white)
    }

    private var alertButtonView: some View {
        Button(Constants.alertButtonString) {
            withAnimation {
                cardViewModel.isAlertCodeShown.toggle()
            }
        }
        .foregroundColor(.red)
    }

    private var cardNumberTextFieldView: some View {
        TextField(Constants.cardPlaceholderString, text: $cardViewModel.cardNumberText)
            .foregroundColor(.black)
            .focused($cardIsFocused)
            .keyboardType(.numberPad)
            .font(.system(size: 20, weight: .bold, design: .default))
            .onChange(of: cardViewModel.cardNumberText) { newValue in
                cardViewModel.isCardPlaceholderOn = true
                cardViewModel.checkNewValue(newValue: newValue)
            }
            .frame(width: 330)
    }

    private var cvcNumberTextFieldView: some View {
        SecureField(Constants.cvcTitle, text: $cardViewModel.cvcNumberText)
            .foregroundColor(.black)
            .focused($cvcIsFocused)
            .keyboardType(.numberPad)
            .font(.system(size: 20, weight: .bold, design: .default))
            .onChange(of: cardViewModel.cvcNumberText) { text in
                cardViewModel.checkCVCNumberValue(text: text)
            }
            .onTapGesture {
                cardViewModel.isFrontCardShown = false
                cardViewModel.flipCard()
            }
            .frame(maxWidth: 100, alignment: .leading)
            .offset(x: 28, y: -220)
    }

    private var addButtonView: some View {
        Button(Constants.addButtonTitle) {
            if cardViewModel.cvcNumberText.count < 3 {
                cardViewModel.isAlertCodeShown = true
            }
        }
        .frame(width: 320, height: 80)
        .background(.red)
        .foregroundColor(.white)
        .font(.system(size: 28, weight: .bold, design: .default))
        .cornerRadius(40)
        .padding(.top, 50)
    }

    private var lineView: some View {
        Rectangle()
            .foregroundColor(.lightGray)
            .frame(width: UIScreen.main.bounds.width - 60, height: 3)
    }

    private var shortLineView: some View {
        Rectangle()
            .foregroundColor(.lightGray)
            .frame(width: 100, height: 3)
    }

    // MARK: - Private methods

    private func makeMonthPickerView(scrollViewProxy: ScrollViewProxy) -> some View {
        Picker(
            Constants.emptyString,
            selection: $cardViewModel.expireMonth,
            content: {
                ForEach(cardViewModel.months, id: \.self) { month in
                    Text("\(month)")
                }
            }
        )
        .pickerStyle(.wheel)
        .opacity(cardViewModel.isMonthPickerShown ? 1 : 0)
        .onChange(of: cardViewModel.expireMonth) { newValue in
            withAnimation {
                cardViewModel.textMonth = newValue
                cardViewModel.expireMonthOnCardName = newValue
                cardViewModel.isMonthPickerShown = false
                scrollViewProxy.scrollTo(0, anchor: .center)
            }
        }
    }

    private func makeYearPickerView(scrollViewProxy: ScrollViewProxy) -> some View {
        Picker(
            Constants.emptyString,
            selection: $cardViewModel.expireYear,
            content: {
                ForEach(cardViewModel.years, id: \.self) { month in
                    Text("\(month)")
                }
            }
        )
        .pickerStyle(.wheel)
        .opacity(cardViewModel.isYearPickerShown ? 1 : 0)
        .onChange(of: cardViewModel.expireYear) { newValue in
            withAnimation {
                cardViewModel.textYear = newValue
                cardViewModel.expireYearOnCardName = newValue
                cardViewModel.isYearPickerShown = false
                scrollViewProxy.scrollTo(0, anchor: .center)
            }
        }
        .id(1)
    }

    private func makeShortLineView(width: CGFloat) -> some View {
        Rectangle()
            .foregroundColor(.lightGray)
            .frame(width: width, height: 3)
            .offset(y: -220)
    }

    private func makeMonthPickerButtonView(scrollViewProxy: ScrollViewProxy) -> some View {
        Button {
            withAnimation {
                cardViewModel.isMonthPickerShown.toggle()
                scrollViewProxy.scrollTo(
                    cardViewModel.isMonthPickerShown ? 1 : 0, anchor: .center
                )
            }
        } label: {
            Image(systemName: Constants.pickerImageName)
                .foregroundColor(.lightGray)
        }
        .frame(
            width: 10,
            height: 10
        )
        .rotationEffect(Angle.degrees(cardViewModel.isMonthPickerShown ? 90 : 0))
    }

    private func makeYearPickerButtonView(scrollViewProxy: ScrollViewProxy) -> some View {
        Button {
            withAnimation {
                cardViewModel.isYearPickerShown.toggle()
                scrollViewProxy.scrollTo(
                    cardViewModel.isYearPickerShown ? 1 : 0, anchor: .center
                )
            }
        } label: {
            Image(systemName: Constants.pickerImageName)
                .foregroundColor(.lightGray)
        }
        .frame(
            width: 10,
            height: 10
        )
        .rotationEffect(Angle.degrees(cardViewModel.isYearPickerShown ? 90 : 0))
    }

    private func makeDataPickerView(scrollViewProxy: ScrollViewProxy) -> some View {
        VStack {
            HStack(spacing: 140) {
                VStack {
                    HStack {
                        Text(cardViewModel.textMonth)
                        makeMonthPickerButtonView(scrollViewProxy: scrollViewProxy)
                    }
                    shortLineView
                }
                VStack {
                    HStack {
                        Text(cardViewModel.textYear)
                        makeYearPickerButtonView(scrollViewProxy: scrollViewProxy)
                    }
                    shortLineView
                }
            }
            .font(.title2)
            HStack {
                makeMonthPickerView(scrollViewProxy: scrollViewProxy)
                makeYearPickerView(scrollViewProxy: scrollViewProxy)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
