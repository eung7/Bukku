//
//  SearchViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/31.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    let viewModel = SearchViewModel()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
                                                  width: UIScreen.main.bounds.width - 75,
                                                  height: 0))
        searchBar.placeholder = "책 이름을 알려주세요!"
        searchBar.returnKeyType = .search
        searchBar.searchTextField.leftView?.tintColor = .getBlack()
        searchBar.delegate = self
        
        return searchBar
    }()
    
    lazy var leftArrowButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .done,
            target: self,
            action: #selector(didTapLeftArrowButton)
        )
        button.tintColor = .getBlack()
        
        return button
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func didTapLeftArrowButton() {
        self.dismiss(animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .getGray()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationItem.leftBarButtonItem = leftArrowButton
        
//            .forEach { view.addSubview($0) }
    }
}

// MARK: - SearchBar Methods
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SearchService.fetchBooks(searchText) { [weak self] books in
            self?.viewModel.books = books
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
}
