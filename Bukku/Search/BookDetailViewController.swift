//
//  BookDetailViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/17.
//

import UIKit
import Kingfisher
import SnapKit
import PanModal

class BookDetailViewController: UIViewController {
    // MARK: - States
    var bookListVM: BookListViewModel
    
    // MARK: - Properties
    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .getBlack()
        iv.layer.shadowColor = UIColor.getBlack().cgColor
        iv.layer.shadowOpacity = 0.5
        iv.layer.shadowRadius = 10.0
        iv.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        iv.layer.borderWidth = 1
    
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 32.0, weight: .heavy)
        label.textAlignment = .center
        
        return label
    }()
    
    let publisherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        label.textAlignment = .center
        
        return label
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
        configureData()
    }
    
    init(bookListVM: BookListViewModel) {
        self.bookListVM = bookListVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func didTapXmarkButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapConfirmButton() {
        let selectLibraryVC = SelectLibraryViewController(book: bookListVM.book)
        selectLibraryVC.dismissCompletion = { [weak self] in
            self?.dismiss(animated: true)
        }
        presentPanModal(selectLibraryVC)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getGray()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: xmarkButton)
        navigationItem.title = "책"
        
        [ bookImageView, titleLabel, publisherLabel, authorsLabel, confirmButton ]
            .forEach { view.addSubview($0) }
        
        bookImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(24)
            make.width.equalTo(150)
            make.height.equalTo(200)
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
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(publisherLabel.snp.bottom).offset(16)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    private func configureData() {
        titleLabel.text = bookListVM.title
        authorsLabel.text = bookListVM.author
        publisherLabel.text = bookListVM.publisher
        bookImageView.kf.setImage(with: URL(string: bookListVM.thumbnailURL))
    }
}

extension BookDetailViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(450)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(450)
    }
}
