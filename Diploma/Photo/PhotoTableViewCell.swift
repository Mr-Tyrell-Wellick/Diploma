//
//  PhotoTableViewCell.swift
//  Diploma
//
//  Created by Ульви Пашаев on 13.07.2023.
//

import UIKit
import TinyConstraints

class PhotoTableViewCell: UITableViewCell {

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    private func addView() {
        contentView.addSubview(collectionView)
        contentView.addSubview(photoLabel)
        contentView.addSubview(arrowImage)
    }

    private func addConstraints() {
        photoLabel.topToSuperview(offset: Constants.PhotoLabel.topToSuperviewOffset)
        photoLabel.leadingToSuperview(offset: Constants.PhotoLabel.leadingToSuperviewOffset)

        arrowImage.centerY(to: photoLabel)
        arrowImage.trailingToSuperview(offset: Constants.ArrowImage.trailingToSuperview)
        arrowImage.height(Constants.ArrowImage.heightOffset)
        arrowImage.width(Constants.ArrowImage.widthOffset)

        collectionView.topToBottom(of: photoLabel, offset: Constants.CollectionView.topTopBottomOffset)
        collectionView.leadingToSuperview()
        collectionView.trailingToSuperview()
        collectionView.bottomToSuperview(offset: Constants.CollectionView.bottomToSuperviewOffset)
    }

    // MARK: - Enums
    private enum Constants {
        enum PhotoLabel {
            static let topToSuperviewOffset: CGFloat = 12
            static let leadingToSuperviewOffset: CGFloat = 12
        }

        enum ArrowImage {
            static let trailingToSuperview: CGFloat = 12
            static let heightOffset: CGFloat = 15
            static let widthOffset: CGFloat = 18
        }

        enum CollectionView {
            static let topTopBottomOffset: CGFloat = 12
            static let bottomToSuperviewOffset: CGFloat = -12
        }
    }

    // MARK: - Properties

    // Horizontal layout
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.minimumInteritemSpacing = 8
        $0.scrollDirection = .horizontal
        $0.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return $0
    }(UICollectionViewFlowLayout())

    // Horizontal collection view
    private lazy var collectionView: UICollectionView = {
        $0.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCellID")
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCellID")

// TODO: - раскоментировать
        //        $0.showsHorizontalScrollIndicator = false
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))

    // Photo header
    private let photoLabel: UILabel = {
        $0.text = Strings.photoLabel.localized
        $0.textColor = .titleColor
        $0.font = .photoHeaderFont
        return $0
    }(UILabel())

    // Arrow
    private lazy var arrowImage: UIImageView = {
        $0.image = .arrowImage
        return $0
    }(UIImageView())

    // Сell size of the first section
    private let itemSizeOfFirstSection = (UIScreen.main.bounds.width - 48)/4
}

    // MARK: - UICollectionViewDataSource

extension PhotoTableViewCell: UICollectionViewDataSource {


    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PhotoCollectionViewCellID", for: indexPath
        ) as? PhotoCollectionViewCell else {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "DefaultCellID", for: indexPath
            )
        }
        cell.layer.cornerRadius = 6
        cell.clipsToBounds = true
        let post = photoPost[indexPath.item]
        cell.configurePhoto(with: post.galleryImage)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotoTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemSizeOfFirstSection, height: itemSizeOfFirstSection)
    }
}
