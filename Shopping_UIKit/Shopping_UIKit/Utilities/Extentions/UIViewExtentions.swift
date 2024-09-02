//
//  Extentions.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//
import UIKit
import Foundation

extension UIView {
    func applyShadow(
        color: UIColor = .black,
        offset: CGSize = CGSize(width: 0, height: 2),
        opacity: Float = 0.5,
        radius: CGFloat = 4
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.masksToBounds = false 
    }
}
