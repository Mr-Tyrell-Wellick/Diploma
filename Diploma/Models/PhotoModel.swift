//
//  PhotoModel.swift
//  Diploma
//
//  Created by Ульви Пашаев on 15.07.2023.
//

import Foundation
import UIKit

struct PhotoModel {

    let galleryImage: UIImage

    init(galleryImage: UIImage) {
        self.galleryImage = galleryImage
    }
}

var photoGalleryPosts: [PhotoModel] = [
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
