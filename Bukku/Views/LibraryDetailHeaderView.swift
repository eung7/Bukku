//
//  LibraryDetailHeaderView.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/23.
//

import UIKit
import SnapKit
import Cosmos

protocol LibraryDetailHeaderViewDelegate: AnyObject {
    func didTapWriteReviewButton(_ book: LibraryBook)
    func didTapWriteBookmarkButton(_ book: LibraryBook)
    func didTapChangeLibraryButton(_ book: LibraryBook)
    func didFinishTouchingCosmos(_ rating: Double)
}

class LibraryDetailHeaderView: UITableViewHeaderFooterView {
    // MARK: - Properties
    static let identifier = "LibraryDetailHeaderView"
    weak var delegate: LibraryDetailHeaderViewDelegate?
    var book: LibraryBook?
    
    let topBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .getGray()
        
        return view
    }()
    
    let bottomBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .getDarkGreen()
        
        return view
    }()
    
    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .getDarkGreen()
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.getWhite().cgColor
        iv.layer.shadowOpacity = 0.5
        iv.layer.shadowOffset = CGSize(width: 0, height: 0)
        iv.layer.shadowColor = UIColor.getWhite().cgColor
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let headerView: UIView = {
        let view = UIView()
    
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .getWhite()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32.0, weight: .bold)
        
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getWhite()
        label.font = .systemFont(ofSize: 18.0, weight: .medium)
        label.textAlignment = .center
        
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .getWhite()
        
        return view
    }()
    
    let reviewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .semibold)
        label.textColor = .getWhite()
        label.textAlignment = .center
        label.text = "내 서평"
        
        return label
    }()
    
    let bookmarkTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .semibold)
        label.textColor = .getWhite()
        label.textAlignment = .left
        label.text = "내 책갈피"
        
        return label
    }()
    
    let reviewSuperView: UIView = {
        let view = UIView()
        view.backgroundColor = .getWhite()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.getDarkGreen().cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.getDarkGreen().cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        return view
    }()
    
    lazy var cosmos: CosmosView = {
        let cosmos = CosmosView()
        cosmos.settings.updateOnTouch = true
        cosmos.settings.fillMode = .half
        cosmos.settings.starSize = 40
        cosmos.settings.starMargin = 5
        cosmos.settings.emptyBorderColor = .getWhite()
        cosmos.settings.emptyBorderWidth = 1
        cosmos.settings.filledBorderColor = .getWhite()
        cosmos.settings.filledColor = .getOrange()
        cosmos.didFinishTouchingCosmos = { [weak self] rating in
            self?.delegate?.didFinishTouchingCosmos(rating)
        }
        
        return cosmos
    }()
    
    lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .medium)
        label.textColor = .getDarkGreen()
        label.numberOfLines = 0
        label.text = "서평을 입력해주세요!"
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var writeReviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapWriteReviewButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration.init(pointSize: 30.0), forImageIn: .normal)
        button.tintColor = .getWhite()
        
        return button
    }()
    
    lazy var writeBookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapWriteBookmarkButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration.init(pointSize: 30.0), forImageIn: .normal)
        button.tintColor = .getWhite()
        
        return button
    }()
    
    lazy var changeLibraryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("서재함 옮기기", for: .normal)
        button.setTitleColor(UIColor.getDarkGreen(), for: .normal)
        button.addTarget(self, action: #selector(didTapChangeLibraryButton), for: .touchUpInside)
        button.backgroundColor = .getWhite()
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .medium)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        
        return button
    }()
        
    // MARK: - Selectors
    @objc func didTapWriteReviewButton() {
        guard let book = book else { return }
        delegate?.didTapWriteReviewButton(book)
    }
    
    @objc func didTapWriteBookmarkButton() {
        guard let book = book else { return }
        delegate?.didTapWriteBookmarkButton(book)
    }
    
    @objc func didTapChangeLibraryButton() {
        guard let book = book else { return }
        delegate?.didTapChangeLibraryButton(book)
    }
    
    // MARK: - Helpers
    func configureUI() {
        [ topBackground, bottomBackground, bookImageView, titleLabel, authorLabel, changeLibraryButton, lineView, reviewTitleLabel, writeReviewButton, reviewSuperView, bookmarkTitleLabel, writeBookmarkButton, cosmos ]
            .forEach { self.addSubview($0) }

        reviewSuperView.addSubview(reviewLabel)
        
        topBackground.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(lineView.snp.top)
        }
        
        bottomBackground.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        reviewLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        bookImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(174)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.equalTo(bookImageView.snp.bottom).offset(16)
        }

        authorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        cosmos.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        changeLibraryButton.snp.makeConstraints { make in
            make.top.equalTo(cosmos.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }

        lineView.snp.makeConstraints { make in
            make.top.equalTo(changeLibraryButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
        reviewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        writeReviewButton.snp.makeConstraints { make in
            make.centerY.equalTo(reviewTitleLabel)
            make.trailing.equalToSuperview().inset(16)
        }

        reviewSuperView.snp.makeConstraints { make in
            make.top.equalTo(reviewTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        bookmarkTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewSuperView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        writeBookmarkButton.snp.makeConstraints { make in
            make.centerY.equalTo(bookmarkTitleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configureData(_ book: LibraryBook) {
        self.book = book
        titleLabel.text = book.title
        authorLabel.text = book.author
        let image = UIImage(data: book.image) ?? UIImage()
        bookImageView.image = image
        
        if book.publisher != "" {
            authorLabel.text = "\(book.author) / \(book.publisher)"
        } else {
            authorLabel.text = book.author
        }
        
        if book.review != "" {
            reviewLabel.text = book.review
        }

        cosmos.rating = book.rating
    }
}

