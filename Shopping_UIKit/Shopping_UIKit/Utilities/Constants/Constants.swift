//
//  Constants.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//

import Foundation

enum Identifier {
    static let carousalTableViewCell =  "CarousalTableViewCell"
    static let searchView =  "SearchView"
    static let itemTableViewCell =  "ItemTableViewCell"
    static let imageCollectionViewCell = "ImageCollectionViewCell"
    static let itemsList = "Shopping"
    static let statisticsSheetViewController =  "StatisticsSheetViewController"
    static let storyboard = "Main"
}

enum ImageName {
    static let placeholder =  "placeholder"
    static let circleImage = "plus"
}

enum FileExtention {
    static let json = "json"
}

enum Strings {
    static let countDescription = "Total Count of Items: "
    static let insufficientData = "Not enough data"
    static let empty = ""
    static let searchPlaceholder = "Search here"
    static let noDataFound = "No Data Found."
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

enum TableViewCellHeight {
    static let carousalCellHeight = 230.0
    static let listCellHeight = 100.0
    static let constantCellHeight = 100.0
    static let sectionHeight = 44.0
}
