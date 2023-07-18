//
//  Post.swift
//  Diploma
//
//  Created by Ульви Пашаев on 13.07.2023.
//

import UIKit

struct Post {

    let author: String?
    let description: String?
    let postImage: UIImage?
    let avatarImage: UIImage?
    let postId: Int

    init(author: String?, description: String?, postImage: UIImage?, avatarImage: UIImage?, postId: Int) {
        self.author = author
        self.description = description
        self.postImage = postImage
        self.avatarImage = avatarImage
        self.postId = postId
    }

}

var posts: [Post] = [
Post(
    author: Strings.friendOne.localized,
    description: Strings.friendOneDescription.localized,
    postImage: .bengalCatImage,
    avatarImage: .friendOneImage,
    postId: 0),
Post(
    author: Strings.friendTwo.localized,
    description: Strings.friendTwoDescription.localized,
    postImage: .dogImage,
    avatarImage: .friendTwoImage,
    postId: 1),
Post(
    author: Strings.friendThree.localized,
    description: Strings.friendThreeDescription.localized,
    postImage: .houseImage,
    avatarImage: .friendThreeImage,
    postId: 2),
Post(
    author: Strings.friendFour.localized,
    description: Strings.friendFourDescription.localized,
    postImage: .catsImage,
    avatarImage: .friendFourImage,
    postId: 3),
Post(
    author: Strings.friendFive.localized,
    description: Strings.friendFiveDescription.localized,
    postImage: .lakeImage,
    avatarImage: .friendFiveImage,
    postId: 4),
Post(
    author: Strings.friendSix.localized,
    description: Strings.friendSixDescription.localized,
    postImage: .dolphinImage,
    avatarImage: .friendSixImage,
    postId: 5)
]
