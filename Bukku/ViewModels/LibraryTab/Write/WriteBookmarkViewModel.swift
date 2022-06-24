//
//  WriteBookmarkViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/22.
//

import Foundation

class WriteBookmarkViewModel {
    let manager = LibraryManager.shared
    let index: Int
    
    var book: LibraryBook {
        manager.allBooks[index]
    }
    
    init(_ book: LibraryBook) {
        index = manager.indexBook(book)
    }
}

extension WriteBookmarkViewModel {
    func createBookmark(_ page: String, contents: String) {
        var book = book
        let bookmark = Bookmark(page: page, contents: contents)
        book.bookmark.insert(bookmark, at: 0)
        manager.updateBook(book)
    }
    
    func updateBookmark(_ page: String, contents: String, bookmark: Bookmark) {
        var book = book
        guard let index = book.bookmark.firstIndex(of: bookmark) else { return }
        book.bookmark[index].update(page: page, contents: contents)
        manager.updateBook(book)
    }
}
