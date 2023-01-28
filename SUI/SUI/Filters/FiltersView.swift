// FiltersView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран фильтров
struct FiltersView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let backImageName = "chevron.backward"
        static let rightImageName = "chevron.forward"
        static let pricingTitle = "Pricing"
        static let bedImageView = "bed"
        static let categoryTitle = "Category"
        static let moreTitle = "More"
        static let navigationTitle = "Filters"
        static let filterImageName = "filter"
        static let colorsTitle = "Colors"
        static let grayColorString = "lightGray"
        static let textSizeNumber: CGFloat = 30
    }

    // MARK: - Public property

    var body: some View {
        NavigationView {
            VStack {
                navigationBarView
                categoryTextView
                scrollView
                pricingTextView
                CustomSliderView()
                colorsTextView
                ScrollView {
                    colorsView
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Private Properties

    @Environment(\.presentationMode) private var presentation

    @StateObject private var filtersViewModel = FiltersViewModel()
    @StateObject private var productsViewModel = ProductsViewModel()

    private var pricingTextView: some View {
        HStack {
            Text(Constants.pricingTitle)
                .font(.system(size: Constants.textSizeNumber, weight: .bold, design: .default))
                .padding(.leading, 30)
            Spacer()
        }
    }

    private var productImageView: some View {
        Image(Constants.bedImageView)
            .resizable()
            .frame(width: 100, height: 70)
            .foregroundColor(.orange)
    }

    private var categoryTextView: some View {
        HStack {
            Text(Constants.categoryTitle)
                .font(.system(size: Constants.textSizeNumber, weight: .bold, design: .default))

            Spacer()
            Text(Constants.moreTitle)
                .font(.system(size: Constants.textSizeNumber, weight: .bold, design: .default))
                .foregroundColor(.lightGray)
            Image(systemName: Constants.rightImageName)
                .resizable()
                .frame(width: 14, height: 25)
                .font(.headline)
                .foregroundColor(.lightGray)
                .offset(y: 3)
        }
        .padding(20)
    }

    private var navigationBarView: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        titleTextView
                    }
                }
                .background(
                    LinearGradient(
                        colors: [.yellow, .red.opacity(0.9)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .navigationBarItems(
                    leading: navigationBarButtonView,
                    trailing: navigationBarRightView
                )
                .frame(height: 4)
        }
    }

    private var titleTextView: some View {
        Text(Constants.navigationTitle)
            .font(.system(size: Constants.textSizeNumber, weight: .bold, design: .default))
            .foregroundColor(.white)
    }

    private var scrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(
                rows: filtersViewModel.row,
                alignment: .center,
                spacing: 30,
                pinnedViews: .sectionHeaders
            ) {
                productsView
            }
            .padding(.leading, 35)
        }
    }

    private var productsView: some View {
        ForEach(productsViewModel.products) { _ in
            ZStack {
                backProductView
                productImageView
            }
        }
    }

    private var backProductView: some View {
        Rectangle()
            .fill(.white)
            .frame(width: 140, height: 100)
            .shadow(color: .gray, radius: 5)
    }

    private var navigationBarButtonView: some View {
        Button(action: {
            presentation.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Constants.backImageName)
                .resizable()
                .frame(width: 17, height: 35)
                .font(.headline)
                .foregroundColor(.white)
        })
    }

    private var navigationBarRightView: some View {
        Button(action: {}, label: {
            Image(Constants.filterImageName)
                .resizable()
                .frame(width: 30, height: 25)
                .font(.headline)
                .foregroundColor(.white)
        })
    }

    private var colorsTextView: some View {
        HStack {
            Text(Constants.colorsTitle)
                .font(.system(size: Constants.textSizeNumber, weight: .bold, design: .default))
                .padding(.leading, 30)
                .foregroundColor(filtersViewModel.color)
            Spacer()
        }
    }

    private var colorsView: some View {
        LazyVGrid(
            columns: filtersViewModel.column,
            alignment: .center,
            spacing: 30,
            pinnedViews: .sectionHeaders
        ) {
            ForEach(0 ..< filtersViewModel.colors.count, id: \.self) { item in
                colorView(item: item)
            }
        }
    }

    // MARK: - Private methods

    private func colorView(item: Int) -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(filtersViewModel.colors[item])
            .frame(width: 50, height: 50)
            .overlay(
                Circle()
                    .stroke(Color(Constants.grayColorString), lineWidth: 3)
            )
            .onTapGesture {
                filtersViewModel.color = filtersViewModel.colors[item]
            }
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView()
    }
}
