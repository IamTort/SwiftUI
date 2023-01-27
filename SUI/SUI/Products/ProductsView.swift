// ProductsView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран товаров
struct ProductsView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let glassImageName = "magnifyingglass"
        static let searchBarTitle = "Search..."
        static let filterButtonImageName = "slider.horizontal.3"
        static let totalString = "Total: $"
        static let minusString = "-"
        static let plusString = "+"
        static let oldPriceString = " $79 "
        static let dollarString = "$"
        static let offerTitle = "Offer updates"
        static let offerDescriptionString = "A right media mix can make"
        static let notificationTitle = "Notifications"
        static let notificationDescriptionString = "Create remarkable poster prints"
        static let buttonTitle = "Update Settings"
        static let alertTitle = "Settings apply"
        static let fortyNumber: CGFloat = 40
        static let seventyNumber: CGFloat = 70
    }

    // MARK: - Public Properties

    var body: some View {
        NavigationView {
            VStack {
                navigationBarView
                totalPriceTextView
                ScrollView {
                    rowsView
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Private Properties

    @StateObject private var productsViewModel = ProductsViewModel()

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
                .frame(height: 70)
            HStack {
                navigationBarLeftView
                navigationBarRightView
            }
        }
    }

    private var navigationBarLeftView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .frame(width: UIScreen.main.bounds.width - 100, height: 50)
            HStack {
                Image(systemName: Constants.glassImageName)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.lightGray)
                Text(Constants.searchBarTitle)
                    .foregroundColor(.darkPurple)
                Spacer()
            }
            .padding(.leading, 40)
        }
    }

    private var navigationBarRightView: some View {
        ZStack {
            Button {
                productsViewModel.isFiltersShown = true
            } label: {
                Image(systemName: Constants.filterButtonImageName)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
            }
            NavigationLink(isActive: $productsViewModel.isFiltersShown) {
                FiltersView()
            } label: {
                EmptyView()
            }
        }
        .padding(.trailing, 20)
    }

    private var totalPriceTextView: some View {
        Text("\(Constants.totalString)\(productsViewModel.totalPrice)")
            .font(.system(size: 30, weight: .bold, design: .default))
            .padding(.bottom, -10)
    }

    private var backProductView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.white)
            .frame(width: UIScreen.main.bounds.width - 40, height: 110)
            .shadow(color: .gray, radius: 6)
            .padding(10)
    }

    private var rowsView: some View {
        ForEach(0 ..< productsViewModel.products.count, id: \.self) { item in
            ZStack {
                backProductView
                HStack {
                    Spacer(minLength: 40)
                    productImageView(product: productsViewModel.products[item])
                    Spacer(minLength: 10)
                    VStack {
                        titleTextView(product: productsViewModel.products[item])
                        HStack {
                            minusButtonView(item: item)
                            productCountTextView(product: productsViewModel.products[item])
                            plusButtonView(item: item)
                        }
                    }
                    Spacer(minLength: 20)
                    VStack {
                        oldPriceTextView
                        newPriceTextView(product: productsViewModel.products[item])
                    }
                    .padding(.trailing, 20)
                    Spacer()
                }
            }
        }
        .padding(.top, 10)
    }

    private var minusTextView: some View {
        Text(Constants.minusString)
            .foregroundColor(.black)
            .font(.system(size: 30, weight: .bold, design: .default))
    }

    private var plusTextView: some View {
        Text(Constants.plusString)
            .foregroundColor(.black)
            .font(.system(size: 25, weight: .bold, design: .default))
    }

    private var oldPriceTextView: some View {
        Text(Constants.oldPriceString)
            .strikethrough()
            .foregroundColor(.lightGray)
            .font(.system(size: 30, weight: .medium, design: .default))
    }

    // MARK: - Private methods

    private func minusButtonView(item: Int) -> some View {
        Button {
            productsViewModel.makeMinusCount(item: item)
        } label: {
            minusTextView
        }
    }

    private func plusButtonView(item: Int) -> some View {
        Button {
            productsViewModel.makePlus(item: item)
        } label: {
            plusTextView
        }
    }

    private func productImageView(product: Product) -> some View {
        Image(product.imageName)
            .resizable()
            .foregroundColor(.orange)
            .frame(width: 80, height: 70, alignment: .leading)
    }

    private func titleTextView(product: Product) -> some View {
        Text(product.title)
            .font(.system(size: 22, weight: .bold, design: .default))
    }

    private func newPriceTextView(product: Product) -> some View {
        Text("\(Constants.dollarString)\(product.price)")
            .foregroundColor(.darkPurple)
            .font(.system(size: 40, weight: .medium, design: .default))
            .frame(width: 100)
    }

    private func productCountTextView(product: Product) -> some View {
        Text("\(product.count)")
            .font(.system(size: 22, weight: .medium, design: .default))
            .frame(width: 35, height: 35)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray)
            )
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
