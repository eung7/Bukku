//
//  StoredBook'.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import Foundation

struct LibraryBook: Codable {
    let type: LibraryType
    let authors: [String]
    let datetime: String
    let contents: String
    let publisher: String
    let thumbnail: String
    let title: String
    let url: String
}
