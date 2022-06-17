//
//  SelectLibraryViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/17.
//

import UIKit
import SnapKit
import PanModal

class SelectLibraryViewController: UIViewController {
    // MARK: - Properties
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "서재함을 선택해주세요"
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    lazy var readingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("읽는 중이에요", for: .normal)
        button.setTitleColor(UIColor.getBlack(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .thin)
        button.addTarget(self, action: #selector(didTapReadingButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var willReadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("읽을 예정이에요", for: .normal)
        button.setTitleColor(UIColor.getBlack(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .thin)
        button.addTarget(self, action: #selector(didTapWillReadButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var doneReadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("읽은 책이에요", for: .normal)
        button.setTitleColor(UIColor.getBlack(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .thin)
        button.addTarget(self, action: #selector(didTapDoneReadButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func didTapReadingButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapWillReadButton() {
        dismiss(animated: true)
    }

    @objc func didTapDoneReadButton() {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getGray()
        
        [ mainLabel, readingButton, willReadButton, doneReadButton ]
            .forEach { view.addSubview($0) }
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(16)
        }
        
        readingButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(16)
        }
        
        willReadButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(readingButton.snp.bottom).offset(16)
        }
        
        doneReadButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(willReadButton.snp.bottom).offset(16)
        }
    }
}

extension SelectLibraryViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(200)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(200)
    }
}
