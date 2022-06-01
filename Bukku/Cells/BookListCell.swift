//
//  BookListCell.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/31.
//

import UIKit
import SnapKit
import Kingfisher

class BookListCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "BookListCell"
    var bookListVM: BookListViewModel?

    let thumbnailImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .getBlack()
        
        return iv
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureData() {
        guard let bookListVM = bookListVM else { return }
        if bookListVM.thumbnailURL == "" {
            thumbnailImage.image = UIImage(systemName: "xmark.octagon")
            return
        }
        thumbnailImage.kf.setImage(with: URL(string: bookListVM.thumbnailURL))
    }
    
    func configureUI() {
        contentView.backgroundColor = .getWhite()
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.getBlack().cgColor
        
        contentView.addSubview(thumbnailImage)
        
        thumbnailImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// TODO: [] 검색 무한 스크롤 만들기

