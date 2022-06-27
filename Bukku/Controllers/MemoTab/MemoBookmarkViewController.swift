//
//  MemoBookmarkViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/25.
//

import UIKit
import SnapKit

class MemoBookmarkViewController: UIViewController {
    // MARK: - Properties
    let viewModel = MemoBookmarkViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .getDarkGreen()
        tableView.separatorStyle = .none
        tableView.register(MemoBookmarkTableViewCell.self, forCellReuseIdentifier: MemoBookmarkTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getWhite()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MemoBookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoBookmarkTableViewCell.identifier, for: indexPath) as? MemoBookmarkTableViewCell else { return UITableViewCell() }
        cell.configureUI()
        let bookmark = viewModel.pinBookmark(indexPath.row)
        cell.configureData(viewModel.bookmarkBooks[indexPath.row], bookmark: bookmark)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = viewModel.bookmarkBooks[indexPath.row]
        let libraryDetailVC = LibraryDetailViewController(book)
        let navVC = UINavigationController(rootViewController: libraryDetailVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}
