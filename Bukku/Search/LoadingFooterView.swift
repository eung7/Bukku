//
//  LoadingFooterView.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/02.
//

import SnapKit
import UIKit

class LoadingFooterView: UICollectionReusableView {
    // MARK: - Properties
    static let identifier = "LoadingFooterView"
    
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        return indicator
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureUI() {
        backgroundColor = .clear
        addSubview(indicator)
        
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
