//
//  ShoppingViewController.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//
import UIKit

class ShoppingViewController: UIViewController {
    
    @IBOutlet weak var shoppingTableView: UITableView!
    var viewModel = ShoppingViewModel()
    private let floatingButton = UIButton(type: .system)
    var searchBar = UISearchBar()
    private var errorLabel = UILabel() {
        didSet {
            // Configure the errorLabel here if needed
            errorLabel.textColor = .red
            errorLabel.font = UIFont.systemFont(ofSize: 14)
            errorLabel.textAlignment = .center
            errorLabel.numberOfLines = 0
            errorLabel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTitle()
    }
    //MARK: - Initial Setup
    private func initialSetup() {
        viewModel.loadCategories()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        shoppingTableView.register(UINib(nibName:Identifier.carousalTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.carousalTableViewCell)
        if #available(iOS 15.0, *) {
            shoppingTableView.sectionHeaderTopPadding = 0
        }
        if let error = viewModel.errorMassege, !error.isEmpty {
            setupErrorLabel()
            errorLabel.isHidden = false
            errorLabel.text = error
        } else {
            setupSerachBar()
            setupFloatingButton()
            configureViewModel()
            updateTitle()
        }
    }
    
    private func updateTitle() {
        self.title = viewModel.selectedCategory?.name
        self.navigationController?.navigationItem.title = title
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    //MARK: - SetUp error
    private func setupErrorLabel() {
        shoppingTableView.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: shoppingTableView.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: shoppingTableView.trailingAnchor, constant: -16),
            errorLabel.bottomAnchor.constraint(equalTo: shoppingTableView.topAnchor, constant: -8),
            errorLabel.bottomAnchor.constraint(equalTo: shoppingTableView.bottomAnchor, constant: -8),
            errorLabel.heightAnchor.constraint(equalToConstant: 20) // Adjust as needed
        ])
    }
    //MARK: - SearchBar
    private func setupSerachBar() {
        searchBar.delegate = self
        searchBar.placeholder = Strings.searchPlaceholder
        searchBar.sizeToFit()
        searchBar.text = viewModel.searchText
    }
    //MARK: - Configure VC
    private func configureViewModel() {
        viewModel.onFilteredItemsUpdated = { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.shoppingTableView.reloadData()
            }
        }
    }
    //MARK: - Setup floting button
    private func setupFloatingButton() {
        floatingButton.setImage(UIImage(systemName: ImageName.circleImage), for: .normal)
        floatingButton.imageView?.contentMode = .scaleAspectFill
        floatingButton.backgroundColor = UIColor.white
        floatingButton.tintColor = UIColor.red
        floatingButton.setTitleColor(.white, for: .normal)
        floatingButton.layer.cornerRadius = 25
        floatingButton.applyShadow(
            color: .black,
            offset: CGSize(width: 0, height: 2),
            opacity: 0.5,
            radius: 4
        )
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatingButton)
        NSLayoutConstraint.activate([
            floatingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            floatingButton.widthAnchor.constraint(equalToConstant: 50),
            floatingButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    @objc private func floatingButtonTapped() {
        let storyboard: UIStoryboard = UIStoryboard(name: Identifier.storyboard, bundle: nil)
        if let vc =  storyboard.instantiateViewController(withIdentifier: Identifier.statisticsSheetViewController) as? ShoppingStatisticsSheetViewController {
            vc.configure(totalCount: viewModel.filteredItems.count, topOccurrences: viewModel.getTopOccurrences())
            self.present(vc, animated: true)
        }
    }
}

extension ShoppingViewController: CarousalTableViewCellDelegate {
    func didChangeCategory(to category: Category) {
        viewModel.selectedCategory = category
        viewModel.searchText = Strings.empty
        searchBar.text = Strings.empty
        updateTitle()
    }
}
