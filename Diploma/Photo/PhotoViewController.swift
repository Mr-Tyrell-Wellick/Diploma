//
//  PhotoViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 19.07.2023.
//

import RIBs
import UIKit
import TinyConstraints
import RxSwift
import RxGesture

protocol PhotoViewControllerListener: AnyObject {
    func viewDidAppear()
    func viewDidDissappear()
}

final class PhotoViewController: UIViewController {

    weak var listener: PhotoViewControllerListener?

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = .allScreenBackgroundColor
        addViews()
        addConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listener?.viewDidAppear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        listener?.viewDidDissappear()
    }

    // MARK: - Functions

    private func addViews() {
        view.addSubview(verticalCollectionView)
        view.addSubview(loadingIndicator)
    }

    private func addConstraints() {
        verticalCollectionView.edgesToSuperview()
        loadingIndicator.center = view.center
    }

    private func setupNavBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = Strings.photoGalleryLabel.localized
    }

    // MARK: - Properties

    // Vertical layout
    private lazy var verticalLayout: UICollectionViewLayout = {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 8
        $0.minimumLineSpacing = 8
        $0.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return $0
    }(UICollectionViewFlowLayout())

    // Vertical collection view
    private lazy var verticalCollectionView: UICollectionView = {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.dataSource = self
        $0.delegate = self
        $0.registerCell(PhotoCollectionViewCell.self)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: self.verticalLayout))

    // Loading Indacatior
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        $0.isHidden = true
        return $0
    }(UIActivityIndicatorView())

    // Сell size in PhotoVC
    private let itemSizeOfVC = (UIScreen.main.bounds.width - 32)/3
    private var viewModel: [PhotoGalleryViewModel] = []

}

// MARK: - UICollectionViewDataSource

extension PhotoViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.reusableCell(PhotoCollectionViewCell.self, indexPath: indexPath)
        cell.configurePhoto(with: viewModel[indexPath.row].image)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotoViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: itemSizeOfVC, height: itemSizeOfVC)
    }
}

// MARK: - PhotoPresentable

extension PhotoViewController: PhotoPresentable {
    func showViewModel(_ viewModel: [PhotoGalleryViewModel]) {
        self.viewModel = viewModel
        verticalCollectionView.reloadData()
    }
    func showLoadingIndicator(_ show: Bool) {
        show
        ? loadingIndicator.startAnimating()
        : loadingIndicator.stopAnimating()
    }
}

// MARK: - PhotoViewContollable

extension PhotoViewController: PhotoViewContollable {
}
