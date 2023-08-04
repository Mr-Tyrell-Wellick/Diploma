//
//  PhotoCoreDataModel+CoreDataProperties.swift
//  Diploma
//
//  Created by Ульви Пашаев on 01.08.2023.
//

import Foundation
import CoreData

extension PhotoCoreDataModel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoCoreDataModel> {
        return NSFetchRequest<PhotoCoreDataModel>(entityName: "PhotoCoreDataModel")
    }
    
    @NSManaged public var image: Data
}

extension PhotoCoreDataModel: Identifiable {
}
