//
//  ShoppingTableViewCell.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//

import UIKit
class ShoppingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var listView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setupUI() {
        // Configure the cell's appearance
        listView.layer.masksToBounds = true
        listView.layer.cornerRadius = 5
        itemImageView.layer.masksToBounds = true
        itemImageView.layer.cornerRadius = 5
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        itemImageView.contentMode = .scaleAspectFill
    }
   
    func configure(with item: Item) {
        nameLabel.text = item.itemName
        descriptionLabel.text = item.itemDescription
        if !item.itemImage.isEmpty {
            itemImageView.image = UIImage(named: item.itemImage)
        } else {
            itemImageView.image = UIImage(named: ImageName.placeholder)
        }
    }
}

