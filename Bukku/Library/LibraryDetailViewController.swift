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
//    let book: LibraryBook
    
    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .getBlack()
        
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Swift!!!!!!"
        
        return label
    }()
    
    let bookStateLabel: UILabel = {
        let label = UILabel()
        label.text = "읽고 있는 책이에요."
        
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .getBlack()
        
        return button
    }()
    
    let trashButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .getBlack()
        
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureData()
    }
    
//    init(_ book: LibraryBook) {
//        self.book = book
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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

        
        [ bookImageView, titleLabel, bookStateLabel ]
            .forEach { view.addSubview($0) }
    }
    
    private func configureData() {
        
    }
}
