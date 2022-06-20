//
//  LibraryDetailViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/18.
//

import UIKit
import SnapKit
import Kingfisher

class LibraryDetailViewController: UIViewController {
    // MARK: - States
    let index: Int
    
    // MARK: - Properties
    let manager = LibraryManager.shared
    var viewModel: LibraryDetailViewModel!

    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .getBlack()
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.getBlack().cgColor
        iv.layer.shadowOffset = CGSize(width: 0, height: 0)
        iv.layer.shadowOpacity = 0.5
        iv.layer.shadowColor = UIColor.getBlack().cgColor
        
        return iv
    }()
    
    let headerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .getBlack()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32.0, weight: .heavy)
        
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getBlack()
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        label.textAlignment = .center
        
        return label
    }()
    
    let publisherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getBlack()
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        label.textAlignment = .center
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
        label.textAlignment = .left
        label.text = "내 책갈피"
        
        return label
    }()
    
    lazy var reviewLabel: BasePaddingLabel = {
        let label = BasePaddingLabel(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        label.textColor = .getBlack()
        label.numberOfLines = 0
        label.text = "서평을 입력해주세요!"
        label.textAlignment = .center
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
    
    lazy var changeLibraryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("서재함 옮기기", for: .normal)
        button.setTitleColor(UIColor.getBlack(), for: .normal)
        button.addTarget(self, action: #selector(didTapChangeLibraryButton), for: .touchUpInside)
        button.backgroundColor = .getGray()
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .medium)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        
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
        tableView.backgroundColor = .getGray()
        tableView.separatorStyle = .none
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
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapTrashButton() {
        present(deleteAlert, animated: true)
    }
    
    @objc func didTapWriteReviewButton() {
        let writeReviewVC = WriteReviewViewController(viewModel.book)
        let navVC = UINavigationController(rootViewController: writeReviewVC)
        navVC.modalPresentationStyle = .fullScreen
        writeReviewVC.saveCompletion = { [weak self] updatedBook in
            self?.viewModel.book = updatedBook
        }
        present(navVC, animated: true)
    }
    
    @objc func didTapWriteBookmarkButton() {
        let writeBookmarkVC = WriteBookmarkViewController(viewModel.book)
        let navVC = UINavigationController(rootViewController: writeBookmarkVC)
        navVC.modalPresentationStyle = .fullScreen
        writeBookmarkVC.saveCompletion = { [weak self] updatedBook in
            self?.viewModel.book = updatedBook
        }
        present(navVC, animated: true)
    }
    
    @objc func didTapChangeLibraryButton() {
        
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getGray()
        navigationItem.backButtonTitle = "서재"
        navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: trashButton)
        navigationController?.navigationBar.tintColor = .getBlack()
        navigationItem.title = "도서"
        
        let stackView = UIStackView(arrangedSubviews: [ titleLabel, authorLabel, publisherLabel ])
        stackView.axis = .vertical
        stackView.spacing = 4.0
        stackView.alignment = .center
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        [ bookImageView, stackView, changeLibraryButton, lineView, reviewTitleLabel, writeReviewButton, reviewLabel, lineView2, bookmarkTitleLabel, lineView3, writeBookmarkButton, lineView4 ]
            .forEach { headerView.addSubview($0) }
        
        bookImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(8)
            make.width.equalTo((UIScreen.main.bounds.width - 32) / 3)
            make.height.equalTo(Utilties.getHeightFromWidth(UIScreen.main.bounds.width - 32) / 3)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        changeLibraryButton.snp.makeConstraints { make in
            make.bottom.equalTo(lineView.snp.top).offset(-8)
            make.leading.equalTo(bookImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(bookImageView)
            make.leading.equalTo(bookImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(4)
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
        
        writeBookmarkButton.snp.makeConstraints { make in
            make.centerY.equalTo(bookmarkTitleLabel)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func configureData() {
        let book = manager.getBookFromIndex(index)
        self.viewModel = LibraryDetailViewModel(book)
        
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
        
        if viewModel.bookmarks.isEmpty == false {
            cell.configureData(viewModel.bookmarks[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.bookmarks.count > 0 {
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
