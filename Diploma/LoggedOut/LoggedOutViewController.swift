//
//  LoggedOutViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 05.06.2023.
//

import RIBs
import UIKit
import TinyConstraints
import RxSwift
import RxGesture

protocol LoggedOutViewControllerListener: AnyObject {
    func didTapBiometry()
    func didTapSignUp()
    func didTapLogIn(_ model: LoginCredentialsModel)
    func viewDidLoad()
}

final class LoggedOutViewController: UIViewController {
    
    weak var listener: LoggedOutViewControllerListener?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .allScreenBackgroundColor
        addView()
        addConstraints()
        subscribeFaceIDTap()
        subscribeOnSignUpTap()
        subscribeloginButtonTap()
        listener?.viewDidLoad()
    }
    
    // MARK: - Functions
    private func addView() {
        view.addSubview(stackViewTextField)
        view.addSubview(logoImage)
        view.addSubview(faceIDImage)
        view.addSubview(loginButton)
        view.addSubview(signUpLabel)
        view.addSubview(loadingIndicator)
        
        stackViewTextField.addArrangedSubview(loginTextField)
        stackViewTextField.addArrangedSubview(passwordTextField)
    }
    
    private func subscribeFaceIDTap() {
        faceIDImage.rx
            .tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                listener?.didTapBiometry()
            }
            .disposed(by: disposeBag)
    }
    
    private func subscribeOnSignUpTap() {
        signUpLabel.rx
            .tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                listener?.didTapSignUp()
            }
            .disposed(by: disposeBag)
    }
    
    private func subscribeloginButtonTap() {
        loginButton.rx
            .tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                listener?.didTapLogIn(
                    LoginCredentialsModel(
                        login: loginTextField.text ?? "",
                        password: passwordTextField.text ?? ""
                    )
                )
            }
            .disposed(by: disposeBag)
    }
    
    private func addConstraints() {
        logoImage.top(to: view, offset: Constants.LogoImage.topOffset)
        logoImage.centerXToSuperview()
        logoImage.width(Constants.LogoImage.widthAndHeightOffset)
        logoImage.height(Constants.LogoImage.widthAndHeightOffset)
        
        faceIDImage.centerXToSuperview()
        faceIDImage.topToBottom(of: logoImage, offset: Constants.FaceIDImage.topToBottomOffset)
        faceIDImage.height(Constants.FaceIDImage.widthAndHeightOfsset)
        faceIDImage.width(Constants.FaceIDImage.widthAndHeightOfsset)
        
        loadingIndicator.bottomToTop(of: faceIDImage,offset: Constants.LoadingIndicator.bottomToTopOffset)
        loadingIndicator.centerXToSuperview()
        
        stackViewTextField.topToBottom(of: faceIDImage, offset: Constants.StackViewTextField.topToBottomOffset)
        stackViewTextField.leadingToSuperview(offset: Constants.StackViewTextField.leadingAndTrailingToSuperviewOffset)
        stackViewTextField.trailingToSuperview(offset: Constants.StackViewTextField.leadingAndTrailingToSuperviewOffset)
        
        loginTextField.leading(to: stackViewTextField)
        loginTextField.centerX(to: view)
        
        passwordTextField.leadingToSuperview()
        passwordTextField.trailingToSuperview()
        passwordTextField.centerX(to: view)
        
        loginButton.topToBottom(of: passwordTextField, offset: Constants.LoginButton.TopToBottomOffset)
        loginButton.leadingToSuperview(offset: Constants.LoginButton.leadingAndTrailingOffset)
        loginButton.trailingToSuperview(offset: Constants.LoginButton.leadingAndTrailingOffset)
        loginButton.height(Constants.LoginButton.heightOffset)
        
        signUpLabel.topToBottom(of: loginButton, offset: Constants.SignUpLabel.topToBottomOffset)
        signUpLabel.height(Constants.SignUpLabel.heightOffset)
        signUpLabel.leadingToSuperview()
        signUpLabel.trailingToSuperview()
    }
    
    // MARK: - Enums
    
    private enum Constants {
        enum LogoImage {
            static let topOffset: CGFloat = 60
            static let widthAndHeightOffset: CGFloat = 300
        }
        
        enum LoginButton {
            static let TopToBottomOffset: CGFloat = 35
            static let heightOffset: CGFloat = 50
            static let leadingAndTrailingOffset: CGFloat = 35
        }
        
        enum SignUpLabel {
            static let topToBottomOffset: CGFloat = 40
            static let heightOffset: CGFloat = 20
        }
        
        enum FaceIDImage {
            static let topToBottomOffset: CGFloat = 15
            static let widthAndHeightOfsset: CGFloat = 33
        }
        
        enum LoadingIndicator {
            static let  bottomToTopOffset: CGFloat = 20
        }
        
        enum StackViewTextField {
            static let topToBottomOffset: CGFloat = 30
            static let leadingAndTrailingToSuperviewOffset: CGFloat = 20
        }
    }
    
    // MARK: - Properties
    
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
    
    // Logo
    private lazy var logoImage: UIImageView = {
        $0.image = .logoImage
        return $0
    }(UIImageView())
    
    // Face ID
    private lazy var faceIDImage: UIImageView = {
        $0.isUserInteractionEnabled = true
        $0.image = .faceIDImage
        return $0
    }(UIImageView())
    
    // Login button
    private let loginButton: UIButton = {
        
        $0.setupButton(
            CustomButtonType.defaultButton(
                title: Strings.loginButton.localized,
                titleColor: .buttonColor,
                backgroundColor: .buttonBackgroundColor
            )
        )
        return $0
    }(UIButton())
    
    // Sign Up label
    private let signUpLabel: UILabel = {
        $0.setupLabelAndAttributes(
            allText: Strings.signUpText.localized,
            highLighthedText: Strings.highLighthedText.localized,
            textColor: .loggedOutLabelColor
        )
        $0.textAlignment = .center
        $0.font = .signUpLabelFont
        return $0
    }(UILabel())
    
    // Loading indicator
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        $0.isHidden = true
        return $0
    }(UIActivityIndicatorView())
    
    private let disposeBag = DisposeBag()
}

// MARK: - LoggedOutPresentable

extension LoggedOutViewController: LoggedOutPresentable {
    func showLoadingIndicator(_ show: Bool) {
        show
        ? loadingIndicator.startAnimating()
        : loadingIndicator.stopAnimating()
    }
    
    func fillCredentials(_ credentialModel: KeychainCredentialsModel) {
        loginTextField.text = credentialModel.login
        passwordTextField.text = credentialModel.password
    }
    
    func configureBiometryButton(_ isEnabled: Bool) {
        faceIDImage.isHidden = !isEnabled
    }
}

// MARK: - LoggedOutViewControllable

extension LoggedOutViewController: LoggedOutViewControllable {
    func presentSheet(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .pageSheet
        present(viewController, animated: true)
    }
    
    func dissmiss() {
        dismiss(animated: true)
    }
}
