//
//  LibraryDetailViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/19.
//

import Foundation

class LibraryDetailViewModel {
    var book: LibraryBook
    
    init(_ book: LibraryBook) {
        self.book = book
    }
}

extension LibraryDetailViewModel {
    var title: String { book.title }
    var author: String? { book.authors.first }
    var thumbnail: String { book.thumbnail }
    var review: String { book.review }
    var bookmarks: [Bookmark] { book.bookmark }
}

extension LibraryDetailViewModel {
    func numberOfRowsInSection() -> Int {
        return bookmarks.count
    }
    
    func removeBookmark(_ bookmark: Bookmark) {
        guard let index = book.bookmark.firstIndex(where: { $0.id == bookmark.id }) else { return }
        book.bookmark.remove(at: index)
        LibraryManager.updateBook(book)
    }
}