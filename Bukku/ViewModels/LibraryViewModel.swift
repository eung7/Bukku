//
//  LibraryViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/22.
//

import Foundation

class LibraryViewModel {
    let manager = LibraryManager.shared
    
    var allBooks: [LibraryBook] {
        return manager.allBooks
    }
    
    var readingBooks: [LibraryBook] {
        return manager.readingBooks
    }
    
    var willBooks: [LibraryBook] {
        return manager.willReadBooks
    }

    var doneBooks: [LibraryBook] {
        return manager.doneReadBooks
    }
    
    func getBookFromIndex(_ type: LibraryType?, index: Int) -> LibraryBook {
        switch type {
        case .reading:
            return readingBooks[index]
        case .willRead:
            return willBooks[index]
        case .doneRead:
            return doneBooks[index]
        default:
            return allBooks[index]
        }
    }
    
    func numberOfItemsInSection(_ type: LibraryType?) -> Int {
        switch type {
        case .reading:
            return readingBooks.count
        case .willRead:
            return willBooks.count
        case .doneRead:
            return doneBooks.count
        default:
            return allBooks.count
        }
    }
    
    func saveBooks() {
        manager.saveBook()
    }
}

