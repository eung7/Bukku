//
//  SettingViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/26.
//

import Foundation

class SettingViewModel {
    let list: [String] = [
        "앱 버전",
        "문의 메일 보내기"
    ]
    
    let results: [String?] = [
        VERSION,
        ""
    ]
    
    var numberOfRowsInSection: Int {
        return list.count
    }
}

