//
//  SettingsViewController.swift
//  Minimum
//
//  Created by 김응철 on 2022/05/27.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    let asdf: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(rgb: 0x538F6A)
        
        view.addSubview(asdf)
        
        asdf.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
