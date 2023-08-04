//
//  PostModel+CoreDataProperties.swift
//  Diploma
//
//  Created by Ульви Пашаев on 27.07.2023.
//

import Foundation
import CoreData

extension PostModel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostModel> {
        return NSFetchRequest<PostModel>(entityName: "PostModel")
    }
    
    @NSManaged public var author: String?
    @NSManaged public var avatarImage: Data?
    @NSManaged public var postDescription: String
    @NSManaged public var postId: Int16
    @NSManaged public var postImage: Data?
    @NSManaged public var postTitle: String?
    @NSManaged public var isFavorite: Bool
}

extension PostModel: Identifiable {
    
}
