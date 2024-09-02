//
//  ListAndSearchView.swift
//  SwiftUIDemoProject
//
//  Created by Neosoft on 02/09/24.
//

import SwiftUI

struct ListAndSearchView: View {
    var filteredItem: [Item]
    @Binding var searchText: String
    @State var error: String
    var body: some View {
        VStack{
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                Section {
                    if !error.isEmpty {
                        Text(error)
                            .font(.system(size: 14))
                            .padding(10)
                            .multilineTextAlignment(.center)
                    } else if filteredItem.isEmpty {
                        Text("No data found.")
                            .font(.system(size: 16))
                            .padding(10)
                            .multilineTextAlignment(.center)
                    } else {
                        ForEach(filteredItem, id: \.itemName) { item in
                            CustomListRowView(item: item)
                                .background(Colors.background)
                                .cornerRadius(8)
                        }
                    }
                } header: {
                    SearchView(searchText: $searchText, placeholder: Strings.serachPlaceholder)
                        .frame(height: 50)
                }
            }
        }
        
    }
}
