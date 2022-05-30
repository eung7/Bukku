//
//  DateFommater.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/28.
//

import Foundation

extension MainViewController {
    func dateFormat(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
}
