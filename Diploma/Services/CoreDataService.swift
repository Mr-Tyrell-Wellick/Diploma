//
//  CoreDataService.swift
//  Diploma
//
//  Created by Ульви Пашаев on 23.07.2023.
//

import Foundation
import CoreData
import UIKit
import RxSwift
import RxRelay

protocol CoreDataService {
    func initStorage() -> Completable
    func fetchAllPosts() -> Single<[Post]>
    func fetchMatching(predicate: NSPredicate) -> Single<[Post]>
    func update<T: NSManagedObject>(
        entity: T.Type,
        filterPredicate: NSPredicate,
        propertiesToUpdate: [AnyHashable: Any]
    ) -> Completable
    func fetchPhotos() -> Single<[UIImage]>
}

enum CoreDataError: Error {
    case fetchError
    case genericMapResultError
}

final class CoreDataServiceImpl: CoreDataService {
    
    func update<T: NSManagedObject>(
        entity: T.Type,
        filterPredicate: NSPredicate,
        propertiesToUpdate: [AnyHashable: Any]
    ) -> Completable {
        let entityName = String(describing: entity)
        let updateRequest = NSBatchUpdateRequest(entityName: entityName)
        updateRequest.predicate = filterPredicate
        updateRequest.propertiesToUpdate = propertiesToUpdate
        return .create { [unowned self] observer in
            backgroundContext.perform { [unowned self] in
                do {
                    try backgroundContext.execute(updateRequest)
                    DispatchQueue.main.async {
                        observer(.completed)
                    }
                } catch {
                    DispatchQueue.main.async {
                        observer(.error(error))
                    }
                }
            }
            return Disposables.create {}
        }
    }
    
    func fetchMatching(predicate: NSPredicate) -> Single<[Post]> {
        .create { [unowned self] observer in
            backgroundContext.perform { [self] in
                let fetchRequest = PostModel.fetchRequest()
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
                fetchRequest.predicate = predicate
                do {
                    let result = try backgroundContext.fetch(fetchRequest)
                    let mappedResult = result.mapToSimplePost()
                    DispatchQueue.main.async {
                        observer(.success(mappedResult))
                    }
                } catch {
                    print(observer(.failure(error)))
                    DispatchQueue.main.async {
                        observer(.failure(error))
                    }
                }
            }
            return Disposables.create {}
        }
    }
    
    func fetchPhotos() -> Single<[UIImage]> {
        .create { [unowned self] observer in
            backgroundContext.perform { [self] in
                let fetchRequest = PhotoCoreDataModel.fetchRequest()
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "image", ascending: true)]
                do {
                    let result = try backgroundContext.fetch(fetchRequest)
                    let mappedResult = result.map { UIImage(data: $0.image) ?? UIImage() }
                    DispatchQueue.main.async {
                        observer(.success(mappedResult))
                    }
                } catch {
                    print(observer(.failure(error)))
                    DispatchQueue.main.async {
                        observer(.failure(error))
                    }
                }
            }
            return Disposables.create {}
        }
    }
    
    private func insertPost(_ initialPost: Post) -> Completable {
        .create { [unowned self] observer in
            backgroundContext.perform { [unowned self] in
                let post = PostModel(context: backgroundContext)
                post.fillFromSimplePost(initialPost)
                saveBackgroundContext()
                DispatchQueue.main.async {
                    observer(.completed)
                }
            }
            return Disposables.create {}
        }
    }
    
    private func deleteBy(id: Int) -> Completable {
        .create { [unowned self] observer in
            backgroundContext.perform { [self] in
                let fetchRequest = PostModel.fetchRequest()
                fetchRequest.predicate = NSPredicate(
                    format: "%K = %@",
                    argumentArray: [#keyPath(PostModel.postId), id]
                )
                do {
                    let result = try backgroundContext.fetch(fetchRequest)
                    result.forEach { backgroundContext.delete($0) }
                    saveBackgroundContext()
                    DispatchQueue.main.async {
                        observer(.completed)
                    }
                } catch {
                    print(error)
                    DispatchQueue.main.async {
                        observer(.error(error))
                    }
                }
            }
            return Disposables.create {}
        }
    }
    
    func initStorage() -> Completable {
        .create { [unowned self] observer in
            let dispatchGroup = DispatchGroup()
            var initialPosts = DataGenerator
                .getFriendsPosts()
            initialPosts.append(
                contentsOf: DataGenerator.getMyPosts()
            )
            
            initialPosts.forEach { initialPost in
                backgroundQueue.async(group: dispatchGroup) {
                    self.backgroundContext.perform { [unowned self] in
                        let post = PostModel(context: backgroundContext)
                        post.fillFromSimplePost(initialPost)
                        saveBackgroundContext()
                    }
                }
            }
            
            let initialPhotos = DataGenerator.getPhotoGalleryPosts()
            initialPhotos.forEach { initialPhoto in
                backgroundQueue.async(group: dispatchGroup) {
                    self.backgroundContext.perform { [unowned self] in
                        let photo = PhotoCoreDataModel(context: backgroundContext)
                        photo.image = initialPhoto.galleryImage.jpegData(compressionQuality: 0.1) ?? Data()
                        saveBackgroundContext()
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                observer(.completed)
            }
            return Disposables.create {}
        }
    }
    
    func fetchAllPosts() -> Single<[Post]> {
        .create { [unowned self] observer in
            let fetchRequest = PostModel.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
            do {
                let allPosts = try backgroundContext.fetch(fetchRequest)
                let mappedResult = allPosts.mapToSimplePost()
                DispatchQueue.main.async {
                    observer(.success(mappedResult))
                }
            } catch {
                DispatchQueue.main.async {
                    observer(.failure(error))
                }
            }
            return Disposables.create {}
        }
    }
    
    private func saveBackgroundContext() {
        let context = backgroundContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = container.newBackgroundContext()
        return context
    }()
    
    private lazy var container: NSPersistentContainer = {
        $0.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return $0
    }(NSPersistentContainer(name: "Diploma"))
    
    private let backgroundQueue = DispatchQueue(
        label: "CoreDataSelfCreatedQueue",
        qos: .default
    )
}
