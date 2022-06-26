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
    var bookmark: Bookmark?
    var xmarkCompletion: ((Bookmark) -> Void)?
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getWhite()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        
        return label
    }()
    
    let bookmarkImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bookmark.fill")
        iv.tintColor = .getWhite()
        
        return iv
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .getWhite()
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
    
        return label
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
    
    lazy var trashButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .getWhite()
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration.init(pointSize: 16.0), forImageIn: .normal)
        button.addTarget(self, action: #selector(didTapXmarkButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var pinImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "pin.fill")
        iv.tintColor = .getWhite()
        iv.isHidden = true
        
        return iv
    }()
    
    // MARK: - Selectors
    @objc func didTapXmarkButton() {
        guard let bookmark = bookmark else { return }
        xmarkCompletion?(bookmark)
    }
    
    // MARK: - Helpers
    func configureUI() {
        contentView.backgroundColor = .getWhite()
        contentView.addSubview(ultraView)
        
        ultraView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        let stackView = UIStackView(arrangedSubviews: [ bookmarkImage, pageLabel ])
        stackView.axis = .horizontal
        stackView.spacing = 4.0
        
        [ stackView, contentsLabel, trashButton, pinImageView ]
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
        
        trashButton.snp.makeConstraints { make in
            make.centerY.equalTo(stackView)
            make.trailing.equalToSuperview().inset(16)
        }
        
        pinImageView.snp.makeConstraints { make in
            make.centerY.equalTo(stackView)
            make.trailing.equalTo(trashButton.snp.leading).offset(-4)
        }
    }
    
    func configureData(_ bookmark: Bookmark) {
        self.bookmark = bookmark
        if bookmark.page == "" {
            pageLabel.text = ""
        } else {
            pageLabel.text = "P.\(bookmark.page)"
        }
        contentsLabel.text = bookmark.contents
    }
}
