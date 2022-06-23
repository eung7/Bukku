//
//  StoredBook'.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import Foundation

struct LibraryBook: Codable, Identifiable {
    var id = UUID()
    var review: String
    var bookmark: [Bookmark]
    var type: LibraryType
    let authors: [String]
    let contents: String
    let publisher: String
    let thumbnail: String
    let title: String
}
