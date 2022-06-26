//
//  SettingViewModel.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/26.
//

import Foundation

class SettingViewModel {
    var version: String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String,
            let build = dictionary["CFBundleVersion"] as? String else {return nil}

        let versionAndBuild: String = "vserion: \(version), build: \(build)"
        return versionAndBuild
    }
    
    let list: [String] = [
        "앱 버전",
        "개발자에게 문의 메일 보내기"
    ]
    
    var numberOfRowsInSection: Int {
        return list.count
    }
}
