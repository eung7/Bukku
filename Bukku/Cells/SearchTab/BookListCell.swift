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
    var viewModel: SearchViewModel?

    let thumbnailImage: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .getWhite()
        iv.layer.borderWidth = 1
        
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getWhite()
        label.font = .systemFont(ofSize: 24.0, weight: .semibold)
        label.numberOfLines = 3
        
        return label
    }()
    
    let authorsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getWhite()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        
        return label
    }()
    
    let publisherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getWhite()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        
        return label
    }()
    
    let ultraView: UIView = {
        let view = UIView()
        
        return view
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
        guard let viewModel = viewModel else { return }
        if viewModel.thumbnailURL == "" {
            thumbnailImage.image = UIImage(systemName: "xmark.octagon")
            return
        }
        thumbnailImage.kf.setImage(with: URL(string: viewModel.thumbnailURL))
        titleLabel.text = viewModel.title
        authorsLabel.text = viewModel.author
        publisherLabel.text = viewModel.publisher
    }
    
    func configureUI() {
        contentView.backgroundColor = .getDarkGreen()
        contentView.layer.borderColor = UIColor.getWhite().cgColor
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        contentView.layer.shadowColor = UIColor.getWhite().cgColor
        contentView.layer.shadowOpacity = 0.5

        let verticalStack = UIStackView(arrangedSubviews: [ titleLabel, authorsLabel, publisherLabel ])
        verticalStack.axis = .vertical
        verticalStack.spacing = 4
        verticalStack.alignment = .leading
        
        [ thumbnailImage, verticalStack ]
            .forEach { contentView.addSubview($0) }
        
        thumbnailImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(100); make.height.equalTo(143)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(4)
            make.centerY.equalToSuperview()
        }
    }
}
