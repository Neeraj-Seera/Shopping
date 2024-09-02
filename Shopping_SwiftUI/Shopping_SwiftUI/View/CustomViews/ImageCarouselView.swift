//
//  ImageCrousalView.swift
//  DemoProject
//
//  Created by Neosoft on 02/09/24.
//
import SwiftUI

struct ImageCarouselView: View {
    let categories: [Category]
    @Binding var selectedCategoryIndex: Int
  
    var body: some View {
        VStack {
            // MARK: - TabView Show images
            TabView(selection: $selectedCategoryIndex) {
                ForEach(categories.indices, id: \.self) { index in
                    Image(uiImage: (UIImage(named:  categories[index].image) ?? UIImage(systemName: ImageName.photo))!)
                        .resizable()
                        .cornerRadius(5)
                        .frame(height: 220)
                }
            } // TabView
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .background(Colors.background)
            .cornerRadius(5)
        } // VStack
        .onAppear {
            setupAppearance()
        }
    } // Body
    
    private func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .blue
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.8)
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCarouselView(
            categories: [
                Category(name: "Category 1", description: "Description 1", image: "exampleImage1", items: []),
                Category(name: "Category 2", description: "Description 2", image: "exampleImage2", items: []),
                Category(name: "Category 3", description: "Description 3", image: "exampleImage3", items: [])
            ], selectedCategoryIndex: .constant(0)
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
