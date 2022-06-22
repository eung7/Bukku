//
//  LibraryViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/22.
//

import Foundation

class LibraryViewModel {
    let manager = LibraryManager.shared
}

extension LibraryViewModel {
    func indexFromAllBooks(_ book: LibraryBook) -> Int {
        return manager.getIndexFromAllBooks(book)
    }
}

// MARK: - SubVC
extension LibraryViewModel {
    func imageURLStr(_ type: LibraryType?, index: Int) -> String {
        switch type {
        case .reading:
            return manager.readingBooks[index].thumbnail
        case .willRead:
            return manager.willReadBooks[index].thumbnail
        case .doneRead:
            return manager.doneReadBooks[index].thumbnail
        default:
            return manager.allBooks[index].thumbnail
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
}

