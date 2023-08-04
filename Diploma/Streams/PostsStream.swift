//
//  PostsStream.swift
//  Diploma
//
//  Created by Ульви Пашаев on 20.07.2023.
//

import RxSwift
import RxRelay

protocol PostsStream {
    var posts: Observable<[Post]> { get }
}

protocol PostsMutableStream: PostsStream {
    func updatePosts(_ posts: [Post])
}

final class PostsStreamImpl: PostsMutableStream {
    func updatePosts(_ posts: [Post]) {
        postsValue.accept(posts)
    }
    
    var posts: Observable<[Post]> {
        postsValue.asObservable()
    }
    
    private let postsValue = BehaviorRelay<[Post]>(value: [])
}
