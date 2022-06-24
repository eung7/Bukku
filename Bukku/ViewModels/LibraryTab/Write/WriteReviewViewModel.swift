//
//  WriteReviewViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/22.
//

import Foundation

class WriteReviewViewModel {
    let manager = LibraryManager.shared
    let index: Int
    
    var book: LibraryBook {
        manager.allBooks[index]
    }
    
    init(_ book: LibraryBook) {
        index = manager.indexBook(book)
    }
}

extension WriteReviewViewModel {
    var review: String? { book.review }
    
    func updateReview(_ review: String) {
        var book = manager.allBooks[index]
        book.review = review
        manager.updateBook(book)
    }
}
