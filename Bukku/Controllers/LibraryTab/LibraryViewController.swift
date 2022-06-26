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
        navigationController?.pushViewController(searchLibraryVC, animated: true)
    }
    
    @objc private func didTapGearButton() {
        let settingVC = SettingViewController()
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getWhite()
        view.addSubview(containerView)
        
        let buttonStack = UIStackView(arrangedSubviews: [ gearButton, searchButton ])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        
        navigationItem.title = "내 서재"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonStack)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addButton)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tabmanRootVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(tabmanRootVC)
        self.view.addSubview(tabmanRootVC.view)
        
        tabmanRootVC.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func pushNavigationBinding() {
        tabmanRootVC.allVC.pushCompletion = { [weak self] book in
            let libraryDetailVC = LibraryDetailViewController(book)
            self?.navigationController?.pushViewController(libraryDetailVC, animated: true)
        }
        
        tabmanRootVC.readingVC.pushCompletion = { [unowned self] book in
            let libraryDetailVC = LibraryDetailViewController(book)
            self.navigationController?.pushViewController(libraryDetailVC, animated: true)
        }
        
        tabmanRootVC.willVC.pushCompletion = { [unowned self] book in
            let libraryDetailVC = LibraryDetailViewController(book)
            self.navigationController?.pushViewController(libraryDetailVC, animated: true)
        }

        tabmanRootVC.doneVC.pushCompletion = { [unowned self] book in
            let libraryDetailVC = LibraryDetailViewController(book)
            self.navigationController?.pushViewController(libraryDetailVC, animated: true)
        }
    }
}
