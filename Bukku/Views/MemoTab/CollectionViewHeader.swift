//
//  CollectionViewHeader.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/28.
//

import UIKit
import SnapKit

class CollectionViewHeader: UICollectionReusableView {
    // MARK: - Properties
    static let identifier = "CollectionViewHeader"
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .getBlack()
        label.font = .systemFont(ofSize: 36.0, weight: .ultraLight)
        
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("더보기", for: .normal)
        
        return button
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
    func configureUI() {
        [ label, button ]
            .forEach { addSubview($0) }
        
        label.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(4)
        }
    }
}

