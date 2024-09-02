//
//  CustomListView.swift
//  DemoProject
//
//  Created by Neosoft on 02/09/24.
//

import SwiftUI

struct CustomListRowView: View {
    let item: Item
   
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(uiImage: UIImage(named: item.itemImage) ?? UIImage())
                    .resizable()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                    .scaledToFit()
                    .padding()
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.itemName)
                        .font(.headline)
                    Text(item.itemDescription)
                        .font(.subheadline)
                }
                .padding(.leading, 10)
                Spacer()
            }
            .background(Colors.list)
            .cornerRadius(8)
        }
        .background(Colors.background)
        .frame(width: UIScreen.main.bounds.width - 30, height: 100)
    }
}

