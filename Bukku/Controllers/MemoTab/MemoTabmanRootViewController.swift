//
//  MemoTabmanRootViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/25.
//

import UIKit
import Tabman
import Pageboy

class MemoTabmanViewController: TabmanViewController {
    // MARK: - Properties
    let reviewVC = MemoReviewViewController()
    let bookmarkVC = MemoBookmarkViewController()
    
    private var viewControllers: [UIViewController] = []
    
    lazy var tempView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var tabmanBar: TMBar.ButtonBar = {
        let bar = TMBar.ButtonBar()
        bar.layout.separatorColor = .getDarkGreen()
        bar.layout.contentMode = .fit
        bar.backgroundView.style = .clear
        bar.backgroundColor = .getWhite()
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        bar.indicator.tintColor = .getDarkGreen()
        bar.indicator.overscrollBehavior = .compress
        bar.buttons.customize { button in
            button.tintColor = .getDarkGreen()
            button.selectedTintColor = .getDarkGreen()
            button.font = .systemFont(ofSize: 18.0, weight: .thin)
        }
        
        return bar
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .getWhite()
        view.addSubview(tempView)
        
        [ reviewVC, bookmarkVC ]
            .forEach { viewControllers.append($0) }
        self.dataSource = self
        addBar(tabmanBar, dataSource: self, at: .top)
    }
}

extension MemoTabmanViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "서평")
        case 1:
            return TMBarItem(title: "책갈피")
        default:
            return TMBarItem(title: "")
        }
    }
}
