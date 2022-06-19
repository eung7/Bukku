//
//  LibraryDetailViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/19.
//

import Foundation

class LibraryDetailViewModel {
    var bookmarks: [Bookmark] = []
}

extension LibraryDetailViewModel {
    func numberOfRowsInSection() -> Int {
        return bookmarks.count
    }
    
    
}
