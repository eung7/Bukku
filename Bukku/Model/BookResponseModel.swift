//
//  BookResponseModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/31.
//

import Foundation

struct BookResponseModel: Codable {
    let documents: [Book]
}

struct Book: Codable {
    let authors: [String]
    let contents: String
    let datetime: String
    let publisher: String
    let price: Int
    let thumbnail: String
    let title: String
    let url: String
}

