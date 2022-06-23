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
    private init() {}
    
    static let shared = LibraryManager()
    
    var allBooks: [LibraryBook] = []
    
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
    func createBook(_ libraryType: LibraryType, book: Book) {
        let book = LibraryBook(title: book.title, review: "", authors: book.authors, bookmark: [], type: libraryType, thumbnail: book.thumbnail)
        allBooks.insert(book, at: 0)
    }
    
    /// 서재로 부터 책 제거
    func removeBook(_ book: LibraryBook) {
        guard let index = allBooks.firstIndex(where: { $0.id == book.id }) else { return }
        allBooks.remove(at: index)
    }
    
    func deleteBook(_ book: LibraryBook) {
        allBooks = allBooks.filter { $0.id != book.id }
        saveBook()
    }
    
    func updateBook(_ book: LibraryBook) {
        guard let index = allBooks.firstIndex(of: book) else { return }
        allBooks[index].update(review: book.review, bookmark: book.bookmark, type: book.type)
        saveBook()
    }
}

/// With Storage
extension LibraryManager {
    func saveBook() {
        Storage.store(allBooks, to: .documents, as: "books.json")
    }

    func retrieveBook() {
        allBooks = Storage.retrive("books.json", from: .documents, as: [LibraryBook].self) ?? []
    }
}
