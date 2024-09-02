//
//  ShoppingCarousalTableViewCell.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//

import UIKit

protocol CarousalTableViewCellDelegate: AnyObject {
    func didChangeCategory(to category: Category)
}

class ShoppingCarousalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carousalView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    weak var delegate: CarousalTableViewCellDelegate?
    var categories: [Category] = [] {
        didSet {
            configureView()
        }
    }
    private var currentIndex : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        carousalView.register(UINib(nibName: Identifier.imageCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Identifier.imageCollectionViewCell)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func configureView() {
        carousalView.reloadData()
        pageControl.numberOfPages = categories.count
        pageControl.currentPage = currentIndex
        pageControl.currentPageIndicatorTintColor =  .blue
        pageControl.tintColor = .white
    }
}

extension ShoppingCarousalTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.imageCollectionViewCell, for: indexPath) as? ShoppingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let category = categories[indexPath.row]
        cell.configure(with: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        pageControl.currentPage = pageIndex
        currentIndex = pageIndex
        if pageIndex < categories.count {
            let selectedCategory = categories[pageIndex]
            self.delegate?.didChangeCategory(to: selectedCategory)
        }
    }
}

