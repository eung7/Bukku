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
        bar.layout.separatorColor = .getDarkGreen()
        bar.layout.contentMode = .fit
        bar.backgroundView.style = .clear
        bar.backgroundColor = .getDarkGreen()
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        bar.indicator.tintColor = .getWhite()
        bar.indicator.overscrollBehavior = .compress
        bar.buttons.customize { button in
            button.tintColor = .getWhite()
            button.selectedTintColor = .getWhite()
            button.font = .systemFont(ofSize: 18.0, weight: .medium)
        }
        
        return bar
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .getDarkGreen()
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
