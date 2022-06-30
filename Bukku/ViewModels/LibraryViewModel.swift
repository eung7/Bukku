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
            return manager.willReadBooks[index]
        case .doneRead:
            return manager.doneReadBooks[index]
        default:
            return manager.allBooks[index]
        }
    }
    
    func numberOfItemsInSection(_ type: LibraryType?) -> Int {
        switch type {
        case .reading:
            return manager.readingBooks.count
        case .willRead:
            return manager.willReadBooks.count
        case .doneRead:
            return manager.doneReadBooks.count
        default:
            return manager.allBooks.count
        }
    }
    
    func saveBooks() {
        manager.saveBook()
    }
}
