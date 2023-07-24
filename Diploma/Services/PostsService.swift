//
//  PostsService.swift
//  Diploma
//
//  Created by Ульви Пашаев on 20.07.2023.
//

import Foundation
import RxSwift

protocol PostsService {
    func getFriendsPosts() -> Single<Bool>
    func getMyPosts() -> Single<Bool>
    func getFavoritesPosts() -> Single<Bool>
}

final class PostsServiceImpl: PostsService {

    init(friendsPostsStream: PostsMutableStream,
         myPostsStream: PostsMutableStream,
         favoritesPostsStream: PostsMutableStream
    ) {
        self.friendsPostsStream = friendsPostsStream
        self.myPostsStream = myPostsStream
        self.farovitesPostsStream = favoritesPostsStream
    }
    
    func getFriendsPosts() -> RxSwift.Single<Bool> {
        let friendsPosts = DataGenerator.getFriendsPosts()
        friendsPostsStream.updatePosts(friendsPosts)
        return .just(true)
    }

    func getMyPosts() -> RxSwift.Single<Bool> {
        let myPosts = DataGenerator.getMyPosts()
        myPostsStream.updatePosts(myPosts)
        return .just(true)
    }

    func getFavoritesPosts() -> RxSwift.Single<Bool> {
        .just(true)
    }

    private let friendsPostsStream: PostsMutableStream
    private let myPostsStream: PostsMutableStream
    private let farovitesPostsStream: PostsMutableStream
}
