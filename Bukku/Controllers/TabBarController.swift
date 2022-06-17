//
//  TabBarController.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/27.
//

import UIKit

class TabBarController: UITabBarController {
    // MARK: - Properties
    let mainVC = MainViewController()
    let libraryVC = LibraryViewController()
    let searchVC = UINavigationController(rootViewController: SearchViewController()) 
    
    let mainTabBarItem = UITabBarItem(
        title: nil,
        image: UIImage(systemName: "house"),
        selectedImage: UIImage(systemName: "house.fill")
    )
    
    let libraryTabBarItem = UITabBarItem(
        title: nil,
        image: UIImage(systemName: "books.vertical"),
        selectedImage: UIImage(systemName: "books.vertical.fill")
    )
    
    let searchTabBarItem = UITabBarItem(
        title: nil,
        image: UIImage(systemName: "magnifyingglass"),
        selectedImage: UIImage(systemName: "magnifyingglass")
    )
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tabBar.unselectedItemTintColor = .getBlack()
        tabBar.tintColor = UIColor.getOrange()
        mainVC.tabBarItem = mainTabBarItem
        libraryVC.tabBarItem = libraryTabBarItem
        searchVC.tabBarItem = searchTabBarItem
        
        viewControllers = [ mainVC, libraryVC , searchVC ]
    }
}

