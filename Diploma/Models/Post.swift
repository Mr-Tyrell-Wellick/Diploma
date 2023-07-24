//
//  Post.swift
//  Diploma
//
//  Created by Ульви Пашаев on 13.07.2023.
//

import UIKit

struct Post: Equatable {

    let myHeaderPosts: String?
    let author: String?
    let description: String
    let postImage: UIImage
    let avatarImage: UIImage?
    let postId: Int
    
    init(
        myHeaderPosts: String?,
        author: String?,
        description: String,
        postImage: UIImage,
        avatarImage: UIImage?,
        postId: Int) {
            self.myHeaderPosts = myHeaderPosts
            self.author = author
            self.description = description
            self.postImage = postImage
            self.avatarImage = avatarImage
            self.postId = postId
        }
}
