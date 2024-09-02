//
//  ShoppingCollectionViewCell.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//

import UIKit

class ShoppingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var carousalImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        carousalImageView.translatesAutoresizingMaskIntoConstraints = false
        carousalImageView.layer.masksToBounds = true
        carousalImageView.layer.cornerRadius = 5
    }
    
    func configure(with category: Category ) {
        if let image = UIImage(named: category.image) {
            carousalImageView.image = image
        } else {
            carousalImageView.image = UIImage(named: ImageName.placeholder) // Placeholder image if asset is not found
        }
    }
}
