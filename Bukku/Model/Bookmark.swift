//
//  Bookmark.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import Foundation

struct Bookmark: Codable {
    var id = UUID()
    let page: String
    let contents: String
}
