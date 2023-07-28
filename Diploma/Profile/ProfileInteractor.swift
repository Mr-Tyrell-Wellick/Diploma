//
//  ProfileInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs
import UIKit
import RxSwift
import RxRelay

protocol ProfileRouting: ViewableRouting {
    
}

protocol ProfilePresentable: Presentable {

    func showPosts(_ viewModel: [PostViewModel])
    func showStatus(_ status: String?)

    var listener: ProfileViewContollerListener? { get set }
}

final class ProfileInteractor: PresentableInteractor <ProfilePresentable>, ProfileInteractable {
    
    weak var router: ProfileRouting?
    
    init(
        presenter: ProfilePresentable,
        postsService: PostsService,
        myPostsStream: PostsStream
    ) {
        self.postsService = postsService
        self.myPostsStream = myPostsStream
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
                postsService.getMyPosts()
            }
            .subscribe()
            .disposeOnDeactivate(interactor: self)
    }

    private func subscribeOnPostsStream() {
        Observable.combineLatest(
            myPostsStream
                .posts
                .distinctUntilChanged(),
            uiReady
        )
        .filter { $0.1 }
        .map { [unowned self] posts, _ in
            createPostsViewModel(posts)
        }
        .bind { [unowned self] postsViewModel in
            presenter.showPosts(postsViewModel)
        }
        .disposeOnDeactivate(interactor: self)
    }

    private func createPostsViewModel(_ posts: [Post]) -> [PostViewModel] {
        posts.map {
            .init(
                postTitle: $0.postTitle,
                author: $0.author,
                description: $0.description,
                postImage: $0.postImage,
                avatarImage: $0.avatarImage,
                postId: $0.postId
            )
        }
    }

    private let postsService: PostsService
    private let myPostsStream: PostsStream
    private let uiReady = BehaviorRelay<Bool>(value: false)
}

// MARK: - ProfileViewControllerListener

extension ProfileInteractor: ProfileViewContollerListener {

    func viewDidLoad() {
        uiReady.accept(true)
    }

    func didTapSetStatus(_ newStatus: String?) {
        presenter.showStatus(newStatus)
    }
}
