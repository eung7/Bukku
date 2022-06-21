//
//  CollectionViewFooter.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/17.
//

import UIKit
import SnapKit

class CollectionViewFooter: UICollectionReusableView {
    // MARK: - Properties
    static let identifier = "CollectionViewFooter"
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .getDarkGreen()
        
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
        addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
