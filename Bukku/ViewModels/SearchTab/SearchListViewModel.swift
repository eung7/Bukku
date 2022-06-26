//
//  SearchViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/31.
//

import Foundation

class SearchListViewModel {
    var books: [Book] = []

    var numberOfItemsInSection: Int {
        return books.count
    }
}

class SearchViewModel {
    var book: Book
    
    init(_ book: Book) {
        self.book = book
    }
    
    var thumbnailURL: String {
        return book.thumbnail
    }
    
    var title: String {
        return book.title
    }
    
    var author: String? {
        return book.authors.first
    }
    
    var publisher: String {
        return book.publisher
    }
}
