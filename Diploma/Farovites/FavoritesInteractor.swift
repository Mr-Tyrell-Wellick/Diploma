//
//  FavoritesInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs
import UIKit
import RxSwift
import RxRelay

protocol FavoritesRouting: ViewableRouting {
    
}

protocol FavoritesPresentable: Presentable {
    func showViewModel(_ viewModel: [PostsViewModel])

    var listener: FavoritesViewControllerListener? { get set }
}

final class FavoritesInteractor: PresentableInteractor<FavoritesPresentable>, FarovitesInteractable {
    
    weak var router: FavoritesRouting?
    
    init(
        presenter: FavoritesPresentable,
        postsService: PostsService,
        favoritesPostsStream: PostsStream
    ) {
        self.postsService = postsService
        self.favoritesPostsStream = favoritesPostsStream
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        logActivate()
        subscribeOnFavoritesPostStream()
        subscribeOnDidAppear()

    }
    
    override func willResignActive() {
        logDeactivate()
    }

    private func subscribeOnDidAppear() {
        didAppear
            .filter { $0 }
            .flatMapLatest { [unowned self] _ in
                postsService.getFavoritesPosts()
            }
            .subscribe()
            .disposeOnDeactivate(interactor: self)
    }

    private func subscribeOnFavoritesPostStream() {
        Observable.combineLatest(
            favoritesPostsStream
                .posts
                .distinctUntilChanged(),
            uiReady.distinctUntilChanged()
        )
        .filter { $0.1 }
        .map { posts, _ in
            posts.mapToFriendsViewModel()
        }
        .bind { [unowned self] posts in
            presenter.showViewModel(posts)
        }
        .disposeOnDeactivate(interactor: self)
    }

    private let postsService: PostsService
    private let favoritesPostsStream: PostsStream
    private let uiReady = BehaviorRelay<Bool>(value: false)
    private let didAppear = BehaviorRelay<Bool>(value: false)
}

// MARK: - FavoritesViewContollerListener

extension FavoritesInteractor: FavoritesViewControllerListener {
    func viewDidLoad() {
        uiReady.accept(true)
    }

    func viewDidAppear() {
        didAppear.accept(true)
    }

    func didPressDeletePost(_ postId: Int) {
        postsService.dislikePost(postId: postId)
    }
}
