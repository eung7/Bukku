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
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
                                                  width: UIScreen.main.bounds.width - 75,
                                                  height: 0))
        searchBar.placeholder = "책 이름을 알려주세요!"
        searchBar.returnKeyType = .search
        searchBar.searchTextField.leftView?.tintColor = .getBlack()
        
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
    }
}
