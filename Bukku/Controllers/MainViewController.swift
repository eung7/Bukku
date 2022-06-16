//
//  MainViewController.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/27.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    // MARK: - Properties
    let viewModel = MainViewModel()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 38.0, weight: .heavy)
        label.textColor = .getBlack()
        label.text = "당신의 목표는"
        
        return label
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 38.0, weight: .thin)
        label.textColor = .getBlack()
        label.text = "하루에 한 페이지!"
        
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        
        return view
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .getBlack()
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration.init(pointSize: 40.0), forImageIn: .normal)
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ReadingCollectionViewCell.self, forCellWithReuseIdentifier: ReadingCollectionViewCell.identifier)
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.identifier)
        collectionView.register(CollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionViewFooter.identifier)
        collectionView.backgroundColor = .getGray()
        collectionView.showsVerticalScrollIndicator = false
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
    @objc func didTapSearchButton() {
        let nav = UINavigationController(rootViewController: SearchViewController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .getGray()
        
        [ mainLabel, goalLabel, searchButton, lineView, collectionView ]
            .forEach { view.addSubview($0) }
        
        mainLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        goalLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(searchButton.snp.leading).offset(4)
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(goalLabel.snp.bottom).offset(24)
            make.height.equalTo(0.5)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, _ -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0:
                return self?.createReadingLayoutSection()
            default:
                return self?.createBasicLayoutSection()
            }
        }
    }
    
    private func createReadingLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0)))
        item.contentInsets = .init(top: 0, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.9)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        let header = createCollectionViewHeader()
        let footer = createCollectionViewFooter()
        section.boundarySupplementaryItems = [ header, footer ]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func createBasicLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(120.0), heightDimension: .absolute(174.0)))
        item.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 4)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(180.0)), subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let header = createCollectionViewHeader()
        let footer = createCollectionViewFooter()
        section.boundarySupplementaryItems = [ header, footer ]
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func createCollectionViewHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        return header
    }
    
    private func createCollectionViewFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(10))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottomLeading)
        
        return footer
    }
}

// MARK: - CollectionView DataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadingCollectionViewCell.identifier, for: indexPath) as? ReadingCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .getBlack()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: CollectionViewHeader.identifier,
                for: indexPath
            ) as? CollectionViewHeader else { return UICollectionReusableView() }
            switch indexPath.section {
            case Section.reading.rawValue:
                header.label.text = viewModel.configureHeaderTitle(.reading)
                return header
            case Section.willRead.rawValue:
                header.label.text = viewModel.configureHeaderTitle(.willRead)
                return header
            case Section.doneRead.rawValue:
                header.label.text = viewModel.configureHeaderTitle(.doneRead)
                return header
            default:
                return UICollectionReusableView()
            }
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: CollectionViewFooter.identifier,
                for: indexPath
            ) as? CollectionViewFooter else { return UICollectionReusableView() }
            return footer
        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
}

// MARK: - CollectionView Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
