//
//  PhotoViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 19.07.2023.
//

import RIBs
import UIKit
import TinyConstraints
import RxSwift
import RxGesture

protocol PhotoViewControllerListener: AnyObject {

}

final class PhotoViewController: UIViewController {

    weak var listener: PhotoViewControllerListener?

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        addViews()
        addConstraints()
    }

    // MARK: - Functions

    private func addViews() {
        view.addSubview(verticalCollectionView)
    }

    private func addConstraints() {
        verticalCollectionView.edgesToSuperview()
    }

    private func setupNavBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = Strings.photoGalleryLabel.localized
    }

    // MARK: - Properties

    // Vertical layout
    private lazy var verticalLayout: UICollectionViewLayout = {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 8
        $0.minimumLineSpacing = 8
        $0.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return $0
    }(UICollectionViewFlowLayout())

    // Vertical collection view
    private lazy var verticalCollectionView: UICollectionView = {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCellID")
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCellID")
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: self.verticalLayout))

    // Сell size in PhotoVC
    private let itemSizeOfVC = (UIScreen.main.bounds.width - 32)/3
}

// MARK: - UICollectionViewDataSource

extension PhotoViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PhotoCollectionViewCellID",
            for: indexPath
        ) as? PhotoCollectionViewCell else {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "DefaultCellID",
                for: indexPath
            )
        }
        let post = photoPost[indexPath.item]
        cell.configurePhoto(with: post.galleryImage)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotoViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemSizeOfVC, height: itemSizeOfVC)
    }
}

// MARK: - PhotoPresentable

extension PhotoViewController: PhotoPresentable {

}

// MARK: - PhotoViewContollable

extension PhotoViewController: PhotoViewContollable {
    
}
