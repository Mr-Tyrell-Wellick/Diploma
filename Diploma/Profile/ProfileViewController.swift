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
    
}

final class ProfileViewController: UIViewController {
    
    weak var listener: ProfileViewContollerListener?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        addView()
        addConstraints()

    }

    // TODO: - НАПИСАТЬ!

    // MARK: - Functions

    private func addView() {



    }


    private func addConstraints() {

    }


    // MARK: - Enums

    private enum Constants {


    }


    // TODO: - (HEADERVIEW) набросок

//    // MARK: - Properties
//
//    // User name
//    private let userName: UILabel = {
//        $0.setupLabel(
//            text: Strings.userName.localized,
//            textColor: .titleColor,
//            font: .fullNameFont
//        )
//        return $0
//    }(UILabel())
//
//    // Status
//    private let statusLabel: UILabel = {
//        $0.setupLabel(
//            text: "Be nice",
//            textColor: .titleColor,
//            font: .statusFont
//        )
//        return $0
//    }(UILabel())
//
//    // Status Text Field
//    private let statusTextField: UITextField = {
//        $0.setupTextFieldAndAttributes(
//            placeholder: Strings.statusTextField.localized,
//            textColor: .titleColor
//        )
//        return $0
//    }(UITextField())
//
//    // Status button
//    private let statusButton: UIButton = {
//        $0.setupButton(
//            CustomButtonType.defaultButton(
//                title: Strings.statusButton.localized,
//                titleColor: .buttonColor,
//                backgroundColor: .buttonBackgroundColor
//            )
//        )
//        return $0
//    }(UIButton())


    // TODO: - (PHOTOVIEWCELL) - набросок

    // MARK: - Properties

    // photo header
    private let photoLabel: UILabel = {
        $0.text = Strings.photoLabel.localized
        $0.textColor = .titleColor
        $0.font = .photoHeaderFont
        return $0
    }(UILabel())


    // arrow (стрелка сверху справа)
    private lazy var arrowImage: UIImageView = {
        $0.image = .arrowImage
        return $0
    }(UIImageView())


    // TODO: - (САМА ФОТОГАЛЕРЕЯ)!
    //    self.navigationItem.title = Strings.photoGalleryLabel.localized


    // TODO: - (POSTTABLEVIEWCELL) - набросок. (заголовок, фото чувака - заглушка)


    private lazy var author: UILabel = {

        $0.text = Strings.friendOne.localized
        $0.textColor = .titleColor
        $0.font = .authorHeaderFont
        return $0
    }(UILabel())

    // круглая аватарка, которая будет отображаться левее от имени пользователя в header'e
    private lazy var authorImage: UIImageView = {
        $0.image = .friendOneImage
        return $0
    }(UIImageView())


    // Post Image
    private lazy var postImage: UIImageView = {
        $0.image = .dogImage
        return $0
    }(UIImageView())


    // сам пост
    private lazy var descriptionText: UILabel = {

        $0.text = "Какой-то текст"
        $0.textColor = .titleColor
        $0.font = .descriptionTextFont
        return $0
    }(UILabel())

    // просмотры
    private lazy var userViews: UILabel = {
        $0.text = "Views: 300"
        $0.textColor = .titleColor
        $0.font = .viewsFont
        return $0
    }(UILabel())
    

    // TODO: - посмотреть проект Тимура, где он реализовал через сердечко
    // Likes (хочу сделать кнопкой с анимацией, и если получится прикрутить цифры
    private lazy var favoriteButton: UIButton = {
        $0.setupButton(CustomButtonType.imageButton(imageButton: .heartImage))
        return $0
    }(UIButton())

    // TODO: - в проекте Тимура, переделать под rxSwift
    //    @objc private func didTapFavoriteButton() {
    //        let imageName = self.viewModel?.isFavorite == false
    //        ? "heart.circle.fill"
    //        : "heart.circle" // "suit.heart"
    //        UIView.animate(withDuration: 0.2) {
    //            self.favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    //            self.favoriteButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    //        } completion: { _ in
    //            guard var newViewModel = self.viewModel else { return }
    //
    //            UIView.animate(withDuration: 0.2) {
    //                self.favoriteButton.transform = .identity
    //            } completion: { _ in
    //                newViewModel.isFavorite.toggle()
    //                self.viewModel = newViewModel
    //                self.delegate?.wasLikedArticle(with: newViewModel.url)
    //            }
    //        }
    //    }
    //    private func favoriteButtonConstraints() -> [NSLayoutConstraint] {
    //        let topAnchor = self.favoriteButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 10)
    //        let rightAnchor = self.favoriteButton.rightAnchor.constraint(equalTo: self.stackView.rightAnchor)
    //        let heightAnchor = self.favoriteButton.heightAnchor.constraint(equalToConstant: 20)
    //        let widthAnchor = self.favoriteButton.widthAnchor.constraint(equalToConstant: 20)
    //        let bottomAnchor = self.favoriteButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
    //
    //        return [
    //            topAnchor, rightAnchor, heightAnchor, widthAnchor, bottomAnchor
    //        ]
    //    }



    //}

    //extension ArticleTableViewCell: Setupable {
    //
    //    func setup(with viewModel: ViewModelProtocol) {
    //        guard let viewModel = viewModel as? ViewModel else { return }
    //
    //        self.viewModel = viewModel
    //
    //        self.titleLabel.text = viewModel.title == .empty
    //        ? "Untitled"
    //        : viewModel.title
    //        self.descriptionLabel.text = viewModel.description
    //        self.publishedDateLabel.text = viewModel.publishedAt
    //        let imageName = self.viewModel?.isFavorite == false
    //        ? "heart.circle" // "suit.heart"
    //        : "heart.circle.fill"
    //        self.favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    //
    //        if self.descriptionLabel.text == .empty {
    //            self.descriptionLabel.isHidden = true
    //        }
    //    }
    //}
}









// MARK: - ProfilePresentable

extension ProfileViewController: ProfilePresentable {
    
}

// MARK: - ProfileControllable

extension ProfileViewController: ProfileViewControllable {
    
}
