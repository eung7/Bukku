//
//  LibraryViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/17.
//

import UIKit
import SnapKit
import Pageboy
import Tabman

class LibraryViewController: UIViewController {
    // MARK: - Properties
    let tabmanRootVC = TabmanRootViewController()
    let viewModel = LibraryViewModel()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .getOrange()
        view.clipsToBounds = true
    
        return view
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .getDarkGreen()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var addButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.titlePadding = 10
        let button = UIButton(configuration: config)
        button.setTitle("직접 추가", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .thin)
        button.backgroundColor = .getWhite()
        button.tintColor = .getDarkGreen()
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var gearButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .getDarkGreen()
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.addTarget(self, action: #selector(didTapGearButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        searchBar.placeholder = "수 많은 책을 검색해보세요 !"
        searchBar.searchTextField.tintColor = .getDarkGreen()
        searchBar.searchTextField.textColor = .getDarkGreen()
        searchBar.tintColor = .getDarkGreen()
        searchBar.searchTextField.leftView?.tintColor = .getDarkGreen()
        searchBar.barTintColor = .getDarkGreen()
        searchBar.searchTextField.backgroundColor = .getWhite()
        
        return searchBar
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        pushNavigationBinding()
    }
    
    // MARK: - Selectors
    @objc private func didTapAddButton() {
        let addBookVC = AddBookViewController()
        let navVC = UINavigationController(rootViewController: addBookVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc private func didTapSearchButton() {
        let searchLibraryVC = SearchLibraryViewController()
        let navVC = UINavigationController(rootViewController: searchLibraryVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc private func didTapGearButton() {
        let settingVC = SettingViewController()
        let navVC = UINavigationController(rootViewController: settingVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getWhite()
        view.addSubview(searchBar)
        tabBarController?.delegate = self
        
        let buttonStack = UIStackView(arrangedSubviews: [ gearButton, searchButton ])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        
        navigationItem.title = "내 서재"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonStack)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addButton)
        
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tabmanRootVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(tabmanRootVC)
        self.view.addSubview(tabmanRootVC.view)
        
        tabmanRootVC.view.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func pushNavigationBinding() {
        tabmanRootVC.allVC.pushCompletion = { [weak self] book in
            let libraryDetailVC = LibraryDetailViewController(book)
            let navVC = UINavigationController(rootViewController: libraryDetailVC)
            navVC.modalPresentationStyle = .fullScreen
            self?.present(navVC, animated: true)
        }
        
        tabmanRootVC.readingVC.pushCompletion = { [unowned self] book in
            let libraryDetailVC = LibraryDetailViewController(book)
            let navVC = UINavigationController(rootViewController: libraryDetailVC)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true)
        }
        
        tabmanRootVC.willVC.pushCompletion = { [unowned self] book in
            let libraryDetailVC = LibraryDetailViewController(book)
            let navVC = UINavigationController(rootViewController: libraryDetailVC)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true)
        }
        
        tabmanRootVC.doneVC.pushCompletion = { [unowned self] book in
            let libraryDetailVC = LibraryDetailViewController(book)
            let navVC = UINavigationController(rootViewController: libraryDetailVC)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true)
        }
    }
}

extension LibraryViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 0 {
            tabmanRootVC.allVC.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            tabmanRootVC.readingVC.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            tabmanRootVC.willVC.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            tabmanRootVC.doneVC.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            viewWillAppear(true)
        }
    }
}

extension LibraryViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let searchVC = SearchViewController()
        let searchNavVC = UINavigationController(rootViewController: searchVC)
        searchNavVC.modalPresentationStyle = .fullScreen
        present(searchNavVC, animated: true)
    }
}
