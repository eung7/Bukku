//
//  SettingViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/26.
//

import UIKit
import SnapKit
import MessageUI

class SettingViewController: UIViewController {
    // MARK: - Properties
    let viewModel = SettingViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.backgroundColor = .getWhite()
        tableView.allowsFocus = false
        
        return tableView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .getDarkGreen()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc private func didTapBackButton() {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getWhite()
        navigationItem.title = "설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "메일을 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) {
            (action) in
        }
        sendMailErrorAlert.addAction(confirmAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        cell.configureUI()
        cell.selectionStyle = .none
        cell.configureData(viewModel.list[indexPath.row], results: viewModel.results[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            if MFMailComposeViewController.canSendMail() {
                let mailVC = MFMailComposeViewController()
                mailVC.mailComposeDelegate = self
                
                mailVC.setToRecipients(["bukku.dev@gmail.com"])
                mailVC.setSubject("부끄 앱 문의")
                mailVC.setMessageBody("문의 내용을 입력해주세요.", isHTML: false)
                
                self.present(mailVC, animated: true)
            } else {
                self.showSendMailErrorAlert()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
