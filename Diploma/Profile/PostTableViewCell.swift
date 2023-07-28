//
//  PostTableViewCell.swift
//  Diploma
//
//  Created by Ульви Пашаев on 18.07.2023.
//

import UIKit
import TinyConstraints

struct PostViewModel {
    let postTitle: String?
    let author: String?
    let description: String
    let postImage: UIImage
    let avatarImage: UIImage?
    let postId: Int
}

final class PostTableViewCell: UITableViewCell {

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
        contentView.addSubview(headerPost)
        contentView.addSubview(myPostImage)
        contentView.addSubview(myDescriptionText)
    }

    private func addConstraints() {
        headerPost.topToSuperview(offset: Constants.HeaderPost.leadingToSuperViewOffset)
        headerPost.leadingToSuperview(offset: Constants.HeaderPost.leadingToSuperViewOffset)
        headerPost.height(Constants.HeaderPost.heightOffset)

        myPostImage.topToBottom(of: headerPost, offset: Constants.MyPostImage.topToBottomOffset)
        myPostImage.leadingToSuperview()
        myPostImage.trailingToSuperview()
        myPostImage.height(UIScreen.main.bounds.width / 2)

        myDescriptionText.topToBottom(of: myPostImage, offset: Constants.MyDescriptionText.topToBottomOffset)
        myDescriptionText.leadingToSuperview(offset: Constants.MyDescriptionText.leadingAndTrailingToSuperViewOffset)
        myDescriptionText.trailingToSuperview(offset: Constants.MyDescriptionText.leadingAndTrailingToSuperViewOffset)
        myDescriptionText.bottom(to: contentView, offset: Constants.MyDescriptionText.bottomOffset)
    }

    // MARK: - Enums

    private enum Constants {
        enum HeaderPost {
            static let topToSuperViewOffset: CGFloat = 16
            static let leadingToSuperViewOffset: CGFloat = 16
            static let heightOffset: CGFloat = 19
        }

        enum MyPostImage {
            static let topToBottomOffset: CGFloat = 20
        }

        enum MyDescriptionText {
            static let topToBottomOffset: CGFloat = 16
            static let leadingAndTrailingToSuperViewOffset: CGFloat = 16
            static let bottomOffset: CGFloat = -16
        }
    }

    override func prepareForReuse() {
        headerPost.text = nil
        myPostImage.image = nil
        myDescriptionText.text = nil
    }

    func setupMyPosts(with myPosts: PostViewModel) {
        headerPost.text = myPosts.postTitle
        myPostImage.image = myPosts.postImage
        myDescriptionText.text = myPosts.description
    }

    // MARK: - Properties

    // Header
    private lazy var headerPost: UILabel = {
        $0.textColor = .titleColor
        $0.font = .authorHeaderFont
        return $0
    }(UILabel())

    // Post Image
    private lazy var myPostImage: UIImageView = {
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .textFieldTextColor
        return $0
    }(UIImageView())

    // My post
    private lazy var myDescriptionText: UILabel = {
        $0.textColor = .titleColor
        $0.font = .descriptionTextFont
        $0.textAlignment = .natural
        $0.numberOfLines = 0
        return $0
    }(UILabel())
}
