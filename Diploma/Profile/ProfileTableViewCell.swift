//
//  ProfileTableViewCell.swift
//  Diploma
//
//  Created by Ульви Пашаев on 13.07.2023.
//

import UIKit
import TinyConstraints

struct ProfilePhotoGalleryViewModel {
    let image: UIImage
}

final class ProfileTableViewCell: UITableViewCell {
    
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
    
    func configure(_ viewModel: [ProfilePhotoGalleryViewModel]) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
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
        collectionView.height(Constants.CollectionView.heightOffset)
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
            static let heightOffset: CGFloat = 75
        }
    }
    
    // MARK: - Properties
    
    // Horizontal layout
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.minimumInteritemSpacing = 8
        $0.scrollDirection = .horizontal
        $0.sectionInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        return $0
    }(UICollectionViewFlowLayout())
    
    // Horizontal collection view
    private lazy var collectionView: UICollectionView = {
        $0.registerCell(PhotoCollectionViewCell.self)
        $0.dataSource = self
        $0.delegate = self
        // TODO: - сделать цвет для фона
        $0.backgroundColor = .photoCollectionBackgroundColor
        $0.showsHorizontalScrollIndicator = false
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

    private var viewModel: [ProfilePhotoGalleryViewModel] = []
}

// MARK: - UICollectionViewDataSource

extension ProfileTableViewCell: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.reusableCell(PhotoCollectionViewCell.self, indexPath: indexPath)
        cell.setup()
        cell.configurePhoto(with: viewModel[indexPath.row].image)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: 70,
            height: 70
        )
    }
}
