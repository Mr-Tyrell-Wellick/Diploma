//
//  DataGenerator.swift
//  Diploma
//
//  Created by Ульви Пашаев on 20.07.2023.
//

import Foundation

struct DataGenerator {

    // MARK: - Friends posts

    static  func getFriendsPosts() -> [Post] {
        [
            Post(
                postTitle: nil,
                author: Strings.friendOne.localized,
                description: Strings.friendOneDescription.localized,
                postImage: .bengalCatImage,
                avatarImage: .friendOneImage,
                postId: 0
            ),
            Post(
                postTitle: nil,
                author: Strings.friendTwo.localized,
                description: Strings.friendTwoDescription.localized,
                postImage: .dogImage,
                avatarImage: .friendTwoImage,
                postId: 1
            ),
            Post(
                postTitle: nil,
                author: Strings.friendThree.localized,
                description: Strings.friendThreeDescription.localized,
                postImage: .houseImage,
                avatarImage: .friendThreeImage,
                postId: 2
            ),
            Post(
                postTitle: nil,
                author: Strings.friendFour.localized,
                description: Strings.friendFourDescription.localized,
                postImage: .catsImage,
                avatarImage: .friendFourImage,
                postId: 3
            ),
            Post(
                postTitle: nil,
                author: Strings.friendFive.localized,
                description: Strings.friendFiveDescription.localized,
                postImage: .lakeImage,
                avatarImage: .friendFiveImage,
                postId: 4
            ),
            Post(
                postTitle: nil,
                author: Strings.friendSix.localized,
                description: Strings.friendSixDescription.localized,
                postImage: .dolphinImage,
                avatarImage: .friendSixImage,
                postId: 5
            )
        ]
    }

    // MARK: - My posts

    static func getMyPosts() -> [Post] {
        [
            Post(
                postTitle: Strings.myHeaderPostOne.localized,
                author: nil,
                description: Strings.myPostOne.localized,
                postImage: .myPostOneImage,
                avatarImage: nil,
                postId: 0
            ),
            Post(
                postTitle: Strings.myHeaderPostTwo.localized,
                author: nil,
                description: Strings.myPostTwo.localized,
                postImage: .myPostTwoImage,
                avatarImage: nil,
                postId: 1
            ),
            Post(
                postTitle: Strings.myHeaderPostThree.localized,
                author: nil,
                description: Strings.myPostThree.localized,
                postImage: .myPostThreeImage,
                avatarImage: nil,
                postId: 2
            )
        ]
    }

    // MARK: - My Photos

    static func getPhotoGalleryPosts() -> [PhotoModel] {
        [
            PhotoModel(galleryImage: .galleryOneImage),
            PhotoModel(galleryImage: .galleryTwoImage),
            PhotoModel(galleryImage: .galleryThreeImage),
            PhotoModel(galleryImage: .galleryFourImage),
            PhotoModel(galleryImage: .galleryFiveImage),
            PhotoModel(galleryImage: .gallerySixImage),
            PhotoModel(galleryImage: .gallerySevenImage),
            PhotoModel(galleryImage: .galleryEightImage),
            PhotoModel(galleryImage: .galleryNineImage),
            PhotoModel(galleryImage: .galleryTenImage)
        ]
    }
}
