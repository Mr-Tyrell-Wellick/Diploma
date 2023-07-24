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

protocol ProfileHeaderViewListener: AnyObject {

}

protocol ProfileHeaderViewPresentable: UITableViewHeaderFooterView {

}

class ProfileHeaderView: UITableViewHeaderFooterView, ProfileHeaderViewPresentable {

    // MARK: - Init

    convenience init() {
        self.init(frame: .zero)
        addView()
        addConstraints()
    }

    // MARK: - Functions

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupBorders()
    }

    private func setupBorders() {
        avatar.layer.borderColor = UIColor.borderUserColor.cgColor
        statusTextField.layer.borderColor = UIColor.borderUserColor.cgColor
    }

    private func addView() {
        contentView.addSubview(avatar)
        contentView.addSubview(userName)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusTextField)
        contentView.addSubview(statusButton)
    }

    //    private func subscribeOnStatusButtonTap() {
    //        statusButton.rx
    //            .tapGesture()
    //            .when(.recognized)
    //            .bind { [unowned self] _ in
    //                listener.
    //            }

    private func addConstraints() {

        avatar.topToSuperview(offset: Constants.Avatar.topToSuperViewOffset)
        avatar.leadingToSuperview(offset: Constants.Avatar.leadingToSuperViewOffset)
        avatar.width(Constants.Avatar.withAndHeightOffset)
        avatar.height(Constants.Avatar.withAndHeightOffset)

        userName.top(to: avatar, offset: Constants.UserName.topOffset)
        userName.leading(to: avatar, offset: Constants.UserName.leadingOffset)

        statusLabel.topToBottom(of: userName, offset: Constants.StatusLabel.topToBotomOffset)
        statusLabel.leading(to: userName)

        statusTextField.topToSuperview(offset: Constants.StatusTextField.topToSuperViewOffset)
        statusTextField.leadingToSuperview(offset: Constants.StatusTextField.leadingToSuperViewOffset)
        statusTextField.trailing(to: statusButton)
        statusTextField.height(Constants.StatusTextField.heightOffset)

        statusButton.topToSuperview(offset: Constants.StatusButton.topToSuperViewOffset)
        statusButton.leadingToSuperview(offset: Constants.StatusButton.leadingAndTrailingOffset)
        statusButton.trailingToSuperview(offset: Constants.StatusButton.leadingAndTrailingOffset)
        statusButton.width(Constants.StatusButton.widthOffset)
        statusButton.height(Constants.StatusButton.heightOffset)
        statusButton.bottomToSuperview(offset: Constants.StatusButton.bottomToSuperViewOffset)
    }

    // MARK: - Enum

    private enum Constants {

        enum Avatar {
            static let topToSuperViewOffset: CGFloat = 16
            static let leadingToSuperViewOffset: CGFloat = 16
            static let withAndHeightOffset: CGFloat = 100
        }

        enum UserName {
            static let topOffset: CGFloat = 10
            static let leadingOffset: CGFloat = 130
        }

        enum StatusLabel {
            static let topToBotomOffset: CGFloat = 5
        }

        enum StatusTextField {
            static let topToSuperViewOffset: CGFloat = 80
            static let leadingToSuperViewOffset: CGFloat = 140
            static let heightOffset:CGFloat = 40
        }

        enum StatusButton {
            static let topToSuperViewOffset: CGFloat = 132
            static let leadingAndTrailingOffset: CGFloat = 35
            static let widthOffset: CGFloat = 340
            static let heightOffset: CGFloat = 50
            static let bottomToSuperViewOffset: CGFloat = -30
        }
    }

    // MARK: - Properties

    private lazy var avatar: UIImageView = {
        $0.image = .avatarImage
        $0.layer.borderColor = UIColor.borderUserColor.cgColor
        $0.layer.cornerRadius = 50
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 3
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())

    // User name
    private let userName: UILabel = {
        $0.text = Strings.userName.localized
        $0.textColor = .titleColor
        $0.font = .fullNameFont
        return $0
    }(UILabel())

    // Status
    private let statusLabel: UILabel = {
        $0.text = "Busy"
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
        $0.backgroundColor = .allScreenBackgroundColor
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0.5
        $0.leftView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 10,
                height: $0.frame.height
            )
        )
        $0.leftViewMode = .always
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
