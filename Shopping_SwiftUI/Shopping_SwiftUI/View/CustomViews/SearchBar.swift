//
//  SearchBar.swift
//  DemoProject
//
//  Created by Neosoft on 02/09/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    var placeholder: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.gray.opacity(0.2), lineWidth: 2)
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill(Color(UIColor.systemBackground)))
                .frame(height: 50)
            HStack {
                Image(systemName: ImageName.magnifyGlass)
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                
                TextField(placeholder, text: $searchText)
                    .padding(.vertical, 8)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = Strings.emptyString
                    }) {
                        Image(systemName: ImageName.cancelImage)
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                }
            }
            .frame(height: 35)
            .padding(10)
        }
    }
}
