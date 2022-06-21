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
    var currentId: Int = 0
    
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

// MARK: - 만들기, 삭제하기, 업데이트
extension LibraryManager {
    func createLibraryBook(_ libraryType: LibraryType, book: Book) -> LibraryBook {
        return LibraryBook(review: nil, bookmark: [], type: libraryType, authors: book.authors, contents: book.contents, publisher: book.publisher, thumbnail: book.thumbnail, title: book.title)
    }
    
    func storeBook(_ book: LibraryBook) {
        allBooks.insert(book, at: 0)
    }
    
    func removeBook(_ book: LibraryBook) {
        guard let index = allBooks.firstIndex(where: { $0.id == book.id }) else { return }
        allBooks.remove(at: index)
    }
    
    func updateBook(_ book: LibraryBook) {
        guard let index = allBooks.firstIndex(where: { $0.id == book.id }) else { return }
        allBooks[index] = book
    }
    
    func getIndexFromAllBooks(_ book: LibraryBook) -> Int {
        if let index = allBooks.firstIndex(where: { $0.id == book.id }) {
            return index
        }
        return 0
    }
    
    func getBookFromIndex(_ index: Int) -> LibraryBook {
        let book = allBooks[index]
        return book
    }
}

// MARK: - BookmarkManager
extension LibraryManager {
    func createBookmark(_ book: LibraryBook, page: String, contents: String) {
        var updatedBook = book
        let bookmark = Bookmark(page: page, contents: contents)
        updatedBook.bookmark.insert(bookmark, at: 0)
        updateBook(updatedBook)
    }
}
