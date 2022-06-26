//
//  SettingViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/26.
//

import Foundation

class SettingViewModel {
    let list: [String] = [
        "개발자에게 문의 메일 보내기",
        ""
    ]
    
    var numberOfRowsInSection: Int {
        return list.count
    }
}
