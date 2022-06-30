//
//  SearchLibraryViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/24.
//

import Foundation

class SearchLibraryViewModel {
    let manager = LibraryManager.shared
    
    var books: [LibraryBook] {
        return manager.allBooks
    }
    
    var result: [LibraryBook] = []

    func searchTitle(_ text: String) {
        result = books.filter { $0.title.localizedStandardContains(text) }
    }
    
    func numberOfItemsInSection() -> Int {
        return result.count
    }
}
