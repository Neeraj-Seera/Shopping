//
//  SerachBarExtension.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//

import Foundation
import UIKit

// MARK: - UISearchBarDelegate
extension ShoppingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
