//
//  Bookmark.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import Foundation

struct Bookmark: Codable, Equatable {
    var id = UUID()
    var page: String
    var contents: String
    
    mutating func update(page: String, contents: String) {
        self.page = page
        self.contents = contents
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
