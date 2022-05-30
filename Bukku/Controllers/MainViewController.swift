//
//  MainViewController.swift
//  Minimum
//
//  Created by 김응철 on 2022/05/27.
//

import UIKit
import SnapKit
import FSCalendar

class MainViewController: UIViewController {
    let detailView = DetailView()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 38.0, weight: .heavy)
        label.textColor = .systemBackground
        label.text = "당신의 목표는"
        
        return label
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 38.0, weight: .thin)
        label.textColor = .systemBackground
        label.text = "하루에 한 페이지!"
        
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    let changeGoalButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "circle.dashed.inset.filled")
        config.baseForegroundColor = .systemBackground
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration.init(pointSize: 24)
        
        let button = UIButton(configuration: config)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, _ -> NSCollectionLayoutSection in
            return self.createMainSection()
        }
    }
    
    func createMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    // MARK: 오토레이아웃, 색상 설정
    func setupUI() {
        view.backgroundColor = UIColor.init(rgb: 0x538F6A)
        detailView.alpha = 0
        
        [ mainLabel, goalLabel, changeGoalButton, lineView, collectionView ]
            .forEach { view.addSubview($0) }
        
        mainLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        goalLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(changeGoalButton.snp.leading).offset(4)
        }
        
        changeGoalButton.snp.makeConstraints { make in
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
            make.height.equalTo(200)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCollectionViewCell.identifier,
            for: indexPath
        ) as? MainCollectionViewCell else { return UICollectionViewCell() }
        cell.setupUI()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
}
