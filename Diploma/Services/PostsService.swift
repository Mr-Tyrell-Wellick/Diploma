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
}

final class PostsServiceImpl: PostsService {

    init(friendsPostsStream: PostsMutableStream,
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
            // WARNING: - maybe a fail
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
            // WARNING: - maybe a fail
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
            // WARNING: - maybe a fail
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
        coreDataService
            .likePost(postId)
            .andThen(getFriendsPosts())
            .subscribe()
            .disposed(by: disposeBag)
    }

    private let friendsPostsStream: PostsMutableStream
    private let myPostsStream: PostsMutableStream
    private let favoritesPostsStream: PostsMutableStream
    private let coreDataService: CoreDataService
    private let disposeBag = DisposeBag()
}
