//
//  ItemVC+TableViewExtension.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//

import Foundation
import UIKit

//MARK: - TableView setup
extension ShoppingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.filteredItems.isEmpty ? 1 : viewModel.filteredItems.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.carousalTableViewCell, for: indexPath) as? ShoppingCarousalTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.categories = viewModel.categories
            return cell
            
        case 1:
            if viewModel.filteredItems.isEmpty {
                let noDataCell = UITableViewCell(style: .default, reuseIdentifier: "NoDataCell")
                noDataCell.separatorInset = .zero
                noDataCell.selectionStyle = .none
                noDataCell.textLabel?.textAlignment = .center
                noDataCell.textLabel?.text = Strings.noDataFound
                return noDataCell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.itemTableViewCell, for: indexPath) as? ShoppingTableViewCell else {
                    return UITableViewCell()
                }
                let item = viewModel.filteredItems[indexPath.row]
                cell.configure(with: item)
                return cell
            }
            
        default:
            return UITableViewCell()
        }
    }
}

extension ShoppingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return TableViewCellHeight.carousalCellHeight
        case 1:
            return TableViewCellHeight.listCellHeight
        default:
            return TableViewCellHeight.constantCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return searchBar
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return CGFloat(TableViewCellHeight.sectionHeight)
        }
        return 0
    }
}
