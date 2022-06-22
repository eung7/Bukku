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
    var bookmarks: [Bookmark] {
        return book.bookmark
    }
}

extension LibraryDetailViewModel {
    func numberOfRowsInSection() -> Int {
        return bookmarks.count
    }
}
