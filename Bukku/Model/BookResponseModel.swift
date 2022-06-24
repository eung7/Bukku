//
//  BookResponseModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/31.
//

import Foundation

struct BookResponseModel: Codable {
    let documents: [Book]
    let meta: Meta
}

struct Book: Codable {
    let isbn: String
    let authors: [String]
    let contents: String
    let datetime: String
    let publisher: String
    let thumbnail: String
    let title: String
    let url: String
}

struct Meta: Codable {
    let is_end: Bool
}
