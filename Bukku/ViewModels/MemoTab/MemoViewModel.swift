//
//  MainViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/28.
//

import Foundation

class MemoViewModel {
    let manager = LibraryManager.shared
    
    var numberOfItemsInSection: Int {
        return manager.memoBooks.count
    }
}
