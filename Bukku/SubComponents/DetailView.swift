//
//  DetailView.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/28.
//

import UIKit
import SnapKit

class DetailView: UIView {
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
       
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = UIColor.init(rgb: 0x1B4B36)
        layer.cornerRadius = 15.0
        
        [ label ]
            .forEach { addSubview($0) }
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
