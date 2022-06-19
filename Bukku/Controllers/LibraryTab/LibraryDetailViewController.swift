//
//  LibraryDetailViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import UIKit
import SnapKit
import Kingfisher
import SystemConfiguration

class LibraryDetailViewController: UIViewController {
    // MARK: - States
    let index: Int
    var currentBook: LibraryBook?
    let width = UIScreen.main.bounds.width
    
    // MARK: - Properties
    let manager = LibraryManager.shared
    let viewModel = LibraryDetailViewModel()
    
    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .getBlack()
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.getBlack().cgColor
        iv.layer.cornerRadius = 10
        iv.layer.shadowOffset = CGSize(width: 0, height: 0)
        iv.layer.shadowOpacity = 0.5
        iv.layer.shadowColor = UIColor.getBlack().cgColor
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    let headerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 34.0, weight: .semibold)
        
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        
        return label
    }()
    
    let publisherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        label.textColor = .gray
        
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .getBlack()
        
        return view
    }()
    
    let lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = .getBlack()
        
        return view
    }()
    
    let lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = .getBlack()
        
        return view
    }()

    let lineView3: UIView = {
        let view = UIView()
        view.backgroundColor = .getBlack()
        
        return view
    }()
    
    let lineView4: UIView = {
        let view = UIView()
        view.backgroundColor = .getBlack()
        
        return view
    }()
    
    let reviewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .semibold)
        label.textColor = .getBlack()
        label.textAlignment = .center
        label.text = "내 서평"
        
        return label
    }()
    
    let bookmarkTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .semibold)
        label.textColor = .getBlack()
        label.textAlignment = .center
        label.text = "내 책갈피"
        
        return label
    }()
    
    lazy var reviewLabel: BasePaddingLabel = {
        let label = BasePaddingLabel(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        label.textColor = .getBlack()
        label.numberOfLines = 0
        label.text = "서평을 입력해주세요!"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .getWhite()
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.getBlack().cgColor
        label.layer.shadowOpacity = 0.5
        label.layer.shadowColor = UIColor.getBlack().cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.masksToBounds = true
        
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .getBlack()
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var trashButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .getBlack()
        button.addTarget(self, action: #selector(didTapTrashButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var writeReviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapWriteReviewButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration.init(pointSize: 30.0), forImageIn: .normal)
        button.tintColor = .getBlack()
        
        return button
    }()
    
    lazy var writeBookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapWriteBookmarkButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration.init(pointSize: 30.0), forImageIn: .normal)
        button.tintColor = .getBlack()
        
        return button
    }()
    
    lazy var deleteAlert: UIAlertController = {
        let alert = UIAlertController(title: "주의", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            // TODO: [] 삭제 버튼 시 삭제하기
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        [ deleteAction, cancelAction ].forEach { alert.addAction($0) }
        
        return alert
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100
        tableView.estimatedRowHeight = 100
        tableView.separatorColor = .getBlack()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .getGray()
        tableView.register(BookmarkTableViewCell.self, forCellReuseIdentifier: BookmarkTableViewCell.identifier)
        
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureData()
        tableView.reloadData()
    }
    
    init(_ index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func didTapBackButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapTrashButton() {
        present(deleteAlert, animated: true)
    }
    
    @objc func didTapWriteReviewButton() {
        if let currentBook = currentBook {
            let writeReviewVC = WriteReviewViewController(currentBook)
            let navVC = UINavigationController(rootViewController: writeReviewVC)
            navVC.modalPresentationStyle = .fullScreen
            writeReviewVC.saveCompletion = { [weak self] updatedBook in
                self?.currentBook = updatedBook
            }
            present(navVC, animated: true)
        }
    }
    
    @objc func didTapWriteBookmarkButton() {
        if let currentBook = currentBook {
            let writeBookmarkVC = WriteBookmarkViewController(currentBook)
            let navVC = UINavigationController(rootViewController: writeBookmarkVC)
            navVC.modalPresentationStyle = .fullScreen
            writeBookmarkVC.saveCompletion = { [weak self] updatedBook in
                self?.currentBook = updatedBook
            }
            present(navVC, animated: true)
        }
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getGray()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: trashButton)
        navigationItem.title = "도서"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.getBlack()]
        appearance.backgroundColor = .getGray()
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        let stackView = UIStackView(arrangedSubviews: [ titleLabel, authorLabel, publisherLabel ])
        stackView.axis = .vertical
        stackView.spacing = 4.0
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        [ bookImageView, stackView, lineView, reviewTitleLabel, writeReviewButton, reviewLabel, lineView2, bookmarkTitleLabel, lineView3, writeBookmarkButton, lineView4 ]
            .forEach { headerView.addSubview($0) }
        
        bookImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(8)
            make.width.equalTo((UIScreen.main.bounds.width - 32) / 3)
            make.height.equalTo(180)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(bookImageView)
            make.leading.equalTo(bookImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        reviewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(30.0)
        }
        
        writeReviewButton.snp.makeConstraints { make in
            make.centerY.equalTo(reviewTitleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        bookmarkTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        lineView4.snp.makeConstraints { make in
            make.top.equalTo(bookmarkTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(0.5)
        }
        
        writeBookmarkButton.snp.makeConstraints { make in
            make.centerY.equalTo(bookmarkTitleLabel)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func configureData() {
        let book = manager.getBookFromIndex(index)
        currentBook = book
        viewModel.bookmarks = book.bookmark
        
        titleLabel.text = book.title
        authorLabel.text = book.authors.first
        publisherLabel.text = book.publisher
        if let review = book.review {
            reviewLabel.text = review
        }
        if let url = URL(string: book.thumbnail) {
            bookImageView.kf.setImage(with: url)
        }
    }
}

// MARK: - TableView DataSource
extension LibraryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkTableViewCell.identifier, for: indexPath) as? BookmarkTableViewCell else { return UITableViewCell() }
        if let book = currentBook {
            cell.configureData(book.bookmark[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentBook?.bookmark.count > 0 {
            return viewModel.numberOfRowsInSection()
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}

// MARK: - TableView Delegate
extension LibraryDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
