//
//  MainViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/28.
//

import Foundation

enum Section: Int, CaseIterable {
    case reading
    case willRead
    case doneRead
}

class MainViewModel {
    var eventsArr: [Date] = []
    
}

extension MainViewModel {
    func configureHeaderTitle(_ section: Section) -> String {
        switch section {
        case .reading:
            return "읽고 있는 책들이에요"
        case .willRead:
            return "읽은 예정인 책들이에요"
        case .doneRead:
            return "읽기 완료된 책들이에요"
        }
    }
}
