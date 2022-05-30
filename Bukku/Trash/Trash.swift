//
//  Trash.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/28.
//

import Foundation


//        calendar.snp.makeConstraints { make in
//            make.top.equalTo(lineView.snp.bottom).offset(16.0)
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(detailView.snp.top)
//        }
//
//        detailView.snp.makeConstraints { make in
//            make.height.equalTo(220)
//            make.trailing.leading.equalToSuperview().inset(8)
//            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
//        }


//extension MainViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
//    // MARK: 특정 날짜가 선택
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
//            self.detailView.alpha = 1
//        }, completion: nil)
//        detailView.label.text = dateFormat(date)
//    }
//
//    // MARK: 특정 날짜가 선택 해제
//    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
//            self.detailView.alpha = 0
//        }, completion: nil)
//    }
//
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        return 1
//    }
//
//    // MARK: EventDot 사이즈 조절
//    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
//        let eventScaleFactor: CGFloat = 1.8
//        cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
//    }
//}

//lazy var calendar: FSCalendar = {
//    let calendar = FSCalendar()
//    calendar.dataSource = self
//    calendar.delegate = self
//    calendar.setScope(.week, animated: true)
//
//    // MARK: Calendar Header
//    calendar.headerHeight = 80.0
//    calendar.appearance.headerMinimumDissolvedAlpha = 0.0
//    calendar.appearance.headerDateFormat = "YYYY년 MM월"
//    calendar.appearance.headerTitleColor = UIColor.init(rgb: 0xE0E7F1)
//    calendar.appearance.headerTitleFont = .systemFont(ofSize: 28.0, weight: .thin)
//
//    // MARK: Calendar Body
//    calendar.appearance.weekdayTextColor = UIColor.init(rgb: 0xAEBD77)
//    calendar.appearance.titleDefaultColor = UIColor.init(rgb: 0xE0E7F1)
//    calendar.appearance.todayColor = UIColor.init(rgb: 0xAEBD77)
//    calendar.appearance.selectionColor = UIColor.init(rgb: 0x1B4B36)
//    calendar.appearance.weekdayFont = .systemFont(ofSize: 20.0, weight: .thin)
//    calendar.appearance.titleFont = .systemFont(ofSize: 18, weight: .thin)
//
//    // MARK: Calendar eventDot
//    calendar.appearance.eventDefaultColor = UIColor.init(rgb: 0xAEBD77)
//    calendar.appearance.eventSelectionColor = UIColor.init(rgb: 0xAEBD77)
//
//    return calendar
//}()
