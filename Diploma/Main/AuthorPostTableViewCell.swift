//
//  AuthorPostTableViewCell.swift
//  Diploma
//
//  Created by Ульви Пашаев on 14.07.2023.
//

import UIKit
import TinyConstraints

struct FriendsPostViewModel {
    let myHeaderPosts: String?
    let author: String?
    let description: String
    let postImage: UIImage
    let avatarImage: UIImage?
    let postId: Int
}

final class AuthorPostTableCell: UITableViewCell {
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    private func addContentView() {
        contentView.addSubview(authorName)
        contentView.addSubview(authorImage)
        contentView.addSubview(descriptionText)
        contentView.addSubview(postImage)
        contentView.addSubview(favoriteButton)
    }

    private func addConstraints() {
        authorImage.topToSuperview(offset: Constants.AuthorImage.topToSuperViewOffset)
        authorImage.leadingToSuperview(offset: Constants.AuthorImage.leadingToSuperviewOffset)
        authorImage.height(Constants.AuthorImage.heightAndWidthOfsset)
        authorImage.width(Constants.AuthorImage.heightAndWidthOfsset)

        authorName.topToBottom(of: authorImage, offset: Constants.AuthorName.topToBottomOffset)
        authorName.centerX(to: authorImage)
        authorName.height(Constants.AuthorName.heightOffset)

        postImage.topToBottom(of: authorName, offset: Constants.PostImage.topToBottomOffset)
        postImage.leadingToSuperview()
        postImage.trailingToSuperview()
        postImage.height(UIScreen.main.bounds.width / 2)

        descriptionText.topToBottom(of: postImage, offset: Constants.DescriptionText.topToBottomOffset)
        descriptionText.leadingToSuperview(offset: Constants.DescriptionText.leadingAndTrailingToSuperViewOffset)
        descriptionText.trailingToSuperview(offset: Constants.DescriptionText.leadingAndTrailingToSuperViewOffset)

        favoriteButton.topToBottom(of: descriptionText, offset: 5)
        favoriteButton.centerX(to: descriptionText)
        favoriteButton.bottom(to: contentView, offset: -10)
    }

    // MARK: - Enums

    private enum Constants {
        enum AuthorImage {
            static let topToSuperViewOffset: CGFloat = 16
            static let leadingToSuperviewOffset: CGFloat = 16
            static let heightAndWidthOfsset: CGFloat = 80
        }

        enum AuthorName {
            static let topToBottomOffset: CGFloat = 5
            static let heightOffset: CGFloat = 19
        }

        enum PostImage {
            static let topToBottomOffset: CGFloat = 20
        }

        enum DescriptionText {
            static let topToBottomOffset: CGFloat = 16
            static let leadingAndTrailingToSuperViewOffset: CGFloat = 16
            static let bottomOfsset: CGFloat = -16
        }
    }

    override func prepareForReuse() {
        authorName.text = nil
        authorImage.image = nil
        postImage.image = nil
        descriptionText.text = nil
    }

    func setupPosts(with authorPosts: FriendsPostViewModel) {
        authorName.text = authorPosts.author
        authorImage.image = authorPosts.avatarImage
        postImage.image = authorPosts.postImage
        descriptionText.text = authorPosts.description
    }

    // MARK: - Properties

    // Author name
    private lazy var authorName: UILabel = {
        $0.textColor = .titleColor
        $0.font = .authorHeaderFont
        return $0
    }(UILabel())

    // Avatar that will be displayed to the left of the user’s name in the header
    private lazy var authorImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40
        return $0
    }(UIImageView())

    // Post Image
    private lazy var postImage: UIImageView = {
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .textFieldTextColor
        return $0
    }(UIImageView())

    // Author post
    private lazy var descriptionText: UILabel = {
        $0.textColor = .titleColor
        $0.font = .descriptionTextFont
        $0.textAlignment = .natural
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    // TODO: - дописать кнопку с лайком, при нажатии на которую будет сохраняться в (CoreData)
    
        // Add posts to favorite screen
    private lazy var favoriteButton: UIButton = {
        // TODO: - пока что так, чуть позднее если что переделать
        $0.setImage(.heartImage, for: .normal)
        return $0
    }(UIButton())


    // TODO: - если что добавить функционал на postTap() {
    //    guard let postId = postId else { return }
    //    delegate?.didDoubleTapToPost(posstId: postId)

}
