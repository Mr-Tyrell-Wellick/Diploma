//
//  MainInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs
import UIKit
import RxSwift
import RxRelay

protocol MainRouting: ViewableRouting {
    
}

protocol MainPresentable: Presentable {

    func showFriendsPosts(_ friendsViewModel: [FriendsPostViewModel])

    var listener: MainViewControllerListener? { get set }
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable {
    
    weak var router: MainRouting?
    
    init(
        presenter: MainPresentable,
        postsService: PostsService,
        friendsPostsStream: PostsStream
    ) {
        self.postsService = postsService
        self.friendsPostsStream = friendsPostsStream
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        logActivate()
        subscribeOnUiReady()
        subscribeOnPostsStream()
    }
    
    override func willResignActive() {
        logDeactivate()
    }

    private func subscribeOnUiReady() {
        uiReady
            .filter { $0 }
            .flatMapLatest { [unowned self] _ in
                postsService.getFriendsPosts()
            }
            .subscribe()
            .disposeOnDeactivate(interactor: self)
    }

    private func subscribeOnPostsStream() {
        Observable.combineLatest(
            friendsPostsStream
                .posts
                .distinctUntilChanged(),
            uiReady
        )
        .filter { $0.1 }
        .map { [unowned self] posts, _ in
            createPostsViewModel(posts)
        }
        .bind { [unowned self] friendsPostViewModel in
            presenter.showFriendsPosts(friendsPostViewModel)
        }
        .disposeOnDeactivate(interactor: self)
    }

    private func createPostsViewModel(_ posts: [Post]) -> [FriendsPostViewModel] {
        posts.map {
            .init(
                postTitle: $0.postTitle,
                author: $0.author,
                description: $0.description,
                postImage: $0.postImage,
                avatarImage: $0.avatarImage,
                postId: $0.postId,
                isLiked: $0.isFavorite
            )
        }
    }

    private let postsService: PostsService
    private let friendsPostsStream: PostsStream
    private let uiReady = BehaviorRelay<Bool>(value: false)
}

// MARK: - MainViewControllerListener

extension MainInteractor: MainViewControllerListener {

    func viewDidLoad() {
        uiReady.accept(true)
    }

    func didTapLikeButton(postId: Int, isLiked: Bool) {
        isLiked
        ? postsService.dislikePost(postId: postId)
        : postsService.likePost(postId: postId)
    }
}
