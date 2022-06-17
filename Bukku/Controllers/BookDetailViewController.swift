//
//  BookDetailViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/17.
//

import UIKit
import SnapKit
import PanModal

class BookDetailViewController: UIViewController {
    // MARK: - Properties
    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .getBlack()
        
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 32.0, weight: .heavy)
        label.textAlignment = .center
        label.text = "초특급 Swift를 경험해보세요"
        
        return label
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요"
        
        return label
    }()
    
    let publisherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        label.text = "대원미디어"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        label.textAlignment = .center
        label.text = "김응철"
        
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        
        return view
    }()
    
    lazy var xmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .getBlack()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(didTapXmarkButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .getGray()
        button.setTitleColor(UIColor.getBlack(), for: .normal)
        button.layer.shadowColor = UIColor.getBlack().cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 10.0
        button.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.getBlack().cgColor
        button.layer.cornerRadius = 20
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .heavy)
        button.setTitle("내 서재에 담기", for: .normal)
        button.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func didTapXmarkButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapConfirmButton() {
        let selectLibraryVC = SelectLibraryViewController()
        presentPanModal(selectLibraryVC)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: xmarkButton)
        navigationItem.title = "책"
        
        [ bookImageView, titleLabel, contentsLabel, publisherLabel, authorsLabel, lineView, confirmButton ]
            .forEach { view.addSubview($0) }
        
        bookImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.width.equalTo(200)
            make.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bookImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        authorsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        publisherLabel.snp.makeConstraints { make in
            make.top.equalTo(authorsLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(publisherLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(0.5)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
