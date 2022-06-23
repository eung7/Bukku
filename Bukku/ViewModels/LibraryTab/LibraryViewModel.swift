//
//  LibraryViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/22.
//

import Foundation

class LibraryViewModel {
    
}

// MARK: - SubVC
extension LibraryViewModel {
    func getBookFromIndex(_ type: LibraryType?, index: Int) -> LibraryBook {
        switch type {
        case .reading:
            return LibraryManager.readingBooks[index]
        case .willRead:
            return LibraryManager.willReadBooks[index]
        case .doneRead:
            return LibraryManager.doneReadBooks[index]
        default:
            return LibraryManager.allBooks[index]
        }
    }
    
    func numberOfItemsInSection(_ type: LibraryType?) -> Int {
        switch type {
        case .reading:
            return LibraryManager.readingBooks.count
        case .willRead:
            return LibraryManager.willReadBooks.count
        case .doneRead:
            return LibraryManager.doneReadBooks.count
        default:
            return LibraryManager.allBooks.count
        }
    }
}

