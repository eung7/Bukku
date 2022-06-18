//
//  LibraryDetailBookmarkCollectionViewCell.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import UIKit
import SnapKit

class LibraryDetailBookmarkCollectionViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "LibraryDetailBookmarkCollectionViewCell"
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getBlack()
        label.text = "P.544"
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        
        return label
    }()
    
    let bookmarkImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bookmark.fill")
        iv.tintColor = .getBlack()
        
        return iv
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "안녕하세요이번책은정말잘뽑았네 요 안녕하세 요이번책은정 말 잘뽑았네요 안녕 하세. 요이번 책은 정말 잘뽑았 네요 안녕하세요이번책은정말잘 뽑았네요 안녕하세 요이번책 은정 말잘뽑 았네요 "
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        
        return label
    }()
    
    let ultraView: UIView = {
        let view = UIView()
        view.backgroundColor = .getGray()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.getBlack().cgColor
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.getBlack().cgColor
        
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
        contentView.backgroundColor = .getGray()
        
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
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func configureData() {
        
    }
}
