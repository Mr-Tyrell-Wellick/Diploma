//
//  ProfileViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs
import UIKit
import TinyConstraints
import RxSwift
import RxGesture

protocol ProfileViewContollerListener: AnyObject {
    func viewDidLoad()
    func didTapSetStatus(_ newStatus: String?)
    func didTapOpenPhotos()
}

final class ProfileViewController: UIViewController {
    
    weak var listener: ProfileViewContollerListener?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        addConstraints()
        listener?.viewDidLoad()
    }
    
    // MARK: - Functions
    
    private func addView() {
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
    }
    
    private func addConstraints() {
        tableView.edgesToSuperview(usingSafeArea: true)
        loadingIndicator.center = view.center
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
        $0.registerCell(ProfileTableViewCell.self)
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    private lazy var profileHeaderView: ProfileHeaderViewPresentable = {
        $0
    }(ProfileHeaderView())

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        $0.isHidden = true
        return $0
    }(UIActivityIndicatorView(style: .large))

    private var postsViewModel: [PostsViewModel] = []
    private var photosViewModel: [ProfilePhotoGalleryViewModel] = []
    private var status: String?
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        if section == 0 {
            profileHeaderView.listener = self
            profileHeaderView.setStatus(status)
            return profileHeaderView
        } else {
            return nil
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row == 0, indexPath.section == 0 else { return }
        listener?.didTapOpenPhotos()
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return postsViewModel.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeuCell(ProfileTableViewCell.self, indexPath: indexPath)
            cell.configure(photosViewModel)
            return cell
        } else {
            let cell = tableView.dequeuCell(PostTableCell.self, indexPath: indexPath)
            cell.setupPosts(
                with: postsViewModel[indexPath.row],
                isLikeHidden: true,
                isAvatarHidden: true,
                isAuthorNameHidden: true,
                isHeaderPostHidden: true
            )
            return cell
        }
    }
    
    // Remove cell light when clicking on the post
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        guard indexPath.section != 0, indexPath.row != 0 else { return true }
        return false
    }
}

// MARK: - ProfilePresentable

extension ProfileViewController: ProfilePresentable {
    func showPosts(_ viewModel: [PostsViewModel]) {
        postsViewModel = viewModel
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    func showStatus(_ status: String?) {
        self.status = status
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    func showPhotos(_ viewModel: [ProfilePhotoGalleryViewModel]) {
        photosViewModel = viewModel
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }

    func showLoadingIndicator(_ show: Bool) {
        show
        ? loadingIndicator.startAnimating()
        : loadingIndicator.stopAnimating()
    }
}

// MARK: - ProfileControllable

extension ProfileViewController: ProfileViewControllable {
    func push(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController:ProfileHeaderViewListener {
    func didTapSetStatus(_ newStatus: String?) {
        listener?.didTapSetStatus(newStatus)
    }
}
