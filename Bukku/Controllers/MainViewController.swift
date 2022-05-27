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
    let detailView = DetailView()
    
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
    
    let changeGoalButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "circle.dashed.inset.filled")
        config.baseForegroundColor = .systemBackground
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration.init(pointSize: 24)
        
        let button = UIButton(configuration: config)
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
        calendar.appearance.selectionColor = UIColor.init(rgb: 0x1B4B36)
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
        detailView.alpha = 0
        
        [ mainLabel, goalLabel, changeGoalButton, lineView, calendar, detailView ]
            .forEach { view.addSubview($0) }
        
        mainLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        goalLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(changeGoalButton.snp.leading).offset(4)
        }
        
        changeGoalButton.snp.makeConstraints { make in
            make.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(goalLabel.snp.bottom).offset(24)
            make.height.equalTo(0.5)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(16.0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(detailView.snp.top)
        }
        
        detailView.snp.makeConstraints { make in
            make.height.equalTo(220)
            make.trailing.leading.equalToSuperview().inset(8)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }
}

extension MainViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.detailView.alpha = 1
        }, completion: nil)
        detailView.label.text = date.formatted()
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.detailView.alpha = 0
        }, completion: nil)
    }
}
