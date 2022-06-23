//
//  MemoTableViewHeader.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/22.
//

import UIKit
import SnapKit
import Kingfisher

class MemoTableViewHeader: UIView {
    // MARK: - Properties
    var book: LibraryBook?
    
    let bookImageView: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getWhite()
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.numberOfLines = 3
        label.text = "책 이름책 "
        
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getWhite()
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        label.text = "작가이름"
        
        return label
    }()
    
    let ultraView: UIView = {
        let view = UIView()
        view.backgroundColor = .getGray()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.getWhite().cgColor
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.getDarkGreen().cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.5
        
        return view
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        self.backgroundColor = .getWhite()
        
        let stack = UIStackView(arrangedSubviews: [ titleLabel, authorLabel ])
        stack.spacing = 4.0
        stack.axis = .vertical
        
        self.addSubview(ultraView)
        
        ultraView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        [ bookImageView, stack ]
            .forEach { ultraView.addSubview($0) }
        
        bookImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(12)
            make.width.equalTo(70)
            make.height.equalTo(100)
            make.bottom.equalToSuperview().inset(8)
        }
        
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(bookImageView)
            make.trailing.equalToSuperview().inset(8)
            make.leading.equalTo(bookImageView.snp.trailing).offset(8)
        }
    }
    
    func configureData() {
        guard let book = book else { return }
        guard let url = URL(string: book.thumbnail) else { return }
        bookImageView.kf.setImage(with: url)
        titleLabel.text = book.title
        authorLabel.text = book.authors.first
    }
}
