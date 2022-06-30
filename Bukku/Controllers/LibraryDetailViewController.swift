//
//  LibraryDetailViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import UIKit
import SnapKit
import PanModal
import Toast
import Kingfisher

enum State {
    case new
    case update
}

class LibraryDetailViewController: UIViewController {
    // MARK: - Properties
    let viewModel: LibraryDetailViewModel
    var bookmarkIndex: Int?
    
    lazy var trashButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .getDarkGreen()
        button.addTarget(self, action: #selector(didTapTrashButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var deleteAlert: UIAlertController = {
        let alert = UIAlertController(title: "정말 삭제하시겠습니까?", message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: { [weak self] _ in
            guard let book = self?.viewModel.book else { return }
            self?.viewModel.removeBook(book)
            self?.dismiss(animated: true)
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        [ deleteAction, cancelAction ].forEach { alert.addAction($0) }
        
        return alert
    }()
    
    lazy var bookmarkDeleteAlert: UIAlertController = {
        let alert = UIAlertController(title: "정말 삭제하시겠습니까?", message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            guard let bookmarkIndex = self.bookmarkIndex else { return }
            self.viewModel.removeBookmark(self.viewModel.book, index: bookmarkIndex)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        [ deleteAction, cancelAction ].forEach { alert.addAction($0) }
        
        return alert
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .getDarkGreen()
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .getDarkGreen()
        tableView.separatorStyle = .none
        tableView.register(BookmarkTableViewCell.self, forCellReuseIdentifier: BookmarkTableViewCell.identifier)
        tableView.register(BookmarkDefaultTableViewCell.self, forCellReuseIdentifier: BookmarkDefaultTableViewCell.identifier)
        
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
    
    init(_ book: LibraryBook) {
        self.viewModel = LibraryDetailViewModel(book)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc private func didTapBackButton() {
        dismiss(animated: true)
    }
    
    @objc private func didTapTrashButton() {
        present(deleteAlert, animated: true)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getDarkGreen()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: trashButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.tintColor = .getDarkGreen()
        navigationItem.title = "도서"
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - TableView DataSource
extension LibraryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkTableViewCell.identifier,  for: indexPath) as? BookmarkTableViewCell,
              let defaultCell = tableView.dequeueReusableCell(withIdentifier: BookmarkDefaultTableViewCell.identifier) as? BookmarkDefaultTableViewCell else { return UITableViewCell() }
        
        cell.pinImageView.isHidden = true
        cell.xmarkCompletion = { [weak self] bookmark in
            guard let self = self else { return }
            self.bookmarkIndex = indexPath.row
            self.present(self.bookmarkDeleteAlert, animated: true)
        }
        
        if viewModel.detailBookmarks.isEmpty {
            defaultCell.configureUI()
            
            defaultCell.addButtonCompletion = { [weak self] in
                guard let self = self else { return }
                let writeBookmarkVC = WriteBookmarkViewController(self.viewModel.book)
                let navVC = UINavigationController(rootViewController: writeBookmarkVC)
                navVC.modalPresentationStyle = .fullScreen
                writeBookmarkVC.saveCompletion = {
                    self.tableView.reloadData()
                }
                self.present(navVC, animated: true)
            }
            
            return defaultCell
        }
        if viewModel.detailBookmarks[indexPath.row].pin == true {
            cell.pinImageView.isHidden = false
        }
        
        cell.configureUI()
        cell.configureData(viewModel.detailBookmarks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.detailBookmarks.isEmpty {
            return 1
        } else {
            return viewModel.numberOfRowsInSection()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if viewModel.bookmarks.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = LibraryDetailHeaderView()
        header.configureUI()
        header.delegate = self
        header.configureData(viewModel.book)
        
        return header
    }
}

// MARK: - TableView Delegate
extension LibraryDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.detailBookmarks.count > 0 else { return }
        let writeBookmarkVC = WriteBookmarkViewController(viewModel.book)
        writeBookmarkVC.configureData(viewModel.detailBookmarks[indexPath.row])
        let navVC = UINavigationController(rootViewController: writeBookmarkVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}

// MARK: - Button Action Delegate
extension LibraryDetailViewController: LibraryDetailHeaderViewDelegate {
    func didTapWriteReviewButton(_ book: LibraryBook) {
        let writeReviewVC = WriteReviewViewController(book)
        let navVC = UINavigationController(rootViewController: writeReviewVC)
        navVC.modalPresentationStyle = .fullScreen
        writeReviewVC.saveCompletion = { [weak self] in
            self?.tableView.reloadData()
        }
        present(navVC, animated: true)
    }
    
    func didTapWriteBookmarkButton(_ book: LibraryBook) {
        let writeBookmarkVC = WriteBookmarkViewController(book)
        let navVC = UINavigationController(rootViewController: writeBookmarkVC)
        navVC.modalPresentationStyle = .fullScreen
        writeBookmarkVC.saveCompletion = { [weak self] in
            self?.tableView.reloadData()
        }
        present(navVC, animated: true)
    }
    
    func didTapChangeLibraryButton(_ book: LibraryBook) {
        let changeLibraryVC = ChangeLibraryViewController(book: book)
        changeLibraryVC.dismissCompletion = { [weak self] in
            self?.view.makeToast("서재함이 변경 되었어요!", duration: 1.0, position: .top, title: nil, image: nil, style: .init(), completion: nil)
        }
        presentPanModal(changeLibraryVC)
    }
    
    func didFinishTouchingCosmos(_ rating: Double) {
        var book = viewModel.book
        book.rating = rating
        viewModel.manager.updateBook(book)
        tableView.reloadData()
    }
}
