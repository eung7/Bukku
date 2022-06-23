//
//  WriteBookmarkViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/22.
//

import Foundation

class WriteBookmarkViewModel {
    var book: LibraryBook
    
    init(_ book: LibraryBook) {
        self.book = book
    }
}

extension WriteBookmarkViewModel {
    func createBookmark(_ page: String, contents: String) {
        let bookmark = Bookmark(page: page, contents: contents)
        book.bookmark.insert(bookmark, at: 0)
        LibraryManager.updateBook(book)
    }
}
