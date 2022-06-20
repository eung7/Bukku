//
//  TabmanRootViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/20.
//

import UIKit
import Tabman
import Pageboy

class TabmanRootViewController: TabmanViewController {
    // MARK: - Properties
    let allVC = AllViewController()
    let readingVC = ReadingViewController()
    let willVC = WillReadViewController()
    let doneVC = DoneReadViewController()
    
    private var viewControllers: [UIViewController] = []
    
    lazy var tempView: UIView = {
        let view = UIView()
    
        return view
    }()
    
    lazy var tabmanBar: TMBar.ButtonBar = {
        let bar = TMBar.ButtonBar()
        bar.layout.separatorColor = .getBlack()
        bar.layout.contentMode = .fit
        bar.backgroundView.style = .clear
        bar.backgroundColor = .getBlack()
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        bar.indicator.tintColor = .getOrange()
        bar.indicator.overscrollBehavior = .compress
        bar.buttons.customize { button in
            button.tintColor = .getWhite()
            button.selectedTintColor = .getOrange()
        }
        
        return bar
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
    }
    
    private func configureUI() {
        view.backgroundColor = .getGray()
        view.addSubview(tempView)
        
        [ allVC, readingVC, willVC, doneVC ]
            .forEach { viewControllers.append($0) }
        
        self.dataSource = self
        addBar(tabmanBar, dataSource: self, at: .top)
    }
}

extension TabmanRootViewController: PageboyViewControllerDataSource, TMBarDataSource {
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
            return TMBarItem(title: "전체 보기")
        case 1:
            return TMBarItem(title: "읽는 중")
        case 2:
            return TMBarItem(title: "읽을 예정")
        case 3:
            return TMBarItem(title: "읽기 완료")
        default:
            return TMBarItem(title: "")
        }
    }
}
