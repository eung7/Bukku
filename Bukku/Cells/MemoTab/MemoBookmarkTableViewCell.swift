//
//  MemoBookmarkTableViewCell.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/25.
//

import UIKit
import SnapKit

class MemoBookmarkTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "MemoBookmarkTableViewCell"
    
    lazy var ultraView: UIView = {
        let view = UIView()
        view.backgroundColor = .getWhite()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.getDarkGreen().cgColor
        view.layer.cornerRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.getDarkGreen().cgColor
        
        return view
    }()
    
    lazy var bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.layer.borderColor = UIColor.getDarkGreen().cgColor
        iv.layer.shadowOffset = CGSize(width: 0, height: 0)
        iv.layer.shadowColor = UIColor.getDarkGreen().cgColor
        iv.layer.shadowOpacity = 0.5
        
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .getDarkGreen()
        label.font = .systemFont(ofSize: 24.0, weight: .semibold)
        
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .getDarkGreen()
        label.font = .systemFont(ofSize: 16.0, weight: .thin)
        
        return label
    }()
    
    lazy var bookmarkLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .getWhite()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        
        return label
    }()
    
    lazy var bookmarkImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bookmark.fill")
        iv.tintColor = .getWhite()
        
        return iv
    }()
    
    lazy var bookmarkImage_Count: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bookmark.fill")
        iv.tintColor = .getWhite()
        
        return iv
    }()
    
    lazy var bookmarkCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getWhite()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        
        return label
    }()
    
    lazy var pageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getWhite()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        
        return label
    }()
    
    lazy var bookmarkUltraView: UIView = {
        let view = UIView()
        view.backgroundColor = .getDarkGreen()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.getDarkGreen().cgColor
        view.layer.cornerRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.getDarkGreen().cgColor
        
        return view
    }()
    
    lazy var pinImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .getWhite()
        iv.image = UIImage(systemName: "pin.fill")
        
        return iv
    }()
    
    // MARK: - Helpers
    func configureUI() {
        contentView.addSubview(ultraView)
        contentView.backgroundColor = .getWhite()
        
        let stack = UIStackView(arrangedSubviews: [ titleLabel, authorLabel ])
        stack.axis = .vertical
        stack.spacing = 4
        
        let bookmarkCountStack = UIStackView(arrangedSubviews: [ bookmarkImage_Count, bookmarkCountLabel ])
        bookmarkCountStack.axis = .horizontal
        bookmarkCountStack.spacing = 4
        
        ultraView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(4)
        }
        
        [ bookImageView, stack, bookmarkUltraView ]
            .forEach { ultraView.addSubview($0) }
        
        [ pageLabel, bookmarkCountStack, bookmarkImage, bookmarkLabel, pinImageView ]
            .forEach { bookmarkUltraView.addSubview($0) }
        
        bookImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(8)
            make.width.equalTo(70)
            make.height.equalTo(100)
        }
        
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(bookImageView)
            make.trailing.equalToSuperview().inset(8)
            make.leading.equalTo(bookImageView.snp.trailing).offset(8)
        }
        
        bookmarkUltraView.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(8)
            make.bottom.leading.trailing.equalToSuperview().inset(8)
        }
        
        bookmarkImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
        }
        
        pageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(bookmarkImage)
            make.leading.equalTo(bookmarkImage.snp.trailing).offset(4)
        }
        
        bookmarkCountStack.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
        }
        
        bookmarkLabel.snp.makeConstraints { make in
            make.top.equalTo(bookmarkImage.snp.bottom).offset(8)
            make.bottom.leading.trailing.equalToSuperview().inset(8)
        }
        
        pinImageView.snp.makeConstraints { make in
            make.trailing.equalTo(bookmarkCountStack.snp.leading).offset(-4)
            make.centerY.equalTo(bookmarkCountStack)
        }
    }
    
    func configureData(_ book: LibraryBook, bookmark: Bookmark) {
        pinImageView.isHidden = true
        bookImageView.image = UIImage(data: book.image)
        titleLabel.text = book.title
        authorLabel.text = book.author
        bookmarkLabel.text = bookmark.contents
        bookmarkCountLabel.text = "X \(book.bookmark.count)"
        
        if book.bookmark.first!.page != "" {
            pageLabel.text = "P.\(bookmark.page)"
        } else {
            pageLabel.text = ""
        }
        
        if bookmark.pin == true {
            pinImageView.isHidden = false
        }
    }
}
