//
//  MainViewController.swift
//  Minimum
//
//  Created by 김응철 on 2022/05/27.
//

import UIKit
import SnapKit
import FSCalendar

class MainViewController: UIViewController {
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 38.0, weight: .heavy)
        label.textColor = .systemBackground
        label.text = "당신의 목표는"
        
        return label
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 38.0, weight: .thin)
        label.textColor = .systemBackground
        label.text = "하루에 한 페이지!"
        
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    let goalButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        
        // MARK: Calendar Header
        calendar.headerHeight = 80.0
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY년 MM월"
        calendar.appearance.headerTitleColor = UIColor.init(rgb: 0xE0E7F1)
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 28.0, weight: .thin)
        
        // MARK: Calendar Body
        calendar.appearance.weekdayTextColor = UIColor.init(rgb: 0xAEBD77)
        calendar.appearance.titleDefaultColor = UIColor.init(rgb: 0xE0E7F1)
        calendar.appearance.todayColor = UIColor.init(rgb: 0xAEBD77)
        calendar.appearance.selectionColor = nil
        calendar.appearance.weekdayFont = .systemFont(ofSize: 20.0, weight: .thin)
        calendar.appearance.titleFont = .systemFont(ofSize: 18, weight: .thin)
        
        
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.init(rgb: 0x538F6A)
        
        [ mainLabel, goalLabel, lineView, calendar ]
            .forEach { view.addSubview($0) }
        
        mainLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        goalLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(20)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(goalLabel.snp.bottom).offset(24)
            make.height.equalTo(0.5)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(16.0)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
    }
}

extension MainViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
}
