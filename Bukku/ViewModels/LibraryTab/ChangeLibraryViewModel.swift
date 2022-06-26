//
//  ChangeLibraryViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/24.
//

import Foundation

class ChangeLibraryViewModel {
    let manager = LibraryManager.shared
    let index: Int
    
    var book: LibraryBook {
        return manager.allBooks[index]
    }
    
    init(_ book: LibraryBook) {
        index = manager.indexBook(book)
    }

    func changeLibrary(_ type: LibraryType) {
        var book = manager.allBooks[index]
        book.type = type
        manager.updateBook(book)
    }
    
    
}
