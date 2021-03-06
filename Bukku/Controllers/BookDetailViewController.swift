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
import MarqueeLabel
import Toast

class BookDetailViewController: UIViewController {
    // MARK: - States
    let viewModel: BookDetailViewModel
    
    // MARK: - Properties
    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .getDarkGreen()
        iv.layer.shadowColor = UIColor.getDarkGreen().cgColor
        iv.layer.shadowOpacity = 0.5
        iv.layer.shadowRadius = 10.0
        iv.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        iv.layer.borderWidth = 1
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
    
        return iv
    }()
    
    let titleLabel: MarqueeLabel = {
        let label = MarqueeLabel()
        label.font = .systemFont(ofSize: 32.0, weight: .heavy)
        label.trailingBuffer = 100.0
        label.textAlignment = .center
        label.animationCurve = .easeInOut
        label.textColor = .getDarkGreen()
        
        return label
    }()
    
    let publisherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        label.textAlignment = .center
        label.textColor = .getDarkGreen()
        
        return label
    }()
    
    let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        label.textAlignment = .center
        label.textColor = .getDarkGreen()
        
        return label
    }()
    
    lazy var xmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .getDarkGreen()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(didTapXmarkButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .getWhite()
        button.setTitleColor(UIColor.getDarkGreen(), for: .normal)
        button.layer.shadowColor = UIColor.getDarkGreen().cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 10.0
        button.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.getDarkGreen().cgColor
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
    
    init(_ book: Book) {
        self.viewModel = BookDetailViewModel(book)
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
        if viewModel.verifyLibrary(viewModel.book) {
            view.makeToast("이미 추가한 책이에요!", duration: 1.0, position: .top, title: nil, image: nil, style: .init(), completion: nil)
        } else {
            let selectLibraryVC = SelectLibraryViewController()
            selectLibraryVC.dismissCompletion = { [unowned self] type in
                self.viewModel.insertMyLibrary(type, book: self.viewModel.book)
                self.dismiss(animated: true)
            }
            presentPanModal(selectLibraryVC)
        }
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getWhite()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: xmarkButton)
        navigationItem.title = "책"
        
        [ bookImageView, titleLabel, publisherLabel, authorsLabel, confirmButton ]
            .forEach { view.addSubview($0) }
        
        bookImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(24)
            make.width.equalTo(120); make.height.equalTo(174)
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
        titleLabel.text = viewModel.title
        authorsLabel.text = viewModel.author
        publisherLabel.text = viewModel.publisher
        bookImageView.kf.setImage(with: viewModel.image)
    }
}

extension BookDetailViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(400)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(400)
    }
}
