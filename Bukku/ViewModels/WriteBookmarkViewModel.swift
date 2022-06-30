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
    
    func createBookmark(_ page: String, contents: String, pin: Bool) {
        var book = book
        let newBookmark = Bookmark(page: page, contents: contents, pin: pin)
        
        if pin == true {
            let bookmarks = book.bookmark.map { bookmark -> Bookmark in
                var bookmark = bookmark
                bookmark.update(page: bookmark.page, contents: bookmark.contents, pin: false)
                return bookmark
            }
            book.bookmark = bookmarks
            book.bookmark.insert(newBookmark, at: 0)
            manager.updateBook(book)
        } else {
            book.bookmark.insert(newBookmark, at: 0)
            manager.updateBook(book)
        }
    }
    
    func updateBookmark(_ page: String, contents: String, bookmark: Bookmark, pin: Bool) {
        var book = book
        guard let index = book.bookmark.firstIndex(of: bookmark) else { return }
        
        if pin == true {
            let bookmarks = book.bookmark.map { bookmark -> Bookmark in
                var bookmark = bookmark
                bookmark.update(page: bookmark.page, contents: bookmark.contents, pin: false)
                return bookmark
            }
            book.bookmark = bookmarks
            book.bookmark[index].update(page: page, contents: contents, pin: pin)
            manager.updateBook(book)
        } else {
            book.bookmark[index].update(page: page, contents: contents, pin: pin)
            manager.updateBook(book)
        }
    }
}

