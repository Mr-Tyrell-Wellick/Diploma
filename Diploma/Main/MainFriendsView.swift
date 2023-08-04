//
//  MainFriendsView.swift
//  Diploma
//
//  Created by Ульви Пашаев on 15.07.2023.
//

import UIKit
import TinyConstraints

struct MainFriendsViewViewModel {
    let image: UIImage
}

protocol MainFriendsViewPresentable: UIView {
    func showViewModel(_ viewModel: [MainFriendsViewViewModel])
}

final class MainFriendsView: UIView {
    
    convenience init() {
        self.init(frame: .zero)
        addView()
        addConstraints()
    }
    
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
            FriendsAvatarsCell.self, forCellWithReuseIdentifier: "FriendsAvatarsCellID"
        )
        $0.register(
            UICollectionViewCell.self, forCellWithReuseIdentifier: "HorizontalDefaultCellID"
        )
        return $0
    }(UICollectionView(frame: frame, collectionViewLayout: self.horizontalLayout))
    
    private var viewModel: [MainFriendsViewViewModel] = []
}

extension MainFriendsView: MainFriendsViewPresentable {
    func showViewModel(_ viewModel: [MainFriendsViewViewModel]) {
        self.viewModel = viewModel
        horizontalCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension MainFriendsView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FriendsAvatarsCellID",
            for: indexPath
        ) as? FriendsAvatarsCell else {
            return UICollectionViewCell()
        }
        cell.setup()
        cell.configure(with: viewModel[indexPath.row].image)
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
        UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
}
