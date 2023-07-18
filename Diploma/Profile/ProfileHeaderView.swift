//
//  ProfileHeaderView.swift
//  Diploma
//
//  Created by Ульви Пашаев on 13.07.2023.
//

import UIKit
import TinyConstraints
import RxSwift
import RxGesture

class ProfileHeaderView: UICollectionReusableView {

    // TODO: - может здесь что-то будет еще добавлено!


    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        addView()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Functions

    private func addView() {
        addSubview(userName)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(statusButton)
    }

    private func addConstraints() {


        avatar.top(to: self, offset: Constants.Avatar.topOffset)
        avatar.leading(to: self, offset: Constants.Avatar.leadingOffset)
        avatar.width(Constants.Avatar.withAndHeightOffset)
        avatar.height(Constants.Avatar.withAndHeightOffset)

        userName.top(to: self, offset: Constants.UserName.topOffset)
        userName.leading(to: self, offset: Constants.UserName.leadingOffset)


        statusLabel.top(to: self, offset: Constants.StatusLabel.topOffset)
        statusLabel.leading(to: self, offset: Constants.StatusLabel.leadingOffset)

        statusTextField.top(to: self, offset: Constants.StatusTextField.topOffset)
        statusTextField.leading(to: self, offset: Constants.StatusTextField.leadingOffset)
        statusTextField.trailing(to: self, offset: Constants.StatusTextField.trailingOffset)


        statusButton.top(to: self, offset: Constants.StatusButton.topOffset)
        statusButton.leading(to: self, offset: Constants.StatusButton.leadingOffset)
        statusButton.trailing(to: self, offset: Constants.StatusButton.trailingOffset)
        statusButton.width(Constants.StatusButton.widthOffset)
        statusButton.height(Constants.StatusButton.heightOffset)

        // TODO: - разобраться, он здесь будет нужен или нет
        //        self.bottom(to: statusButton, offset: 30)
    }

    // MARK: - Enum

    private enum Constants {

        enum Avatar {
            static let topOffset: CGFloat = 16
            static let withAndHeightOffset: CGFloat = 100
            static let leadingOffset: CGFloat = 16
        }

        enum UserName {
            static let topOffset: CGFloat = 27
            static let leadingOffset: CGFloat = 140
        }

        enum StatusLabel {
            static let topOffset: CGFloat = 54
            static let leadingOffset: CGFloat = 140
        }

        // TODO: - до конца разобраться с привязкой лево/право
        enum StatusTextField {
            static let topOffset: CGFloat = 80
            static let leadingOffset: CGFloat = 140
            static let trailingOffset: CGFloat = -16
        }

        enum StatusButton {
            static let topOffset: CGFloat = 132
            static let leadingOffset: CGFloat = 16
            static let trailingOffset: CGFloat = 16
            static let widthOffset: CGFloat = 340
            static let heightOffset: CGFloat = 50

        }
    }

    // MARK: - Properties

    private lazy var avatar: UIImageView = {
        $0.setupAvatar(userImage: .avatarImage)
        return $0
    }(UIImageView())

    // User name
    private let userName: UILabel = {

        $0.text = Strings.userName.localized
        $0.textColor = .titleColor
        $0.font = .fullNameFont
        return $0
    }(UILabel())

    // TODO: - надо ли text заменить на локализованный или нет?

    // Status
    private let statusLabel: UILabel = {

        $0.textColor = .titleColor
        $0.font = .statusFont
        return $0
    }(UILabel())

    // Status Text Field
    private let statusTextField: UITextField = {
        $0.setupTextFieldAndAttributes(
            placeholder: Strings.statusTextField.localized,
            textColor: .titleColor
        )
        return $0
    }(UITextField())

    // Status button
    private let statusButton: UIButton = {
        $0.setupButton(
            CustomButtonType.defaultButton(
                title: Strings.statusButton.localized,
                titleColor: .buttonColor,
                backgroundColor: .buttonBackgroundColor
            )
        )
        return $0
    }(UIButton())
}


// TODO: - разобраться с tap'ом на аватарку, чтобы она открывалась 
