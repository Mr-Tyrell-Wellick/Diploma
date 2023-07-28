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
                postId: Int($0.postId)
            )
        }
    }
}
