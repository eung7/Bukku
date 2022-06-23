//
//  MainViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/28.
//

import Foundation

class MemoViewModel {
    var booksIncludedBookmark: [LibraryBook] {
        var booksIncludedBookmark: [LibraryBook] = []
        for i in LibraryManager.allBooks {
            if i.bookmark.isEmpty == true {
                continue
            } else {
                booksIncludedBookmark.append(i)
            }
        }
        return booksIncludedBookmark
    }
}

extension MemoViewModel {
    func numberOfSections() -> Int {
        return booksIncludedBookmark.count
    }
}
