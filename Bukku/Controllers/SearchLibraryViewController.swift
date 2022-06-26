//
//  SearchLibraryViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/24.
//

import UIKit
import SnapKit

class SearchLibraryViewController: UIViewController {
    // MARK: - Properties
    var hiddenCompletion: (() -> Void)?
    let viewModel = SearchLibraryViewModel()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        searchBar.placeholder = "책 이름을 입력해주세요."
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        
        return searchBar
    }()
    
    lazy var backArrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .getDarkGreen()
        button.addTarget(self, action: #selector(didTapBackArrowButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .getWhite()
        collectionView.register(LibraryCollectionViewCell.self, forCellWithReuseIdentifier: LibraryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        searchBar.searchTextField.text = ""
    }
    
    // MARK: - Selectors
    @objc private func didTapBackArrowButton() {
        dismiss(animated: true)
        viewModel.result = []
    }
    
    @objc private func didTapBackground() {
        searchBar.searchTextField.resignFirstResponder()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getWhite()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationItem.title = "내 서재 검색"
        view.addSubview(collectionView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
        tapGesture.cancelsTouchesInView = false
        
        collectionView.addGestureRecognizer(tapGesture)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SearchLibraryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.searchTitle(text)
        collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
}

extension SearchLibraryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.identifier, for: indexPath) as? LibraryCollectionViewCell else { return UICollectionViewCell() }
        cell.configureImage(viewModel.result[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
}

extension SearchLibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let libraryDetailVC = LibraryDetailViewController(viewModel.result[indexPath.row])
        self.navigationController?.pushViewController(libraryDetailVC, animated: true)
        viewModel.result = []
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 64) / 3
        return CGSize(width: width, height: (43 / 30) * width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
