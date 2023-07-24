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
        $0.registerCell(PostTableViewCell.self)
        $0.registerCell(UITableViewCell.self)
        return $0
    }(UITableView(frame: .zero, style: .grouped))

    private lazy var profileHeaderView: ProfileHeaderViewPresentable = {
        $0
    }(ProfileHeaderView())

    private var postsViewModel: [PostViewModel] = []
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    // TODO: - доделать (вписать header, который будет создан
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return profileHeaderView
        } else {
            return nil
        }
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return postsViewModel.count
        }
        return 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return PhotoTableViewCell()
        } else if indexPath.section == 1 {
            let cell = tableView.dequeuCell(PostTableViewCell.self, indexPath: indexPath)
            cell.setupMyPosts(with: postsViewModel[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeuCell(UITableViewCell.self, indexPath: indexPath)
            return cell
        }
    }

    // Remove cell light when clicking on the post
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: - Properties

// MARK: - ProfilePresentable

extension ProfileViewController: ProfilePresentable {
    func showPosts(_ viewModel: [PostViewModel]) {
        postsViewModel = viewModel
        tableView.reloadData()
    }
}

// MARK: - ProfileControllable

extension ProfileViewController: ProfileViewControllable {
    
}
