//
//  MainViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/28.
//

import Foundation

class MemoViewModel {
    let manager = LibraryManager.shared
    
    var bookmarkBooks: [LibraryBook] {
        var bookmarkBooks: [LibraryBook] = []
        for i in manager.allBooks {
            if i.bookmark.isEmpty == true {
                continue
            } else {
                bookmarkBooks.append(i)
            }
        }
        return bookmarkBooks
    }
}

extension MemoViewModel {
    func numberOfSections() -> Int {
        return bookmarkBooks.count
    }
}
