//
//  WriteReviewViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import UIKit
import SnapKit
import RSKPlaceholderTextView

class WriteReviewViewController: UIViewController {
    // MARK: - Properties
    var book: LibraryBook
    let manager = LibraryManager.shared
    var saveCompletion: ((LibraryBook) -> Void)?
    
    let textView: RSKPlaceholderTextView = {
        let textView = RSKPlaceholderTextView()
        textView.placeholder = "서평을 입력해주세요."
        textView.font = .systemFont(ofSize: 18.0, weight: .thin)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.getBlack().cgColor
        textView.layer.cornerRadius = 10
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowColor = UIColor.getBlack().cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        return textView
    }()
    
    lazy var backArrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .getBlack()
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .semibold)
        button.tintColor = .getBlack()
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureData()
    }
    
    init(_ book: LibraryBook) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func didTapBackButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapSaveButton() {
        book.review = textView.text
        manager.updateBook(book)
        saveCompletion?(book)
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getGray()
        
        navigationItem.title = "서평 남기기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backArrowButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        
        view.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(400)
        }
    }

    private func configureData() {
        guard let review = book.review else { return }
        textView.text = review
    }
}
