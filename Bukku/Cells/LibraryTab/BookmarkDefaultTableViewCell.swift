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
    var addButtonCompletion: () -> Void = {}
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .getWhite()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        return button
    }()
    
    let ultraView: UIView = {
        let view = UIView()
        view.backgroundColor = .getDarkGreen()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.getDarkGreen().cgColor
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowColor = UIColor.getDarkGreen().cgColor
        
        return view
    }()
    
    // MARK: - Selectors
    @objc func didTapAddButton() {
        addButtonCompletion()
    }
    
    // MARK: - Helpers
    func configureUI() {
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
