//
//  MemoViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/27.
//

import UIKit
import SnapKit

class MemoViewController: UIViewController {
    // MARK: - Properties
    let tabmanRootVC = MemoTabmanViewController()
    let viewModel = MemoViewModel()

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .getDarkGreen()
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
    }
    
    // MARK: - Selectors
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
        view.backgroundColor = .getDarkGreen()
        navigationItem.title = "메모"
        tabBarController?.delegate = self
        
        let stack = UIStackView(arrangedSubviews: [ gearButton, searchButton ])
        stack.axis = .horizontal
        stack.spacing = 12
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stack)
        
        view.addSubview(containerView)
        
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
}

// MARK: - UITabBarControllerDelegate
extension MemoViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 1 {
            tabmanRootVC.bookmarkVC.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            tabmanRootVC.reviewVC.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
}
