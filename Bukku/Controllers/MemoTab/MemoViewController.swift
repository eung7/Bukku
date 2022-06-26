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
        navigationController?.pushViewController(searchLibraryVC, animated: true)
    }
    
    @objc private func didTapGearButton() {
        let settingVC = SettingViewController()
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getWhite()
        navigationItem.title = "메모"
        
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
