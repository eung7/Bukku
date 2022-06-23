//
//  BookmarkDefaultTableViewCell.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/23.
//

import UIKit
import SnapKit

class BookmarkDefaultTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "BookmarkDefaultTableViewCell"
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .getDarkGreen()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        return button
    }()
    
    let ultraView: UIView = {
        let view = UIView()
        view.backgroundColor = .getWhite()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.getDarkGreen().cgColor
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowColor = UIColor.getDarkGreen().cgColor
        
        return view
    }()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func didTapAddButton() {
        
    }
    
    // MARK: - Helpers
    private func configureUI() {
        contentView.backgroundColor = .getWhite()
        
        contentView.addSubview(ultraView)
        
        ultraView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
            make.height.equalTo(100)
        }
        
        ultraView.addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
