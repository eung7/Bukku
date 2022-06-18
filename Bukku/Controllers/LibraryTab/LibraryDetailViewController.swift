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
    // MARK: - Properties
    var selectedBook: LibraryBook
    let width = UIScreen.main.bounds.width
    
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
    
    let reviewLabel: BasePaddingLabel = {
        let label = BasePaddingLabel(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        label.textColor = .getBlack()
        label.numberOfLines = 0
        label.text = "서평을 입력해주세요!"
        label.textAlignment = .center
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
        tableView.estimatedRowHeight = 100
        tableView.separatorColor = .getBlack()
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 25
        tableView.backgroundColor = .getGray()
        tableView.register(LibraryDetailBookmarkCollectionViewCell.self, forCellReuseIdentifier: LibraryDetailBookmarkCollectionViewCell.identifier)
        
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
    }
    
    init(_ book: LibraryBook) {
        self.selectedBook = book
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
        let writeReviewVC = WriteReviewViewController(selectedBook)
        let navVC = UINavigationController(rootViewController: writeReviewVC)
        navVC.modalPresentationStyle = .fullScreen
        writeReviewVC.saveCompletion = { [weak self] updatedBook in
            self?.selectedBook = updatedBook
        }
        present(navVC, animated: true)
    }
    
    @objc func didTapWriteBookmarkButton() {
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
        
        [ bookImageView, stackView, lineView, tableView ]
            .forEach { view.addSubview($0) }
        
        bookImageView.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.width.equalTo((UIScreen.main.bounds.width - 32) / 3)
            make.height.equalTo(180)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(bookImageView)
            make.leading.equalTo(bookImageView.snp.trailing).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        [ reviewTitleLabel, lineView1, writeReviewButton, reviewLabel, lineView2, bookmarkTitleLabel, lineView3, writeBookmarkButton, lineView4 ]
            .forEach { headerView.addSubview($0) }
        
        reviewTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        lineView1.snp.makeConstraints { make in
            make.top.equalTo(reviewTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(0.5)
        }
        
        writeReviewButton.snp.makeConstraints { make in
            make.bottom.equalTo(lineView1.snp.top).offset(-8)
            make.trailing.equalToSuperview().inset(16)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView1.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(200)
            make.height.lessThanOrEqualTo(500)
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
        titleLabel.text = selectedBook.title
        authorLabel.text = selectedBook.authors.first
        publisherLabel.text = selectedBook.publisher
        if let review = selectedBook.review { reviewLabel.text = review }
        if let url = URL(string: selectedBook.thumbnail) { bookImageView.kf.setImage(with: url) }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, _ -> NSCollectionLayoutSection? in
            return self?.createBookmarkCollectionLayout()
        }
    }
    
    private func createBookmarkCollectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50)))
        item.contentInsets = .init(top: 0, leading: 5, bottom: 10, trailing: 5)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(220.0)), subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 4, leading: 4, bottom: 0, trailing: 4)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}

// MARK: - TableView DataSource
extension LibraryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LibraryDetailBookmarkCollectionViewCell.identifier, for: indexPath) as? LibraryDetailBookmarkCollectionViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}

// MARK: - TableView Delegate
extension LibraryDetailViewController: UITableViewDelegate {
    
}
