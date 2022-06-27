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
    let searchVC = SearchViewController()
    
    let libraryTabBarItem = UITabBarItem(
        title: "내 서재",
        image: UIImage(systemName: "books.vertical"),
        selectedImage: UIImage(systemName: "books.vertical.fill")
    )
    
    let memoTabBarItem = UITabBarItem(
        title: "메모",
        image: UIImage(systemName: "note"),
        selectedImage: UIImage(systemName: "note")
    )
    
    let searchTabBarItem = UITabBarItem(
        title: "책 검색",
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
        tabBar.unselectedItemTintColor = .getDarkGreen()
        tabBar.tintColor = UIColor.getOrange()
        tabBar.barTintColor = .getWhite()
        
        let libraryNavVC = UINavigationController(rootViewController: libraryVC)
        let memoNavVC = UINavigationController(rootViewController: memoVC)
        let searchNavVC = UINavigationController(rootViewController: searchVC)
                            
        libraryNavVC.navigationBar.tintColor = .getDarkGreen()
        memoNavVC.navigationBar.tintColor = .getDarkGreen()
        searchNavVC.navigationBar.tintColor = .getDarkGreen()
        
        memoNavVC.tabBarItem = memoTabBarItem
        libraryNavVC.tabBarItem = libraryTabBarItem
        searchNavVC.tabBarItem = searchTabBarItem
        
        viewControllers = [ libraryNavVC, memoNavVC, searchNavVC ]
    }
}
