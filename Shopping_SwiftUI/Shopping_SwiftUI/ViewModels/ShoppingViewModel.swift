//
//  ShoppingViewModel.swift
//  SwiftUIDemoProject
//
//  Created by Neosoft on 02/09/24.
//

import Foundation
import Combine

class ShoppingViewModel: ObservableObject {
    @Published var categories: [Category]?
    @Published var searchText: String = "" {
        didSet {
            debounceSearch()
        }
    }
    @Published var selectedCategoryIndex: Int = 0
    @Published var errorMassege: String?
    
    private var debounceTimer: Timer?
    private let debounceInterval: TimeInterval = 0.3
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        loadCategories()
    }
    
    private func loadCategories() {
        let result: Result<CategoriesResponse, BundleError> = Bundle.main.load(Identifier.itemFile, withExtension: FileExtension.json)
        
        switch result {
        case .success(let response):
            self.categories = response.categories
        case .failure(let error):
            handleLoadCategoriesError(error)
        }
    }
    
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
    private func debounceSearch() {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: debounceInterval, repeats: false) { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func filteredItems() -> [Item] {
        if categories?.count ?? 0 > selectedCategoryIndex {
            let selectedCategory = categories?[selectedCategoryIndex]
            if searchText.isEmpty {
                return selectedCategory?.items ?? []
            }
            return selectedCategory?.items.filter { $0.itemName.localizedCaseInsensitiveContains(searchText) } ?? []
        }
        return []
    }
    // MARK: - Methods
    private func calculateCharacterOccurrences() -> [Character: Int] {
        let text = filteredItems().flatMap { $0.itemName }
        let filteredText = text.filter { $0 != " " }
        
        var counts: [Character: Int] = [:]
        filteredText.forEach { counts[$0, default: 0] += 1 }
        return  counts
    }
    
    func getTopOccurrences(limit: Int = 3) -> [(Character, Int)] {
        let occurrences = calculateCharacterOccurrences()
        let data = occurrences.sorted { $0.value > $1.value }.prefix(limit).map { ($0.key, $0.value) }
        return data
    }
}

