//
//  PostTableViewCell.swift
//  Diploma
//
//  Created by Ульви Пашаев on 14.07.2023.
//

import UIKit
import TinyConstraints
import RxSwift
import RxGesture

struct PostsViewModel {
    let headerTitle: String?
    let author: String?
    let description: String
    let postImage: UIImage
    let avatarImage: UIImage?
    let postId: Int
    var isLiked: Bool = false
}

protocol PostListener: AnyObject {
    func didTapLike(_ postId: Int)
}

final class PostTableCell: UITableViewCell {
    
    weak var listener: PostListener?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHeightConstraints()
        addContentView()
        addConstraints()
        subscribeOnFavoriteButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func addContentView() {
        contentView.addSubview(headerPost)
        contentView.addSubview(authorName)
        contentView.addSubview(authorImage)
        contentView.addSubview(descriptionText)
        contentView.addSubview(postImage)
        contentView.addSubview(favoriteButton)
    }
    
    private func subscribeOnFavoriteButton() {
        favoriteButton.rx
            .tapGesture().when(.recognized)
            .bind { [unowned self] _ in
                guard let postId else { return }
                listener?.didTapLike(postId)
            }
            .disposed(by: disposeBag)
    }
    
    private func addConstraints() {
        headerPost.topToSuperview(offset: Constants.HeaderPost.leadingToSuperViewOffset)
        headerPost.leadingToSuperview(offset: Constants.HeaderPost.leadingToSuperViewOffset)
        headerPost.height(Constants.HeaderPost.heightOffset)
        
        authorImage.topToSuperview(offset: Constants.AuthorImage.topToSuperViewOffset)
        authorImage.leadingToSuperview(offset: Constants.AuthorImage.leadingToSuperviewOffset)
        authorImage.height(Constants.AuthorImage.heightAndWidthOfsset)
        authorImage.width(Constants.AuthorImage.heightAndWidthOfsset)
        
        authorName.topToBottom(of: authorImage, offset: Constants.AuthorName.topToBottomOffset)
        authorName.centerX(to: authorImage)
        authorName.height(Constants.AuthorName.heightOffset)


        postImageTopToAuthor.isActive = true
        postImage.leadingToSuperview()
        postImage.trailingToSuperview()
        postImage.height(UIScreen.main.bounds.width / 2)
        
        descriptionText.topToBottom(of: postImage, offset: Constants.DescriptionText.topToBottomOffset)
        descriptionText.leadingToSuperview(offset: Constants.DescriptionText.leadingAndTrailingToSuperViewOffset)
        descriptionText.trailingToSuperview(offset: Constants.DescriptionText.leadingAndTrailingToSuperViewOffset)
        
        favoriteButton.topToBottom(of: descriptionText, offset: Constants.FavoriteButton.topToBottomOffset)
        favoriteButton.centerX(to: descriptionText)
        favoriteButton.bottom(to: contentView, offset: Constants.FavoriteButton.bottomOffset)
    }
    
    // MARK: - Enums
    
    private enum Constants {
        enum HeaderPost {
            static let topToSuperViewOffset: CGFloat = 16
            static let leadingToSuperViewOffset: CGFloat = 16
            static let heightOffset: CGFloat = 19
        }
        
        enum AuthorImage {
            static let topToSuperViewOffset: CGFloat = 16
            static let leadingToSuperviewOffset: CGFloat = 16
            static let heightAndWidthOfsset: CGFloat = 80
        }
        
        enum AuthorName {
            static let topToBottomOffset: CGFloat = 5
            static let heightOffset: CGFloat = 19
        }

        enum DescriptionText {
            static let topToBottomOffset: CGFloat = 16
            static let leadingAndTrailingToSuperViewOffset: CGFloat = 16
            static let bottomOfsset: CGFloat = -16
        }
        
        enum FavoriteButton {
            static let topToBottomOffset: CGFloat = 5
            static let bottomOffset: CGFloat = -10
        }
    }
    
    private func setupHeightConstraints() {
        authorNameHeightConstraint = NSLayoutConstraint.init(
            item: authorName,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        avatarHeightConstraint = NSLayoutConstraint.init(
            item: authorImage,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        postTitleHeightConstraint = NSLayoutConstraint(
            item: headerPost,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        favoriteButtonHeightConstraint = NSLayoutConstraint.init(
            item: favoriteButton,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        postImageTopToAuthor = NSLayoutConstraint.init(
            item: postImage,
            attribute: .top,
            relatedBy: .equal,
            toItem: authorName,
            attribute: .bottom,
            multiplier: 1,
            constant: 20
        )
        postImageTopToTitle = NSLayoutConstraint.init(
            item: postImage,
            attribute: .top,
            relatedBy: .equal,
            toItem: headerPost,
            attribute: .bottom,
            multiplier: 1,
            constant: 16
        )
    }
    
    override func prepareForReuse() {
        headerPost.text = nil
        authorName.text = nil
        authorImage.image = nil
        postImage.image = nil
        descriptionText.text = nil
        disposeBag = DisposeBag()
        subscribeOnFavoriteButton()
    }
    
    func setupPosts(
        with allPosts: PostsViewModel,
        isLikeHidden: Bool = false,
        isAvatarHidden: Bool,
        isAuthorNameHidden: Bool,
        isHeaderPostHidden: Bool
    ) {
        headerPost.text = allPosts.headerTitle
        authorName.text = allPosts.author
        authorImage.image = allPosts.avatarImage
        postImage.image = allPosts.postImage
        descriptionText.text = allPosts.description
        postId = allPosts.postId
        // author
        if allPosts.headerTitle == nil && allPosts.author != nil {
            avatarHeightConstraint.isActive = false
            authorNameHeightConstraint.isActive = false
            postTitleHeightConstraint.isActive = true

            postImageTopToAuthor.isActive = true
            postImageTopToTitle.isActive = false
            // header
        } else if allPosts.headerTitle != nil && allPosts.author == nil {
            avatarHeightConstraint.isActive = true
            authorNameHeightConstraint.isActive = true
            postTitleHeightConstraint.isActive = false

            postImageTopToAuthor.isActive = false
            postImageTopToTitle.isActive = true
        }
        layoutSubviews()
                guard !isLikeHidden else {
                    favoriteButton.isHidden = true
                    favoriteButtonHeightConstraint.isActive = true
                    return
                }
                favoriteButton.isHidden = false
                favoriteButtonHeightConstraint.isActive = false
                changeLikeButton(allPosts.isLiked)
            }

    private func changeLikeButton(_ isLiked: Bool) {
        favoriteButton.setImage(
            isLiked
            ? .heartFillImage
            : .heartImage,
            for: .normal
        )
    }
    
    // MARK: - Properties
    
    // Header
    private lazy var headerPost: UILabel = {
        $0.textColor = .titleColor
        $0.font = .authorHeaderFont
        return $0
    }(UILabel())
    
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
    
    // Add posts to favorite screen
    private lazy var favoriteButton: UIButton = {
        $0.setImage(.heartImage, for: .normal)
        return $0
    }(UIButton())
    
    private var avatarHeightConstraint: NSLayoutConstraint!
    private var postTitleHeightConstraint: NSLayoutConstraint!
    private var authorNameHeightConstraint: NSLayoutConstraint!
    private var favoriteButtonHeightConstraint: NSLayoutConstraint!

    private var postImageTopToAuthor: NSLayoutConstraint!
    private var postImageTopToTitle: NSLayoutConstraint!

    private var postId: Int?
    private var disposeBag = DisposeBag()
}
