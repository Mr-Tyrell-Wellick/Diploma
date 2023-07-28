//
//  PostModel+CoreDataClass.swift
//  Diploma
//
//  Created by Ульви Пашаев on 27.07.2023.
//

import Foundation
import CoreData

@objc(PostModel)
public class PostModel: NSManagedObject {
    func fillFromSimplePost(_ initialPost: Post) {
        postImage = initialPost.postImage.jpegData(compressionQuality: 0.1)
        avatarImage = initialPost.avatarImage?.jpegData(compressionQuality: 0.1)
        author = initialPost.author
        postId = Int16(initialPost.postId)
        postDescription = initialPost.description
        postTitle = initialPost.postTitle
        isFavorite = initialPost.isFavorite
    }
}


