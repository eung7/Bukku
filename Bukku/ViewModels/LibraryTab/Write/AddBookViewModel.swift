//
//  AddBookViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/24.
//

import UIKit

class AddBookViewModel {
    let manager = LibraryManager.shared
    
    func createBook(type: LibraryType, title: String, author: String, image: UIImage) {
        manager.createBook_WriteAddVC(type, title: title, author: author, image: image)
    }
}
