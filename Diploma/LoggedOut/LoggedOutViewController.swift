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
}

final class LoggedOutViewController: UIViewController {

    weak var listener: LoggedOutViewControllerListener?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .loggedOutBackgroundColor
        addView()
        addConstraints()

        subscribeFaceIDTap()
        subscribeOnSignUpTap()
        subscribeloginButtonTap()
    }

    // MARK: - Functions
    private func addView() {
        view.addSubview(stackViewTextField)
        view.addSubview(logoImage)
        view.addSubview(faceIDImage)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
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
        signUpButton.rx
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
            .bind { _ in
                print("login button tapped")
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

        loadingIndicator.bottomToTop(of: faceIDImage,offset: 20)
        loadingIndicator.centerXToSuperview()


        stackViewTextField.centerXToSuperview()
        stackViewTextField.topToBottom(of: faceIDImage, offset: 120)
        stackViewTextField.leadingToSuperview(offset: 16)
        stackViewTextField.trailingToSuperview(offset: 16)




        signUpButton.topToBottom(of: faceIDImage, offset: Constants.SignUpButton.TopToBottomOffset)
        signUpButton.leadingToSuperview(offset: Constants.SignUpButton.leadingAndTrailingOffset)
        signUpButton.trailingToSuperview(offset: Constants.SignUpButton.leadingAndTrailingOffset)
        signUpButton.height(Constants.SignUpButton.heightOffset)

        loginButton.topToBottom(of: signUpButton, offset: Constants.LoginButton.topToBottomOffset)
        loginButton.centerXToSuperview()
    }

    // MARK: - Enums

    private enum Constants {
        enum LogoImage {
            static let topOffset: CGFloat = 124
            static let widthAndHeightOffset: CGFloat = 300
        }

        enum SignUpButton {
            static let TopToBottomOffset: CGFloat = 20
            static let heightOffset: CGFloat = 50
            static let leadingAndTrailingOffset: CGFloat = 35
        }

        enum LoginButton {
            static let topToBottomOffset: CGFloat = 80

        }

        enum FaceIDImage {
            static let topToBottomOffset: CGFloat = 15
            static let widthAndHeightOfsset: CGFloat = 33
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

// LoginTextField
    private let loginTextField: UITextField = {
        $0.addLeftImage(.atImage)
    // TODO: - локализовать!!!!
        $0.setupTextFieldAndAttributes(
            placeholder: "E-mail",
            textColor: .black
        )
        $0.keyboardType = .emailAddress
    //TODO: - дообавить цвет (если что исправить)
        $0.setBottomBorder(offset: 15,
                           color: UIColor.separator,
                           cornerRadius: 8)
        return $0
    }(UITextField())

    // Password TextField
    private let passwordTextField: UITextField = {
        $0.addLeftImage(.lockImage)
        // TODO: - локализовать!!!!
        $0.setupTextFieldAndAttributes(
            placeholder: "Password",
            textColor: .black
        )
        //TODO: - дообавить цвет (если что исправить)
        $0.setBottomBorder(
            offset: 15,
            color: .separator,
            cornerRadius: 8
        )
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())

    // логотип
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

    // кнопка "sign Up"
    private let signUpButton: UIButton = {
        $0.setTitle(Strings.signUpButtonTitle1.localized, for: .normal)
        $0.setTitleColor(UIColor.buttonColor, for: .normal)
        $0.backgroundColor = .buttonBackgroundColor
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0.5
        return $0
    }(UIButton())

    // кнопка login
    private let loginButton: UIButton = {
        $0.setTitle(Strings.loginButtonTitle1.localized, for: .normal)
        $0.setTitleColor(UIColor.textFieldBackgroundColor, for: .normal)
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

// MARK: - LoggedOutPresentable

extension LoggedOutViewController: LoggedOutPresentable {
    func showLoadingIndicator(_ show: Bool) {
        show
        ? loadingIndicator.startAnimating()
        : loadingIndicator.stopAnimating()
    }
}

// MARK: - LoggedOutViewControllable

extension LoggedOutViewController: LoggedOutViewControllable {
    func presentSheet(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .pageSheet
        present(viewController, animated: true)
    }
}
