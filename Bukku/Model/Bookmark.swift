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
    var pin: Bool
    
    mutating func update(page: String, contents: String, pin: Bool) {
        self.page = page
        self.contents = contents
        self.pin = pin
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
