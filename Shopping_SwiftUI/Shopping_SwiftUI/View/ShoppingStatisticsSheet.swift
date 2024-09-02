//
//  ShoppingStatisticsSheet.swift
//  DemoProject
//
//  Created by Neosoft on 02/09/24.
//

import SwiftUI

struct ShoppingStatisticsSheet: View {
    let filteredItemsCount: Int
    let topOccurrences: [(Character, Int)]?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text(Strings.filteredItemsCount + "\(String(filteredItemsCount))")
                    .font(.system(size: 16))
                if let topOccurrences = topOccurrences, !topOccurrences.isEmpty {
                    ForEach(topOccurrences, id: \.0) { character, count in
                        Text("\(String(character)) = \(count)")
                            .font(.system(size: 14))
                            .padding(.top, 3)
                    }
                }
            }
            .navigationBarItems(trailing: Button(ButtonName.close) {
                dismiss()
            })
            .navigationTitle(Strings.statistics)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
