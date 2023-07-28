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
    func likePost(_ id: Int) -> Completable
}

final class CoreDataServiceImpl: CoreDataService {

    func likePost(_ id: Int) -> Completable {
        fetchMatching(
            predicate: NSPredicate(format: "%K = %@",
            argumentArray: [#keyPath(PostModel.postId), id])
        )
        .flatMapCompletable { [unowned self] fetchedPosts in
            guard var post = fetchedPosts.first else { return .empty() }
            post.isFavorite = true
            return deleteBy(id: id).andThen(insertPost(post))
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
                    DispatchQueue.main.async {
                        observer(.success(result.mapToSimplePost()))
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
//                    saveBackgroundContext()
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
                    // TODO: - убрать копи пасту
                    self.backgroundContext.perform { [unowned self] in
                        let post = PostModel(context: backgroundContext)
                        post.fillFromSimplePost(initialPost)
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
                DispatchQueue.main.async {
                    observer(.success(allPosts.mapToSimplePost()))
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
