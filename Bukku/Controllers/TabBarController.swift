//
//  TabBarController.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/27.
//

import UIKit

class TabBarController: UITabBarController {
    let mainVC = MainViewController()
    let settingsVC = SettingsViewController()
    
    let mainTabBarItem = UITabBarItem(
        title: nil,
        image: UIImage(systemName: "books.vertical"),
        selectedImage: UIImage(systemName: "books.vertical.fill")
    )
    
    let settingsTabBarItem = UITabBarItem(
        title: nil,
        image: UIImage(systemName: "gearshape"),
        selectedImage: UIImage(systemName: "gearshape.fill")
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tabBar.unselectedItemTintColor = .getBlack()
        tabBar.tintColor = UIColor.getOrange()
        mainVC.tabBarItem = mainTabBarItem
        settingsVC.tabBarItem = settingsTabBarItem
        
        viewControllers = [ mainVC, settingsVC ]
    }
}
