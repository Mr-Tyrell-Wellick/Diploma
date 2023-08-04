//
//  MainViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs
import UIKit
import TinyConstraints
import RxSwift
import RxGesture

protocol MainViewControllerListener: AnyObject {
    func viewDidLoad()
    func didTapLikeButton(postId: Int)
}

final class MainViewController: UIViewController {
    
    weak var listener: MainViewControllerListener?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(Strings.mainItemName.localized)
        addView()
        addConstraints()
        listener?.viewDidLoad()
    }
    
    // MARK: - Functions
    
    private func addView() {
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        tableView.edgesToSuperview()
    }
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        $0.backgroundColor = .allScreenBackgroundColor
        $0.dataSource = self
        $0.delegate = self
        $0.sectionHeaderHeight = UITableView.automaticDimension
        $0.sectionFooterHeight = 0
        $0.rowHeight = UITableView.automaticDimension
        $0.showsVerticalScrollIndicator = false
        $0.registerCell(PostTableCell.self)
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    private lazy var friendsAvatarView: MainFriendsViewPresentable = {
        $0
    }(MainFriendsView())
    
    private var postViewModel: [PostsViewModel] = []
}
// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return friendsAvatarView
        } else {
            return nil
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        if section == 0 {
            return 87
        } else {
            return 0
        }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return postViewModel.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeuCell(PostTableCell.self, indexPath: indexPath)
        cell.listener = self
        cell.setupPosts(
            with: postViewModel[indexPath.row],
            isAvatarHidden: false,
            isAuthorNameHidden: false,
            isHeaderPostHidden: true
        )
        return cell
    }
    
    // Remove cell light when clicking on the post
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: - MainPresentable

extension MainViewController: MainPresentable {
    func showFriendsPosts(_ friendsViewModel: [PostsViewModel]) {
        postViewModel = friendsViewModel
        tableView.reloadData()
    }
    
    func showFriendsAvatars(_ friendsAvatarsViewModel: [MainFriendsViewViewModel]) {
        friendsAvatarView.showViewModel(friendsAvatarsViewModel)
    }
}

// MARK: - MainViewControllable

extension MainViewController: MainViewControllable {
    
}

extension MainViewController: PostListener {
    func didTapLike(_ postId: Int) {
        listener?.didTapLikeButton(postId: postId)
    }
}
