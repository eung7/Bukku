//
//  WriteReviewViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/22.
//

import Foundation

class WriteReviewViewModel {
    var book: LibraryBook
    
    init(_ book: LibraryBook) {
        self.book = book
    }
}

extension WriteReviewViewModel {
    var review: String? { book.review }
    
    func changeLibrary(_ type: LibraryType) {
        switch type {
        case .reading:
            book.type = .reading
            LibraryManager.updateBook(book)
        case .willRead:
            book.type = .willRead
            LibraryManager.updateBook(book)
        case .doneRead:
            book.type = .doneRead
            LibraryManager.updateBook(book)
        }
    }
}
