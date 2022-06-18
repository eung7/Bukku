//
//  LibraryDetailBookmarkCollectionViewCell.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import UIKit
import SnapKit

class LibraryDetailBookmarkCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "LibraryDetailBookmarkCollectionViewCell"
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.text = "P.544"
        
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
        label.text = "contentscontentscontentscontentscontentscontentscontents"
        
        return label
    }()
    
    let verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .getBlack()
        
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
        contentView.backgroundColor = .getWhite()
        
        [ pageLabel, bookmarkImage, contentsLabel ]
            .forEach { contentView.addSubview($0) }
    }
    
    private func configureData() {
        
    }
}
