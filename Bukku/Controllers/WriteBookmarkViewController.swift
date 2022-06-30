//
//  WriteBookmarkViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/19.
//

import UIKit
import SnapKit
import JVFloatLabeledTextField
import RSKPlaceholderTextView
import Toast

class WriteBookmarkViewController: UIViewController {
    // MARK: - Properties
    let viewModel: WriteBookmarkViewModel
    var saveCompletion: (() -> Void)?
    var state: State = .new
    var bookmark: Bookmark?
    
    lazy var pageTextField: JVFloatLabeledTextField = {
        let tf = JVFloatLabeledTextField()
        tf.placeholder = "Page:"
        tf.placeholderColor = .getDarkGreen()
        tf.floatingLabelActiveTextColor = .getDarkGreen()
        tf.textColor = .getDarkGreen()
        tf.keyboardType = .numberPad
        tf.textAlignment = .left
        tf.delegate = self
        
        return tf
    }()
    
    lazy var contentsTextView: RSKPlaceholderTextView = {
        let textView = RSKPlaceholderTextView()
        textView.placeholder = "내용을 입력해주세요."
        textView.delegate = self
        textView.backgroundColor = .getWhite()
        textView.textColor = .getDarkGreen()
        textView.font = .systemFont(ofSize: 18.0, weight: .semibold)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.getDarkGreen().cgColor
        textView.layer.cornerRadius = 10
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowColor = UIColor.getDarkGreen().cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        return textView
    }()
    
    lazy var leftArrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .getDarkGreen()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(didTapLeftArrowButton), for: .touchUpInside)
       
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .semibold)
        button.tintColor = .getDarkGreen()
        button.setTitle("저장", for: .normal)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var pinButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.imagePadding = 5
        let button = UIButton(configuration: config)
        button.setTitle("이 책갈피 고정", for: .normal)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        button.tintColor = .getDarkGreen()
        button.backgroundColor = .getWhite()
        button.addTarget(self, action: #selector(didTapPinButton), for: .touchUpInside)
        
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
    }
    
    init(_ book: LibraryBook) {
        self.viewModel = WriteBookmarkViewModel(book)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func didTapLeftArrowButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapSaveButton() {
        guard let contents = contentsTextView.text,
              contents != "" else {
            view.makeToast("내용을 입력해주세요.", duration: 1, position: .top, title: nil, image: nil, style: .init(), completion: nil)
            return
        }
        
        switch state {
        case .new:
            if pinButton.isSelected {
                viewModel.createBookmark(pageTextField.text ?? "", contents: contents, pin: true)
                saveCompletion?()
            } else {
                viewModel.createBookmark(pageTextField.text ?? "", contents: contents, pin: false)
                saveCompletion?()
            }
            dismiss(animated: true)
        case .update:
            guard let bookmark = bookmark else { return }
            if pinButton.isSelected {
                viewModel.updateBookmark(pageTextField.text ?? "", contents: contents, bookmark: bookmark, pin: true)
            } else {
                viewModel.updateBookmark(pageTextField.text ?? "", contents: contents, bookmark: bookmark, pin: false)
            }
            dismiss(animated: true)
        }
    }
    
    @objc private func didTapPinButton() {
        pinButton.isSelected = !pinButton.isSelected
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getWhite()
        navigationItem.title = "책갈피 남기기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftArrowButton)
        navigationController?.navigationBar.barTintColor = .getDarkGreen()
        navigationController?.navigationBar.tintColor = .getDarkGreen()
        
        [ pageTextField, contentsTextView, contentsCountLabel, pinButton ]
            .forEach { view.addSubview($0) }
        
        pageTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(100)
        }
        
        contentsTextView.snp.makeConstraints { make in
            make.top.equalTo(pageTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        contentsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(contentsTextView.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(20)
        }
        
        pinButton.snp.makeConstraints { make in
            make.centerY.equalTo(pageTextField)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configureData(_ bookmark: Bookmark) {
        self.state = .update
        self.bookmark = bookmark
        contentsTextView.text = bookmark.contents
        pageTextField.text = bookmark.page
        pinButton.isSelected = bookmark.pin
    }
}

extension WriteBookmarkViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        contentsCountLabel.text = "\(changedText.count)/500"
        return changedText.count <= 499
    }
}

extension WriteBookmarkViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: string)
        return changedText.count <= 4
    }
}

