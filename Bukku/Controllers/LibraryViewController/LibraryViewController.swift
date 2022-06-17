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

class LibraryViewController: TabmanViewController {
    // MARK: - Properties
    let allVC = AllViewController()
    let readingVC = ReadingViewController()
    let willVC = WillReadViewController()
    let doneVC = DoneReadViewController()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        
        return button
    }()

    private var viewControllers: [UIViewController] = []
    
    let bar = TMBar.ButtonBar()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getGray()
        
        [ allVC, readingVC, willVC, doneVC ]
            .forEach { viewControllers.append($0) }
        
        self.dataSource = self
        addBar(bar, dataSource: self, at: .top)
        bar.layout.separatorColor = .getBlack()
        bar.layout.showSeparators = true
        bar.layout.separatorWidth = 22
        bar.backgroundView.style = .clear
        bar.backgroundColor = .getBlack()
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        bar.indicator.tintColor = .getOrange()
        bar.indicator.overscrollBehavior = .compress
        bar.buttons.customize { button in
            button.tintColor = .getWhite()
            button.selectedTintColor = .getOrange()
        }
    }
}

extension LibraryViewController: PageboyViewControllerDataSource, TMBarDataSource {
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
