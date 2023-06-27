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
}

final class SignUpViewController: UIViewController {

    weak var listener: SignUpViewControllerListener?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .loggedOutBackgroundColor

        addView()
        addConstraints()

    }


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        listener?.didClose()
    }

    // MARK: - Functions

   private func addView() {
        
       view.addSubview(stackViewTextField)

        stackViewTextField.addArrangedSubview(separator)
        stackViewTextField.addArrangedSubview(loginTextField)
        stackViewTextField.addArrangedSubview(passwordTextField)
    }

    //TODO: - ДОПИСАТЬ!!!
   private func addConstraints() {

    }


    // MARK: - Enums

    private enum Constants {





    }


    // MARK: - Properties

    // stackView
    private let stackViewTextField: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .equalCentering
        $0.alignment = .center
        return $0
    }(UIStackView())

    // TODO: - разобраться с Colors
    // Separator
    private lazy var separator: UIView = {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        return $0
    }(UIView())

    // TODO: - разобраться с Colors
    // Separator Two
    private lazy var separatorTwo: UIView = {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        return $0
    }(UIView())



    // LogInTextField
    private let loginTextField: UITextField = {
        $0.addLeftImage(.atImage)
        $0.setupTextFieldAndAttributes(placeholder: "", textColor: .black)
//        $0.setupTextFieldAndAttributesInSignUp(placeholder: "")
        
        $0.keyboardType = .emailAddress
        return $0
    }(UITextField())

    // PasswordTextField
    private let passwordTextField: UITextField = {
        $0.addLeftImage(.lockImage)
        $0.setupTextFieldAndAttributes(placeholder: "", textColor: .black)

        $0.isSecureTextEntry = true
        return $0
    }(UITextField())

    //    // LogInTextField
    //    private let logInTextField: UITextField = {
    //        $0.placeholder = "Email"
    //        $0.textColor = .black
    //        $0.keyboardType = .emailAddress
    //        $0.layer.borderColor = UIColor.lightGray.cgColor
    //        $0.font = .systemFont(ofSize: 16)
    //
    //        let imageView = UIImageView(image: UIImage(named: "envelope"))
    //        imageView.contentMode = .center
    //        imageView.frame.size = CGSize(width: 16, height: $0.frame.height)
    //        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: $0.frame.height))
    //        containerView.addSubview(imageView)
    //        imageView.center = containerView.center
    //        $0.leftView = containerView
    //        $0.leftViewMode = .always
    //
    //        let placeholderAttributes: [NSAttributedString.Key: Any] = [
    //            .foregroundColor: UIColor.titleColor,
    //            .font: $0.font!
    //        ]
    //        $0.attributedPlaceholder = NSAttributedString(string: $0.placeholder ?? "", attributes: placeholderAttributes)
    //        $0.autocapitalizationType = .none
    //        return $0
    //    }(UITextField())

    //    // PasswordTextField
    //    private let passwordTextField: UITextField = {
    //        $0.placeholder = "Password"
    //        $0.textColor = .black
    //        $0.layer.borderColor = UIColor.lightGray.cgColor
    //        $0.autocapitalizationType = .none
    //        $0.isSecureTextEntry = true
    //        $0.font = .systemFont(ofSize: 16)
    //
    //        let imageView = UIImageView(image: UIImage(named: "at"))
    //        imageView.contentMode = .center
    //        imageView.frame.size = CGSize(width: 16, height: $0.frame.height)
    //        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: $0.frame.height))
    //        containerView.addSubview(imageView)
    //        imageView.center = containerView.center
    //        $0.leftView = containerView
    //        $0.leftViewMode = .always
    //
    //        let placeholderAttributes: [NSAttributedString.Key: Any] = [
    //            .foregroundColor: UIColor.titleColor,
    //            .font: $0.font!
    //        ]
    //        $0.attributedPlaceholder = NSAttributedString(string: $0.placeholder ?? "", attributes: placeholderAttributes)
    //        $0.autocapitalizationType = .none
    //        return $0
    //    }(UITextField())
    //
    //}
    //TODO: - переделать цвет
    private lazy var strip: UIView = {
        $0.backgroundColor = .yellow
        $0.layer.cornerRadius = 2
        return $0
    }(UIView())

    //TODO: - локализовать и переделать цвет
    private let signUpLabel: UILabel = {
        $0.text = "Sign Up"
        $0.font = .signUpLabelFont
        $0.textColor = .black
        return $0
    }(UILabel())

    // TODO: - локализовать, разобраться с colors
    // Sign Up Button
    private let signUpButton: UIButton = {
        $0.setupButton(CustomButtonType.defaultButton(title: "Sign Up", titleColor: .black, backgroundColor: .yellow))
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
}

// MARK: - SignUpViewControllable

extension SignUpViewController: SignUpViewControllable {
    
}
