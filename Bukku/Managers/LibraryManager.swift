//
//  LibraryManager.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/17.
//

import Foundation
import Kingfisher
import UIKit

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
        guard let url = URL(string: book.thumbnail) else { return }
        KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
            switch result {
            case .success(let value):
                guard let imageData = value.image.pngData() else { return }
                let book = LibraryBook(title: book.title, review: "", author: book.authors.first!, image: imageData, bookmark: [], type: libraryType)
                self?.allBooks.insert(book, at: 0)
                self?.saveBook()
            case .failure(let error):
                print("ERROR! \(error.localizedDescription)")
            }
        }
    }
    
    func createBook_WriteAddVC(_ libraryType: LibraryType, title: String, author: String, image: UIImage) {
        guard let imageData = image.pngData() else { return }
        let book = LibraryBook(title: title, review: "", author: author, image: imageData, bookmark: [], type: libraryType)
        allBooks.insert(book, at: 0)
        saveBook()
    }
    
    func removeBook(_ book: LibraryBook) {
        guard let index = allBooks.firstIndex(where: { $0.id == book.id }) else { return }
        allBooks.remove(at: index)
        saveBook()
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
    
    func indexBook(_ book: LibraryBook) -> Int {
        guard let index = allBooks.firstIndex(of: book) else { return 0 }
        return index
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
