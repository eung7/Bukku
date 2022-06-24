//
//  LibraryBook.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import Foundation

struct LibraryBook: Codable, Identifiable, Equatable {
    var id = UUID()
    let title: String
    var review: String
    let author: String
    let image: Data
    var bookmark: [Bookmark]
    var type: LibraryType
    
    mutating func update(review: String, bookmark: [Bookmark], type: LibraryType) {
        self.review = review
        self.bookmark = bookmark
        self.type = type
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
