//
//  SignUpViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 06.06.2023.
//

import Foundation
import UIKit
import TinyConstraints
import RxSwift
import RxGesture

protocol SignUpViewControllerListener: AnyObject {
    func didClose()
    func didTapSignUp(_ model: SignUpCredentialsModel)
    func didTapAlertAction(_ action: String)
}

final class SignUpViewController: UIViewController {
    
    weak var listener: SignUpViewControllerListener?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .allScreenBackgroundColor
        addView()
        addConstraints()
        subscribeInSignUp()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        listener?.didClose()
    }
    
    // MARK: - Functions
    
    private func addView() {
        view.addSubview(stackViewTextField)
        view.addSubview(strip)
        view.addSubview(signUpLabel)
        view.addSubview(logoImage)
        view.addSubview(signUpButton)
        view.addSubview(loadingIndicator)
        stackViewTextField.addArrangedSubview(loginTextField)
        stackViewTextField.addArrangedSubview(passwordTextField)
    }
    
    private func subscribeInSignUp() {
        signUpButton
            .rx
            .tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.listener?.didTapSignUp(
                    SignUpCredentialsModel(
                        login: self?.loginTextField.text ?? "",
                        password: self?.passwordTextField.text ?? ""
                    )
                )
            }.disposed(by: disposeBag)
    }
    
    private func addConstraints() {
        strip.top(to: view, offset: Constants.Strip.topOffset)
        strip.centerXToSuperview()
        strip.width(Constants.Strip.widthOffset)
        strip.height(Constants.Strip.heightOffset)
        
        signUpLabel.topToBottom(of: strip, offset: Constants.SignUpLabel.topToBottomOffset)
        signUpLabel.leadingToSuperview(offset: Constants.SignUpLabel.leadingAndTrailingToSuperviewOffset)
        signUpLabel.trailingToSuperview(offset: Constants.SignUpLabel.leadingAndTrailingToSuperviewOffset)
        
        logoImage.topToBottom(of: signUpLabel, offset: Constants.LogoImage.topToBottomOffset)
        logoImage.centerX(to: stackViewTextField)
        logoImage.height(Constants.LogoImage.heightOffset)
        logoImage.width(Constants.LogoImage.widthOffset)
        
        loadingIndicator.topToBottom(of: logoImage, offset: Constants.LoadingIndicator.topToBottomOffset)
        loadingIndicator.centerXToSuperview()
        
        stackViewTextField.centerYToSuperview()
        stackViewTextField.leadingToSuperview(offset: Constants.StackViewTextField.leadingAndTrailingOffset)
        stackViewTextField.trailingToSuperview(offset: Constants.StackViewTextField.leadingAndTrailingOffset)
        
        loginTextField.leading(to: stackViewTextField)
        loginTextField.centerXToSuperview()
        
        passwordTextField.leadingToSuperview()
        passwordTextField.trailingToSuperview()
        passwordTextField.centerX(to: view)
        
        signUpButton.topToBottom(of: passwordTextField, offset: Constants.SignUpButton.topToBottomOffset)
        signUpButton.height(Constants.SignUpButton.heightOffset)
        signUpButton.leadingToSuperview(offset: Constants.SignUpButton.leadingAndTrailingToSuperview)
        signUpButton.trailingToSuperview(offset: Constants.SignUpButton.leadingAndTrailingToSuperview)
    }
    
    // MARK: - Enums
    
    private enum Constants {
        enum Strip {
            static let topOffset: CGFloat = 30
            static let widthOffset: CGFloat = 50
            static let heightOffset: CGFloat = 4
        }
        
        enum SignUpLabel {
            static let topToBottomOffset: CGFloat = 70
            static let leadingAndTrailingToSuperviewOffset: CGFloat = 30
        }
        
        enum LoadingIndicator {
            static let topToBottomOffset: CGFloat = 25
        }
        
        enum LogoImage {
            static let topToBottomOffset: CGFloat = 50
            static let heightOffset: CGFloat = 80
            static let widthOffset: CGFloat = 66
        }
        
        enum StackViewTextField {
            static let leadingAndTrailingOffset: CGFloat = 16
        }
        
        enum SignUpButton {
            static let topToBottomOffset: CGFloat = 35
            static let heightOffset: CGFloat = 50
            static let leadingAndTrailingToSuperview: CGFloat = 35
        }
    }
    
    // MARK: - Properties
    
    // stackView
    private let stackViewTextField: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .equalCentering
        $0.alignment = .center
        $0.spacing = 30
        return $0
    }(UIStackView())
    
    // Login TextField
    private let loginTextField: UITextField = {
        $0.addLeftImage(.atImage)
        $0.setupTextFieldAndAttributes(
            placeholder: Strings.loginTextField.localized,
            textColor: .textFieldTextColor
        )
        $0.keyboardType = .emailAddress
        $0.setBottomBorder(
            offset: 15,
            color: .separatorColor,
            cornerRadius: 8
        )
        return $0
    }(UITextField())
    
    // Password TextField
    private let passwordTextField: UITextField = {
        $0.addLeftImage(.lockImage)
        $0.setupTextFieldAndAttributes(
            placeholder: Strings.passwordTextField.localized,
            textColor: .textFieldTextColor
        )
        $0.setBottomBorder(
            offset: 15,
            color: .separatorColor,
            cornerRadius: 8
        )
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())
    
    private lazy var strip: UIView = {
        $0.backgroundColor = .stripColor
        $0.layer.cornerRadius = 2
        return $0
    }(UIView())
    
    // logo
    private lazy var logoImage: UIImageView = {
        $0.image = .launchImage
        $0.clipsToBounds = true
        return $0
    } (UIImageView())
    
    private let signUpLabel: UILabel = {
        $0.text = Strings.signUpLabel.localized
        $0.textColor = .titleColor
        $0.font = .signUpLabelInSignUpFont
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    // Sign Up Button
    private let signUpButton: UIButton = {
        $0.setupButton(
            CustomButtonType.defaultButton(
                title: Strings.signUpButton.localized,
                titleColor: .buttonColor,
                backgroundColor: .buttonBackgroundColor
            )
        )
        return $0
    }(UIButton())
    
    // индикатор загрузки
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        $0.isHidden = true
        return $0
    }(UIActivityIndicatorView())
    
    private let disposeBag = DisposeBag()
}

// MARK: - SignUpPresentable

extension SignUpViewController: SignUpPresentable {
    func showLoadingIndicator(_ show: Bool) {
        show
        ? loadingIndicator.startAnimating()
        : loadingIndicator.stopAnimating()
    }
    
    func didTapAlertAction(_ action: String) {
        listener?.didTapAlertAction(action)
    }
}

// MARK: - SignUpViewControllable

extension SignUpViewController: SignUpViewControllable {
    
}
