//
//  AddBookViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/23.
//

import UIKit
import SnapKit
import JVFloatLabeledTextField
import Photos
import PhotosUI
import Toast
import PanModal

class AddBookViewController: UIViewController {
    // MARK: - Properties
    let viewModel = AddBookViewModel()
    
    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .getWhite()
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.getDarkGreen().cgColor
        iv.layer.shadowOpacity = 0.5
        iv.layer.shadowOffset = CGSize(width: 0, height: 0)
        iv.layer.shadowColor = UIColor.getDarkGreen().cgColor
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let titleTextField: JVFloatLabeledTextField = {
        let tf = JVFloatLabeledTextField()
        tf.placeholderColor = UIColor.getDarkGreen()
        tf.addLeftPadding()
        tf.floatingLabelYPadding = 5
        tf.floatingLabelActiveTextColor = UIColor.getDarkGreen()
        tf.textColor = .getDarkGreen()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.placeholder = "책 제목을 입력해주세요."
        
        return tf
    }()
    
    let authorTextField: JVFloatLabeledTextField = {
        let tf = JVFloatLabeledTextField()
        tf.placeholderColor = UIColor.getDarkGreen()
        tf.addLeftPadding()
        tf.floatingLabelYPadding = 5
        tf.floatingLabelActiveTextColor = UIColor.getDarkGreen()
        tf.textColor = .getDarkGreen()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.placeholder = "저자를 입력해주세요."
        
        return tf
    }()
    
    lazy var xmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .getDarkGreen()
        button.addTarget(self, action: #selector(didTapXmarkButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .getDarkGreen()
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = .getDarkGreen()
        button.addTarget(self, action: #selector(didTapCameraButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc private func didTapXmarkButton() {
        dismiss(animated: true)
    }
    
    @objc private func didTapPlusButton() {
        guard titleTextField.text != "",
              authorTextField.text != "",
              let title = titleTextField.text,
              let author = authorTextField.text,
              let image = bookImageView.image else {
            view.makeToast("빈 곳을 채워주세요.", duration: 1.0, position: .top, title: nil, image: nil, style: .init(), completion: nil)
            return
        }
        let selectLibraryVC = SelectLibraryViewController()
        selectLibraryVC.dismissCompletion = { [weak self] type in
            self?.viewModel.createBook(type: type, title: title, author: author, image: image)
            self?.dismiss(animated: true)
        }
        presentPanModal(selectLibraryVC)
    }
    
    @objc private func didTapCameraButton() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = .images
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true)
    }
    
    // MARK: - Helpers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func configureUI() {
        view.backgroundColor = .getWhite()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: xmarkButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        navigationItem.title = "도서 추가"
        
        [ bookImageView, titleTextField, authorTextField, cameraButton ]
            .forEach { view.addSubview($0) }
        
        bookImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(120)
            make.height.equalTo(174)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        authorTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.leading.equalTo(bookImageView.snp.trailing).offset(4)
            make.bottom.equalTo(bookImageView.snp.bottom)
        }
    }
}

extension AddBookViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let image = image as? UIImage, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.bookImageView.image = image
                }
            }
        }
    }
}
