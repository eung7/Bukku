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

extension SearchViewModel {
    func getBookFromIndex(_ index: Int) -> BookListViewModel {
        return BookListViewModel(book: books[index])
    }
}

class BookListViewModel {
    let book: Book
    
    init(book: Book) {
        self.book = book
    }
}

extension BookListViewModel {
    var thumbnailURL: String { return book.thumbnail }
    var title: String { return book.title }
    var author: String { return book.authors.first! }
    var publisher: String { return book.publisher }
}
