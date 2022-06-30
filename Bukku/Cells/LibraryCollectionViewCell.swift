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
    
    lazy var bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
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
        layer.borderColor = UIColor.getWhite().cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowColor = UIColor.getWhite().cgColor
        layer.shadowOpacity = 0.5
        
        contentView.addSubview(bookImageView)
        
        bookImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureImage(_ book: LibraryBook) {
        let image = UIImage(data: book.image) ?? UIImage()
        bookImageView.image = image
    }
}
