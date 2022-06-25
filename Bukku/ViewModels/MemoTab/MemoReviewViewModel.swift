//
//  MemoReviewViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/25.
//

import Foundation

class MemoReviewViewModel {
    let manager = LibraryManager.shared
    
    var reviewBooks: [LibraryBook] {
        return manager.allBooks.filter { $0.review != "" }
    }
    
    var numberOfItemsInSection: Int {
        return reviewBooks.count
    }
}
