//
//  MainViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/28.
//

import Foundation


class MemoViewModel {
    let manager = LibraryManager.shared
}

extension MemoViewModel {
    func configureHeaderTitle(_ section: LibraryType) -> String {
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
