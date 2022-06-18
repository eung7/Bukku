//
//  LibraryManager.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/17.
//

import Foundation

enum LibraryType: Int, CaseIterable, Codable {
    case reading
    case willRead
    case doneRead
}

class LibraryManager {
    static let shared = LibraryManager()
    
    var allBooks: [LibraryBook] = [] {
        didSet {
            UserDefaultsManager.shared.saveBooks(allBooks)
        }
    }
}

extension LibraryManager {
    var readingBooks: [LibraryBook] {
        return allBooks.filter { $0.type == .reading }
    }
    var willReadBooks: [LibraryBook] {
        return allBooks.filter { $0.type == .willRead }
    }
    var doneReadBooks: [LibraryBook] {
        return allBooks.filter { $0.type == .doneRead }
    }
}

extension LibraryManager {
    func createLibraryBook(_ libraryType: LibraryType, book: Book) -> LibraryBook {
        return LibraryBook(type: libraryType, authors: book.authors, datetime: book.datetime, contents: book.contents, publisher: book.publisher, thumbnail: book.thumbnail, title: book.title, url: book.url)
    }
    
    func storeBook(_ book: LibraryBook) {
        allBooks.insert(book, at: 0)
    }
    
    func removeBook(_ libraryType: LibraryType, book: LibraryBook) {
        
    }
}
