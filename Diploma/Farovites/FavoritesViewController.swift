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
    
}

final class FavoritesViewController: UIViewController {

    weak var listener: FavoritesViewControllerListener?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar(Strings.favoritesNavigationItem.localized)
        addView()
        addConstraints()
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
        $0.registerCell(AuthorPostTableCell.self)
        return $0
    }(UITableView(frame: .zero, style: .plain))
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
        //        return posts.count
        return 1

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeuCell(AuthorPostTableCell.self, indexPath: indexPath)
        //        cell.setupPosts(with: posts[indexPath.row])
        return cell
    }

    // TODO: - создать функцию удаления поста по свайпу (удаление по кнопкам и поиск по автору не буду реализовывать)
}

// MARK: - FavoritesPresentable

extension FavoritesViewController: FavoritesPresentable {

}

// MARK: - FavoritesViewControllable

extension FavoritesViewController: FavoritesViewControllable {

}
