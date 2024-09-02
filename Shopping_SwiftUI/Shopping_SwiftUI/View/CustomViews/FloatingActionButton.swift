//
//  FloatingActionButton.swift
//  DemoProject
//
//  Created by Neosoft on 02/09/24.
//

import SwiftUI

struct FloatingActionButton: View {
    let filteredItemsCount: Int
    let topOccurrences: [(Character, Int)]?
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showingSheet.toggle()
                }) {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                        .shadow(radius: 10)
                        .overlay {
                        Image(systemName: ImageName.circleImage)
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .frame(width: 30, height: 30)
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $showingSheet) {
            ShoppingStatisticsSheet(filteredItemsCount: filteredItemsCount, topOccurrences: topOccurrences)
                .presentationDetents([.height(185)]) // Adjusted for better fit
        }
    }
}
