//
//  FriendsAvatarsCell.swift
//  Diploma
//
//  Created by Ульви Пашаев on 13.07.2023.
//

import UIKit
import TinyConstraints

final class FriendsAvatarsCell: UICollectionViewCell {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(authorImage)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    func setup() {
        layer.borderColor = UIColor.borderUserColor.cgColor
        layer.borderWidth = 2.0
    }
    
    func configure(with avatarImage: UIImage) {
        authorImage.image = avatarImage
    }
    
    private func addConstraints() {
        authorImage.edgesToSuperview(
            insets: UIEdgeInsets(
                top: Constants.AuthorImage.allEdgeOffset,
                left: Constants.AuthorImage.allEdgeOffset,
                bottom: Constants.AuthorImage.allEdgeOffset,
                right: Constants.AuthorImage.allEdgeOffset
            )
        )
    }
    
    // MARK: - Enums
    
    private enum Constants {
        enum AuthorImage {
            static let allEdgeOffset: CGFloat = 4
        }
    }
    
    // MARK: - Properties
    
    // Creating an avatar inside a circle
    private lazy var authorImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = (frame.width - 8) / 2
        return $0
    }(UIImageView())
}
