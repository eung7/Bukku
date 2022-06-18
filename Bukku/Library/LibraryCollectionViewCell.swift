//
//  LibraryCollectionViewCell.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/17.
//

import UIKit
import SnapKit
import Kingfisher

class LibraryCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "LibraryCollectionViewCell"
    
    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        
        return iv
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
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = UIColor.getBlack().cgColor
        layer.cornerRadius = 10
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowColor = UIColor.getBlack().cgColor
        layer.shadowOpacity = 0.5
        
        contentView.addSubview(bookImageView)
        
        bookImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configureImage(_ url: String) {
        if let url = URL(string: url) {
            bookImageView.kf.setImage(with: url)
        }
    }
}
