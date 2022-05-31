//
//  TitleListCell.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/31.
//

import UIKit
import SnapKit

class TitleListCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "TitleListCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getBlack()
        
        return label
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureUI() {
        contentView.backgroundColor = .getGray()
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        }
    }
}
