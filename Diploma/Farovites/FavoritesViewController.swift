//
//  FavoritesViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs
import UIKit
import TinyConstraints
import RxSwift
import RxGesture

protocol FavoritesViewControllerListener: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func didPressDeletePost(_ postId: Int)
}

final class FavoritesViewController: UIViewController {

    weak var listener: FavoritesViewControllerListener?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(Strings.favoritesNavigationItem.localized)
        addView()
        addConstraints()
        listener?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener?.viewDidAppear()
    }

    // MARK: - Functions

    private func addView() {
        view.addSubview(tableView)
    }

    private func addConstraints() {
        tableView.edgesToSuperview(usingSafeArea: true)
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
    }(UITableView(frame: .zero, style: .plain))

    private var viewModel: [PostsViewModel] = []
}

// MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeuCell(PostTableCell.self, indexPath: indexPath)
        cell.setupPosts(
            with: viewModel[indexPath.row],
            isLikeHidden: true,
            isAvatarHidden: true,
            isAuthorNameHidden: true,
            isHeaderPostHidden: false
        )
        return cell
    }

    // Delete Post
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [createDeleteAction(for: indexPath)])
    }

    private func createDeleteAction(for indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "") { [weak self] action, view, callback in
            guard let self,
                  let postId = self.viewModel.elementAt(UInt(indexPath.row))?.postId else {
                callback(false)
                return
            }
            self.listener?.didPressDeletePost(postId)
            callback(true)
        }
        action.image = UIImage(systemName: "trash")
        return action
    }
}

// MARK: - FavoritesPresentable

extension FavoritesViewController: FavoritesPresentable {
    func showViewModel(_ viewModel: [PostsViewModel]) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}

// MARK: - FavoritesViewControllable

extension FavoritesViewController: FavoritesViewControllable {
}
