//
//  SettingTableViewCell.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/26.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "SettingTableViewCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getDarkGreen()
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        
        return label
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getDarkGreen()
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        
        return label
    }()
    
    // MARK: - Helpers
    func configureUI() {
        contentView.backgroundColor = .getWhite()
        
        [ titleLabel, resultLabel ]
            .forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        resultLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureData(_ list: String, results: String?) {
        titleLabel.text = list
        resultLabel.text = results
    }
}
