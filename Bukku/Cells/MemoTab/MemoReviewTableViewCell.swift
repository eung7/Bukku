//
//  MemoReviewTableViewCell.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/25.
//

import UIKit
import SnapKit

class MemoReviewTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "MemoReviewTableViewCell"
    
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
    
    lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textColor = .getDarkGreen()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        
        return label
    }()
    
    lazy var reviewUltraView: UIView = {
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
    
    // MARK: - Helpers
    func configureUI() {
        contentView.addSubview(ultraView)
        contentView.backgroundColor = .getWhite()
        
        let stack = UIStackView(arrangedSubviews: [ titleLabel, authorLabel ])
        stack.axis = .vertical
        stack.spacing = 4
        
        ultraView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(4)
        }
        
        [ bookImageView, stack, reviewUltraView ]
            .forEach { ultraView.addSubview($0) }
        
        reviewUltraView.addSubview(reviewLabel)
        
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
        
        reviewUltraView.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(8)
            make.bottom.leading.trailing.equalToSuperview().inset(8)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    func configureData(_ book: LibraryBook) {
        bookImageView.image = UIImage(data: book.image)
        titleLabel.text = book.title
        authorLabel.text = book.author
        reviewLabel.text = book.review
    }
}
