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
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .getOrange()
        view.clipsToBounds = true
    
        return view
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        pushNavigationBinding()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getGray()
        view.addSubview(containerView)
        
        navigationItem.title = "내 서재함"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        
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
        tabmanRootVC.allVC.pushCompletion = { [weak self] index in
            let libraryDetailVC = LibraryDetailViewController(index)
            self?.navigationController?.pushViewController(libraryDetailVC, animated: true)
        }
    }
}
