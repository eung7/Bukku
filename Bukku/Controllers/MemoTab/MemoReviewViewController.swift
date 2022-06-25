//
//  MemoReviewViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/25.
//

import UIKit
import SnapKit

class MemoReviewViewController: UIViewController {
    let viewModel = MemoReviewViewModel()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .getWhite()
        tableView.separatorStyle = .none
        tableView.register(MemoReviewTableViewCell.self, forCellReuseIdentifier: MemoReviewTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    
        return tableView
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .getDarkGreen()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        
        return button
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
    
    // MARK: - Selectors
    @objc func didTapSearchButton() {
        
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

// MARK: - collectionView Delegate
extension MemoReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoReviewTableViewCell.identifier, for: indexPath) as? MemoReviewTableViewCell else { return UITableViewCell() }
        cell.configureUI()
        cell.configureData(viewModel.reviewBooks[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

