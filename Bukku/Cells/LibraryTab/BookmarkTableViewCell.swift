//
//  LibraryDetailBookmarkCollectionViewCell.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import UIKit
import SnapKit

class BookmarkTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "LibraryDetailBookmarkCollectionViewCell"
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getDarkGreen()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.text = "P.123"
        
        return label
    }()
    
    let bookmarkImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bookmark.fill")
        iv.tintColor = .getDarkGreen()
        
        return iv
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .getDarkGreen()
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        label.text = "책갈피를 입력해주세요!"
    
        return label
    }()
    
    let ultraView: UIView = {
        let view = UIView()
        view.backgroundColor = .getOrange()
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
    
    // MARK: - Helpers
    private func configureUI() {
        contentView.backgroundColor = .getWhite()
        contentView.addSubview(ultraView)
        
        ultraView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        let stackView = UIStackView(arrangedSubviews: [ bookmarkImage, pageLabel ])
        stackView.axis = .horizontal
        stackView.spacing = 4.0
        
        [ stackView, contentsLabel ]
            .forEach { ultraView.addSubview($0) }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(50)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configureData(_ bookmark: Bookmark) {
        pageLabel.text = "P.\(bookmark.page)"
        contentsLabel.text = bookmark.contents
    }
}