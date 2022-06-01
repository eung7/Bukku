//
//  SearchViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/31.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    let viewModel = SearchViewModel()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
                                                  width: UIScreen.main.bounds.width - 75,
                                                  height: 0))
        searchBar.placeholder = "책 이름을 알려주세요!"
        searchBar.returnKeyType = .search
        searchBar.searchTextField.leftView?.tintColor = .getBlack()
        searchBar.delegate = self
        
        return searchBar
    }()
    
    lazy var leftArrowButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .done,
            target: self,
            action: #selector(didTapLeftArrowButton)
        )
        button.tintColor = .getBlack()
        
        return button
    }()
    
    lazy var bookListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .getGray()
        collectionView.register(BookListCell.self, forCellWithReuseIdentifier: BookListCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func didTapLeftArrowButton() {
        self.dismiss(animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .getGray()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationItem.leftBarButtonItem = leftArrowButton
        
        [ bookListCollectionView ]
            .forEach { view.addSubview($0) }
        
        bookListCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - SearchBar Methods
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
        guard let query = searchBar.searchTextField.text else { return }
        SearchService.fetchBooks(query) { [weak self] books in
            self?.viewModel.books = books
            self?.bookListCollectionView.reloadData()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Hi!")
    }
}

// MARK: - BookListCollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookListCell.identifier,
            for: indexPath
        ) as? BookListCell else { return UICollectionViewCell() }
        let book = viewModel.books[indexPath.row]
        cell.bookListVM = BookListViewModel(book: book)
        cell.configureData()
 
        return cell
    }
}

// MARK: - BookListCollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 32) / 3 , height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
