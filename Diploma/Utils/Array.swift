//
//  Array.swift
//  Diploma
//
//  Created by Ульви Пашаев on 27.07.2023.
//

import Foundation
import UIKit

// MARK: - PostModel

extension Array where Element == PostModel {
    func mapToSimplePost() -> [Post] {
        map {
            let postImage = UIImage(data: $0.postImage ?? Data()) ?? UIImage()
            let avatarImage = UIImage(data: $0.avatarImage ?? Data())
            return Post(
                postTitle: $0.postTitle,
                author: $0.author,
                description: $0.postDescription,
                postImage: postImage,
                avatarImage: avatarImage,
                postId: Int($0.postId),
                isFavorite: $0.isFavorite
            )
        }
    }
}

// MARK: - Post

extension Array where Element == Post {
    func mapToFriendsViewModel() -> [PostsViewModel] {
        map {
            .init(
                headerTitle: $0.postTitle,
                author: $0.author,
                description: $0.description,
                postImage: $0.postImage,
                avatarImage: $0.avatarImage,
                postId: $0.postId,
                isLiked: $0.isFavorite
            )
        }
    }
}

// MARK: - safely index

extension Array {
    func elementAt(_ index: UInt) -> Element? {
        guard index < count else { return nil }
        return self[Int(index)]
    }
}
