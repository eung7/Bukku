//
//  SearchViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/31.
//

import Foundation

class SearchViewModel {
    var books: [Book] = []
}

class BookListViewModel {
    let book: Book
    
    init(book: Book) {
        self.book = book
    }
}

extension BookListViewModel {
    var thumbnailURL: String { return book.thumbnail }
}
