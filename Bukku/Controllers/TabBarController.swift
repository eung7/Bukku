//
//  TabBarController.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/27.
//

import UIKit

class TabBarController: UITabBarController {
    // MARK: - Properties
    let libraryVC = LibraryViewController()
    let memoVC = MemoViewController()
    let searchVC = UINavigationController(rootViewController: SearchViewController())
    
    let libraryTabBarItem = UITabBarItem(
        title: "서재",
        image: UIImage(systemName: "books.vertical"),
        selectedImage: UIImage(systemName: "books.vertical.fill")
    )
    
    let memoTabBarItem = UITabBarItem(
        title: "메모",
        image: UIImage(systemName: "note"),
        selectedImage: UIImage(systemName: "note")
    )
    
    let searchTabBarItem = UITabBarItem(
        title: "검색",
        image: UIImage(systemName: "magnifyingglass"),
        selectedImage: UIImage(systemName: "magnifyingglass")
    )
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        tabBar.unselectedItemTintColor = .getBlack()
        tabBar.tintColor = UIColor.getOrange()
        tabBar.barTintColor = .getGray()
        
        memoVC.tabBarItem = memoTabBarItem
        libraryVC.tabBarItem = libraryTabBarItem
        searchVC.tabBarItem = searchTabBarItem
        
        viewControllers = [ libraryVC, memoVC, searchVC ]
    }
}
