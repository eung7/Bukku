//
//  LibraryDetailViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/19.
//

import Foundation
import UIKit

class LibraryDetailViewModel {
    let manager = LibraryManager.shared
    let index: Int
    
    var book: LibraryBook {
        manager.allBooks[index]
    }
    
    var detailBookmarks: [Bookmark] {
        if let pin = book.bookmark.first(where: { $0.pin == true }) {
            var book = book
            guard let index = book.bookmark.firstIndex(of: pin) else { return [] }
            book.bookmark.remove(at: index)
            book.bookmark.insert(pin, at: 0)
            return book.bookmark
        } else {
            return book.bookmark
        }
    }
    
    init(_ book: LibraryBook) {
        index = manager.indexBook(book)
    }
    
    var title: String { book.title }
    var author: String? { book.author }
    var image: UIImage { UIImage(data: book.image) ?? UIImage() }
    var review: String { book.review }
    var bookmarks: [Bookmark] { book.bookmark }

    func numberOfRowsInSection() -> Int {
        return detailBookmarks.count
    }
    
    func removeBook(_ book: LibraryBook) {
        manager.removeBook(book)
    }
    
    func removeBookmark(_ book: LibraryBook, index: Int) {
        var book = book
        let targetBookmark = detailBookmarks[index]
        guard let index = book.bookmark.firstIndex(of: targetBookmark) else { return }
        book.bookmark.remove(at: index)
        manager.updateBook(book)
    }
    
    func saveBook() {
        manager.saveBook()
    }
}
