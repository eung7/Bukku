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
    // MARK: - Properties
    let book: LibraryBook
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .getBlack()

        return scrollView
    }()
    
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
        view.backgroundColor = .getWhite()
        
        return view
    }()
    
    let lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = .getWhite()
        
        return view
    }()

    let lineView3: UIView = {
        let view = UIView()
        view.backgroundColor = .getWhite()
        
        return view
    }()
    
    let lineView4: UIView = {
        let view = UIView()
        view.backgroundColor = .getWhite()
        
        return view
    }()
    
    let reviewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .semibold)
        label.textColor = .getWhite()
        label.textAlignment = .center
        label.text = "내 서평"
        
        return label
    }()
    
    let bookmarkTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .semibold)
        label.textColor = .getWhite()
        label.textAlignment = .center
        label.text = "내 책갈피"
        
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .medium)
        label.textColor = .getWhite()
        label.numberOfLines = 0
        label.text = "서평을 입력해주세요!"
        label.textAlignment = .center
        
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
    
    lazy var reviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapReviewButton), for: .touchUpInside)
        button.backgroundColor = .getGray()
        button.setTitleColor(UIColor.getBlack(), for: .normal)
        button.setTitle("서평 남기기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .semibold)
        
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.getWhite().cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
    
        return button
    }()
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapBookmarkButton), for: .touchUpInside)
        button.backgroundColor = .getGray()
        button.setTitleColor(UIColor.getBlack(), for: .normal)
        button.setTitle("책갈피 남기기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .semibold)
        
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.getWhite().cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
    
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
    
    lazy var bookmarkCollectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .getBlack()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(LibraryDetailBookmarkCollectionViewCell.self, forCellWithReuseIdentifier: LibraryDetailBookmarkCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureData()
    }
    
    init(_ book: LibraryBook) {
        self.book = book
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
    
    @objc func didTapReviewButton() {

    }
    
    @objc func didTapBookmarkButton() {
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
        
        [ bookImageView, stackView ]
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
        
        view.addSubview(scrollView)
        view.addSubview(lineView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        let buttonStack = UIStackView(arrangedSubviews: [ reviewButton, bookmarkButton ])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 20.0
        buttonStack.distribution = .fillEqually
        
        [ buttonStack, reviewTitleLabel, lineView1, bookmarkTitleLabel, reviewLabel, lineView2, lineView3, lineView4, bookmarkCollectionView ]
            .forEach { scrollView.addSubview($0) }
        
        buttonStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.leading.equalToSuperview().inset(20)
            make.width.equalTo(UIScreen.main.bounds.width - 40)
            make.height.equalTo(50.0)
        }
        
        reviewTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(buttonStack.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        lineView1.snp.makeConstraints { make in
            make.top.equalTo(reviewTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.3)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView1.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(200)
        }

        lineView2.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.3)
        }

        bookmarkTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView2.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        lineView3.snp.makeConstraints { make in
            make.top.equalTo(bookmarkTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.3)
        }
        
        bookmarkCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lineView3.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(220.0)
        }

        lineView4.snp.makeConstraints { make in
            make.top.equalTo(bookmarkCollectionView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.3)
            make.bottom.equalTo(scrollView)
        }
    }
    
    private func configureData() {
        titleLabel.text = book.title
        authorLabel.text = book.authors.first
        publisherLabel.text = book.publisher
        if let url = URL(string: book.thumbnail) {
            bookImageView.kf.setImage(with: url)
        }
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
        section.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 4)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}

// MARK: - BookmarkCollectionView DataSource
extension LibraryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryDetailBookmarkCollectionViewCell.identifier, for: indexPath) as? LibraryDetailBookmarkCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

// MARK: - BookmarkCollectionView DelegateFlowLayout
extension LibraryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
