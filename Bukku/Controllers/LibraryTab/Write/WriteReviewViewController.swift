//
//  WriteReviewViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import UIKit
import SnapKit
import Toast
import RSKPlaceholderTextView

class WriteReviewViewController: UIViewController {
    // MARK: - Properties
    let viewModel: WriteReviewViewModel
    var saveCompletion: (() -> Void)?
    
    lazy var textView: RSKPlaceholderTextView = {
        let textView = RSKPlaceholderTextView()
        textView.placeholder = "서평을 입력해주세요."
        textView.delegate = self
        textView.font = .systemFont(ofSize: 18.0, weight: .thin)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.backgroundColor = .getWhite()
        textView.textColor = .getDarkGreen()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.getDarkGreen().cgColor
        textView.layer.cornerRadius = 10
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowColor = UIColor.getDarkGreen().cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        return textView
    }()
    
    lazy var backArrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .getDarkGreen()
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .semibold)
        button.tintColor = .getDarkGreen()
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        
        return button
    }()
    
    let contentsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getDarkGreen()
        
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureData()
    }
    
    init(_ book: LibraryBook) {
        self.viewModel = WriteReviewViewModel(book)
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
        if textView.text != "" {
            viewModel.updateReview(textView.text)
            dismiss(animated: true)
        }
        view.makeToast("빈 곳을 입력해주세요.", duration: 1.0, position: .top, title: nil, image: nil, style: .init(), completion: nil)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getWhite()
        
        navigationItem.title = "서평 남기기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backArrowButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        
        view.addSubview(textView); view.addSubview(contentsCountLabel)
        
        textView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(300)
        }
        
        contentsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func configureData() {
        guard let review = viewModel.review else { return }
        textView.text = review
    }
}

extension WriteReviewViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        contentsCountLabel.text = "\(changedText.count)/1000"
        return changedText.count <= 999
    }
}
