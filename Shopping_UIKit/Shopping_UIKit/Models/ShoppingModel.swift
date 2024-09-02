//
//  ShoppingModel.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//

import Foundation

// Sample Category model
struct Category: Codable,Equatable {
    let name: String
    let description: String
    let image: String
    let items: [Item]
}

// Sample Item model
struct Item: Codable ,Equatable {
    let itemName: String
    let itemDescription: String
    let itemImage: String
}

// Response model for decoding JSON
struct CategoriesResponse: Codable {
    let categories: [Category]
}
