//
//  CategoryViewModel.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//

import Foundation

class ShoppingViewModel {
    // MARK: - Properties
    var categories: [Category] = []
    var errorMassege: String?
    var selectedCategory: Category? {
        didSet {
            updateFilteredItems()
        }
    }
    var searchText: String = "" {
        didSet {
            //updateFilteredItems()
            debounceUpdateFilteredItems()
        }
    }
    private(set) var filteredItems: [Item] = []
    var selectedIndex : Int = 0
    var onCategoriesUpdated: (() -> Void)?
    var onFilteredItemsUpdated: (() -> Void)?
    
    private var debounceWorkItem: DispatchWorkItem?
    private let debounceInterval: DispatchTimeInterval = .milliseconds(300)
    
    init() {
        loadCategories()
    }
    
    // MARK: - Data Loading
    func loadCategories() {
        let decoder = Decoder()
        let result: Result<CategoriesResponse, BundleError> = Bundle.main.load(Identifier.itemsList,
                                                                               withExtension: FileExtention.json,
                                                                               as: CategoriesResponse.self,
                                                                               using: decoder
        )
        
        switch result {
        case .success(let response):
            self.categories = response.categories
            self.onCategoriesUpdated?()
            if let firstCategory = categories.first {
                self.selectedCategory = firstCategory
            }
        case .failure(let error):
            handleLoadCategoriesError(error)
        }
    }
    // MARK: - Debouncing
    private func debounceUpdateFilteredItems() {
        debounceWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            self?.updateFilteredItems()
        }
        debounceWorkItem = workItem
        let deadline = DispatchTime.now() + debounceInterval
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: workItem)
    }
    
    
    // MARK: - Error Handling
    private func handleLoadCategoriesError(_ error: BundleError) {
        switch error {
        case .fileNotFound:
            errorMassege = ErrorMessage.fileNotFound
        case .dataLoadingError(let loadingError):
            errorMassege = ErrorMessage.LoadingError + loadingError.localizedDescription
        case .decodingError(let decodingError):
            errorMassege = ErrorMessage.decodingErr + decodingError.localizedDescription
        }
    }
    
    private func updateFilteredItems() {
        guard let selectedCategory = selectedCategory else {
            filteredItems.removeAll()
            onFilteredItemsUpdated?()
            return
        }
        filteredItems = searchText.isEmpty ? selectedCategory.items : selectedCategory.items.filter {
            
            $0.itemName.localizedCaseInsensitiveContains(searchText) }
        onFilteredItemsUpdated?()
    }
    // MARK: - Filtering
    private func calculateCharacterOccurrences() -> [Character: Int] {
        let text = filteredItems.flatMap { $0.itemName }
        let filteredText = text.filter { $0 != " " }
        
        var counts: [Character: Int] = [:]
        filteredText.forEach { counts[$0, default: 0] += 1 }
        return  counts
    }
    
    func getTopOccurrences(limit: Int = 3) -> [Character: Int] {
        let occurrences = calculateCharacterOccurrences()
        let sortedOccurrences = occurrences.sorted { $0.value > $1.value }
        let topOccurrences = sortedOccurrences.prefix(limit).reduce(into: [Character: Int]()) { result, pair in
            result[pair.key] = pair.value
        }
        
        return topOccurrences
    }
    
}
