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
        
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("직접 추가", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .heavy)
        button.tintColor = .getDarkGreen()
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        pushNavigationBinding()
    }
    
    // MARK: - Selectors
    @objc func didTapAddButton() {
        
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getWhite()
        view.addSubview(containerView)
        
        navigationItem.title = "내 서재"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
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
