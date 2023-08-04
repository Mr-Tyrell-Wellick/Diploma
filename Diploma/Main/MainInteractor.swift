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
    
    func showFriendsPosts(_ friendsViewModel: [PostsViewModel])
    func showFriendsAvatars(_ friendsAvatarsViewModel: [MainFriendsViewViewModel])
    
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
        subscribeOnDidTapLike()
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
        .map { posts, _ -> ([PostsViewModel], [MainFriendsViewViewModel]) in
            let viewModel = posts.mapToFriendsViewModel()
            return (
                viewModel,
                viewModel.map { MainFriendsViewViewModel(image: $0.avatarImage ?? UIImage()) }
            )
        }
        .bind { [unowned self] friendsPostViewModel, avatarsViewModel in
            presenter.showFriendsPosts(friendsPostViewModel)
            presenter.showFriendsAvatars(avatarsViewModel)
        }
        .disposeOnDeactivate(interactor: self)
    }
    
    private func subscribeOnDidTapLike() {
        didTapLike
            .compactMap { $0 }
            .withLatestFrom(friendsPostsStream.posts)
            .compactMap { [unowned self] posts -> Post? in
                guard let post = posts.first(where: { $0.postId == didTapLike.value! }) else { return nil }
                return post
            }
            .bind { [unowned self] post in
                post.isFavorite
                ? postsService.dislikePost(postId: post.postId)
                : postsService.likePost(postId: post.postId)
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    private let postsService: PostsService
    private let friendsPostsStream: PostsStream
    private let uiReady = BehaviorRelay<Bool>(value: false)
    private let didTapLike = BehaviorRelay<Int?>(value: nil)
}

// MARK: - MainViewControllerListener

extension MainInteractor: MainViewControllerListener {
    
    func viewDidLoad() {
        uiReady.accept(true)
    }
    
    func didTapLikeButton(postId: Int) {
        didTapLike.accept(postId)
    }
}
