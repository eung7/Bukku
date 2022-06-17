//
//  LibraryManager.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/17.
//

import Foundation

enum LibraryType: Int, CaseIterable {
    case reading
    case willRead
    case doneRead
}

class LibraryManager {
    static let shared = LibraryManager()
    var readingBooks: [Book] = []
    var willReadBooks: [Book] = []
    var doneReadBooks: [Book] = []
    
    var allBooks: [Book] {
        return readingBooks + willReadBooks + doneReadBooks
    }
}

extension LibraryManager {
    func storeBook(_ libraryType: LibraryType, book: Book) {
        switch libraryType {
        case .reading:
            readingBooks.append(book)
        case .willRead:
            willReadBooks.append(book)
        case .doneRead:
            doneReadBooks.append(book)
        }
    }
    
    func removeBook(_ libraryType: LibraryType, book: Book) {
        switch libraryType {
        case .reading:
            let index = readingBooks.firstIndex(where: { book.title == $0.title })
            if let index = index {
                readingBooks.remove(at: index)
            }
        case .willRead:
            let index = willReadBooks.firstIndex(where: { book.title == $0.title })
            if let index = index {
                willReadBooks.remove(at: index)
            }
        case .doneRead:
            let index = doneReadBooks.firstIndex(where: { book.title == $0.title })
            if let index = index {
                doneReadBooks.remove(at: index)
            }
        }
    }
}
