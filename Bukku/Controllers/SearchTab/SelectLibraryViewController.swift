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
    var dismissCompletion: ((LibraryType) -> Void)?
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "서재함을 선택해주세요"
        label.textColor = .getDarkGreen()
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        
        return label
    }()
    
    lazy var readingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("읽는 중이에요", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .semibold)
        button.setTitleColor(UIColor.getDarkGreen(), for: .normal)
        button.addTarget(self, action: #selector(didTapReadingButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var willReadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("읽을 예정이에요", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .semibold)
        button.setTitleColor(UIColor.getDarkGreen(), for: .normal)
        button.addTarget(self, action: #selector(didTapWillReadButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var doneReadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("읽은 책이에요", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .semibold)
        button.setTitleColor(UIColor.getDarkGreen(), for: .normal)
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
        dismissCompletion?(.reading)
    }
    
    @objc func didTapWillReadButton() {
        dismiss(animated: true)
        dismissCompletion?(.willRead)
    }

    @objc func didTapDoneReadButton() {
        dismiss(animated: true)
        dismissCompletion?(.doneRead)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getWhite()
        
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

