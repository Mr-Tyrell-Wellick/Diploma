//
//  PhotoService.swift
//  Diploma
//
//  Created by Ульви Пашаев on 31.07.2023.
//

import RxSwift
import UIKit

protocol PhotoService {
    func getPhotos() -> Single<[UIImage]>
}

final class PhotoServiceImpl: PhotoService {
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
    
    func getPhotos() -> Single<[UIImage]> {
        coreDataService.fetchPhotos()
    }
    
    private let coreDataService: CoreDataService
}
