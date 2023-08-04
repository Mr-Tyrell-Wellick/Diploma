//
//  PostsService.swift
//  Diploma
//
//  Created by Ульви Пашаев on 20.07.2023.
//

import Foundation
import RxSwift
import RxRelay

protocol PostsService {
    func getFriendsPosts() -> Completable
    func getMyPosts() -> Completable
    func getFavoritesPosts() -> Completable
    func likePost(postId: Int)
    func dislikePost(postId: Int)
}

final class PostsServiceImpl: PostsService {
    
    init(
        friendsPostsStream: PostsMutableStream,
         myPostsStream: PostsMutableStream,
         favoritesPostsStream: PostsMutableStream,
         coreDataService: CoreDataService
    ) {
        self.friendsPostsStream = friendsPostsStream
        self.myPostsStream = myPostsStream
        self.favoritesPostsStream = favoritesPostsStream
        self.coreDataService = coreDataService
    }
    
    func getFriendsPosts() -> Completable {
        .create { [unowned self] observer in
            let predicate = NSPredicate(
                format: "%K != %@",
                argumentArray: [#keyPath(PostModel.author), nil]
            )
            return coreDataService
                .fetchMatching(predicate: predicate)
                .subscribe (onSuccess: { [unowned self] friendsPosts in
                    friendsPostsStream.updatePosts(friendsPosts)
                    observer(.completed)
                })
        }
    }
    
    func getMyPosts() -> Completable {
        .create { [unowned self] observer in
            let predicate = NSPredicate(
                format: "%K = %@",
                argumentArray: [#keyPath(PostModel.author), nil]
            )
            return coreDataService
                .fetchMatching(predicate: predicate)
                .subscribe(onSuccess: { [unowned self] friendsPosts in
                    myPostsStream.updatePosts(friendsPosts)
                    observer(.completed)
                })
        }
    }
    
    func getFavoritesPosts() -> Completable {
        .create { [unowned self] observer in
            let predicate = NSPredicate(
                format: "%K = %@",
                argumentArray: [#keyPath(PostModel.isFavorite), true]
            )
            return coreDataService
                .fetchMatching(predicate: predicate)
                .subscribe(onSuccess: { [unowned self] friendsPosts in
                    favoritesPostsStream.updatePosts(friendsPosts)
                    observer(.completed)
                })
        }
    }
    
    func likePost(postId: Int) {
        likeDislikePost(postId: postId, setLikeTo: true)
    }
    
    func dislikePost(postId: Int) {
        likeDislikePost(postId: postId, setLikeTo: false)
    }
    
    private func likeDislikePost(postId: Int, setLikeTo:Bool) {
        let filterPredicate = NSPredicate(
            format: "%K = %@ AND %K != %@",
            argumentArray: [
                #keyPath(PostModel.postId), postId,
                #keyPath(PostModel.author), nil
            ]
        )
        let propertiesToUpdate = [#keyPath(PostModel.isFavorite): setLikeTo]
        coreDataService
            .update(
                entity: PostModel.self,
                filterPredicate: filterPredicate,
                propertiesToUpdate: propertiesToUpdate
            )
            .andThen(getFriendsPosts())
            .andThen(getFavoritesPosts())
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private let friendsPostsStream: PostsMutableStream
    private let myPostsStream: PostsMutableStream
    private let favoritesPostsStream: PostsMutableStream
    private let coreDataService: CoreDataService
    private let disposeBag = DisposeBag()
}
