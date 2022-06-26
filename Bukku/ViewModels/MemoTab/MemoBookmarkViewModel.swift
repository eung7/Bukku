//
//  MemoBookmarkViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/25.
//

import Foundation

class MemoBookmarkViewModel {
    let manager = LibraryManager.shared
    
    var bookmarkBooks: [LibraryBook] {
        return manager.allBooks.filter { !$0.bookmark.isEmpty }
    }
    
    var numberOfRowsInSection: Int {
        return bookmarkBooks.count
    }
    
    func pinBookmark(_ index: Int) -> Bookmark {
        if let bookmark = bookmarkBooks[index].bookmark.first(where: { $0.pin == true }) {
            return bookmark
        } else {
            return bookmarkBooks[index].bookmark.first!
        }
    }
}
