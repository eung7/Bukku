//
//  UserDefaults.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    func saveBooks(_ books: [LibraryBook]) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(try? PropertyListEncoder().encode(books), forKey: "AllBooks")
        userDefaults.synchronize()
    }
 
    func loadBooks() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.value(forKey: "AllBooks") as? Data {
            LibraryManager.shared.allBooks = try! PropertyListDecoder().decode([LibraryBook].self, from: data)
            userDefaults.synchronize()
        }
    }
}
