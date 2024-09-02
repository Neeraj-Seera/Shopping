//
//  ShoppingListView.swift
//  SwiftUIDemoProject
//
//  Created by Neosoft on 02/09/24.
//

import SwiftUI

struct ShoppingListView: View {
    @StateObject private var viewModel = ShoppingViewModel()
    let imageWidth = UIScreen.main.bounds.width - 30
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ImageCarouselView(
                        categories: viewModel.categories ?? [],
                        selectedCategoryIndex: $viewModel.selectedCategoryIndex
                    )
                    .frame(width: imageWidth, height: 220)
                    .padding([.top,.bottom], 10)
                    ListAndSearchView(
                        filteredItem: viewModel.filteredItems(),
                        searchText: $viewModel.searchText,
                        error: viewModel.errorMassege ?? Strings.emptyString
                    )
                }
                .backgroundStyle(Colors.background)
                .onChange(of: viewModel.selectedCategoryIndex) { _ in
                    viewModel.searchText = Strings.emptyString
                }
                .navigationTitle(viewModel.categories?[viewModel.selectedCategoryIndex].name ?? Strings.emptyString)
                .navigationBarTitleDisplayMode(.inline)
                .ignoresSafeArea(.all)
            }
            .onTapGesture{
                dismissKeyboard()
            }
        }
        .overlay {
            FloatingActionButton(filteredItemsCount: viewModel.filteredItems().count, topOccurrences: viewModel.getTopOccurrences())
        }
    }
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
