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
    
    static var allBooks: [LibraryBook] = [] {
        didSet {
            UserDefaultsManager.shared.saveBooks(allBooks)
        }
    }
}

// MARK: - 조회하기
extension LibraryManager {
    static var readingBooks: [LibraryBook] {
        return allBooks.filter { $0.type == .reading }
    }
    static var willReadBooks: [LibraryBook] {
        return allBooks.filter { $0.type == .willRead }
    }
    static var doneReadBooks: [LibraryBook] {
        return allBooks.filter { $0.type == .doneRead }
    }
}

// MARK: - 추가, 제거, 업데이트
extension LibraryManager {
    /// 서재에 책 추가
    static func createBook(_ libraryType: LibraryType, book: Book, imageBase64: String?) {
        let book = LibraryBook(review: "", bookmark: [], type: libraryType, imageBase64: imageBase64, authors: book.authors, contents: book.contents, publisher: book.publisher, thumbnail: book.thumbnail, title: book.title)
        allBooks.insert(book, at: 0)
    }
    
    /// 서재로 부터 책 제거
    static func removeBook(_ book: LibraryBook) {
        guard let index = allBooks.firstIndex(where: { $0.id == book.id }) else { return }
        allBooks.remove(at: index)
    }
    
    /// 서재에서 책 업데이트
    static func updateBook(_ book: LibraryBook) {
        guard let index = allBooks.firstIndex(where: { $0.id == book.id }) else { return }
        allBooks[index] = book
    }
}
