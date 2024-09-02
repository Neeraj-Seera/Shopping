//
//  Constants.swift
//  SwiftUIDemoProject
//
//  Created by Neosoft on 02/09/24.
//

import Foundation
import SwiftUI

enum ImageName {
    static let circleImage = "plus"
    static let ellipsis = "ellipsis"
    static let magnifyGlass = "magnifyingglass"
    static let photo = "photo"
    static let cancelImage = "xmark.circle.fill"
}

enum Identifier {
    static let itemFile = "Shopping"
    static let searchField = "searchField"
}

enum Strings {
    static let statistics = "Statistics"
    static let filteredItemsCount = "Total Count of Items: "
    static let serachPlaceholder = "Search"
    static let emptyString = ""
}

enum ButtonName {
    static let close = "Close"
}

enum FileExtension {
    static let json = "json"
}

enum Colors {
    static let list = Color("listColor")
    static let background = Color("background")
}

enum BundleError: Error {
    case fileNotFound
    case dataLoadingError(Error)
    case decodingError(Error)
}

enum ErrorMessage {
    static let fileNotFound = "Error: Categories file not found."
    static let LoadingError = "Error loading data: "
    static let decodingErr = "Error decoding data: "
}

