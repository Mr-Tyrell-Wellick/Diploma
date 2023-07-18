//
//  MainFriendsView.swift
//  Diploma
//
//  Created by Ульви Пашаев on 15.07.2023.
//

import UIKit
import TinyConstraints

protocol MainFriendsViewListener: AnyObject {
    
}

protocol MainFriendsViewPresentable: UIView {
    
}

class MainFriendsView: UIView, MainFriendsViewPresentable {
    
    convenience init() {
        self.init(frame: .zero)
        addView()
        addConstraints()
    }
    
    weak var listener: MainFriendsViewListener?
    
    // MARK: - Functions
    
    private func addView() {
        addSubview(horizontalCollectionView)
        
    }
    
    private func addConstraints() {
        
        horizontalCollectionView.edgesToSuperview()
    }
    
    // MARK: - Properties
    
    
    // Horizontal layout
    private lazy var horizontalLayout: UICollectionViewLayout = {
        $0.scrollDirection = .horizontal
        return $0
    }(UICollectionViewFlowLayout())
    
    // Horizontal collection view
    private lazy var horizontalCollectionView: UICollectionView = {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(
            MainCell.self, forCellWithReuseIdentifier: "MainCellID"
        )
        $0.register(
            UICollectionViewCell.self, forCellWithReuseIdentifier: "HorizontalDefaultCellID"
        )
        return $0
    }(UICollectionView(frame: frame, collectionViewLayout: self.horizontalLayout))
}


// MARK: - UICollectionViewDataSource

extension MainFriendsView: UICollectionViewDataSource {
    
    
    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        return posts.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MainCellID",
            for: indexPath
        ) as? MainCell else {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "HorizontalDefaultCellID",
                for: indexPath
            )
        }
        cell.setup()
        let post = posts[indexPath.item]
        cell.configure(with: post.avatarImage)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainFriendsView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 74, height: 74)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
