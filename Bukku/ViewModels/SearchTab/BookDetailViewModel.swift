//
//  BookDetailViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/24.
//

import Foundation

class BookDetailViewModel {
    let manager = LibraryManager.shared
    let book: Book
    
    init(_ book: Book) {
        self.book = book
    }
}

extension BookDetailViewModel {
    var title: String {
        return book.title
    }
    
    var author: String? {
        return book.authors.first
    }
    
    var publisher: String {
        return book.publisher
    }
    
    var image: URL? {
        return URL(string: book.thumbnail)
    }
}

extension BookDetailViewModel {
    func insertMyLibrary(_ type: LibraryType, book: Book) {
        manager.createBook(type, book: book)
    }
    
    func verifyLibrary(_ book: Book) -> Bool {
        return manager.allBooks.contains(where: { $0.id == book.isbn })
    }
}
