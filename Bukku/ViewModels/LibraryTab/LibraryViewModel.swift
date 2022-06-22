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
    func imageURLStr(_ type: LibraryType?, index: Int) -> String {
        switch type {
        case .reading:
            return LibraryManager.readingBooks[index].thumbnail
        case .willRead:
            return LibraryManager.willReadBooks[index].thumbnail
        case .doneRead:
            return LibraryManager.doneReadBooks[index].thumbnail
        default:
            return LibraryManager.allBooks[index].thumbnail
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

