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
    
    init(_ book: LibraryBook) {
        index = manager.indexBook(book)
    }
}

extension LibraryDetailViewModel {
    var title: String { book.title }
    var author: String? { book.author }
    var image: UIImage { UIImage(data: book.image) ?? UIImage() }
    var review: String { book.review }
    var bookmarks: [Bookmark] { book.bookmark }
}

extension LibraryDetailViewModel {
    func numberOfRowsInSection() -> Int {
        return bookmarks.count
    }
    
    func removeBook(_ book: LibraryBook) {
        manager.removeBook(book)
    }
    
    func removeBookmark(_ book: LibraryBook, index: Int) {
        var book = book
        book.bookmark.remove(at: index)
        manager.updateBook(book)
    }
    
    func saveBook() {
        manager.saveBook()
    }
}
