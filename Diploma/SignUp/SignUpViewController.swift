//
//  SignUpViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 06.06.2023.
//

import Foundation
import UIKit
import TinyConstraints

protocol SignUpViewControllerListener: AnyObject {

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

    // MARK: - Functions
    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackViewTextField)

        stackViewTextField.addArrangedSubview(line)
        stackViewTextField.addArrangedSubview(logInTextField)
        stackViewTextField.addArrangedSubview(passwordTextField)
    }

    //TODO: - ДОПИСАТЬ!!!
    func addConstraints() {

    }

    // MARK: - Properties
    // scrollView
    private lazy var scrollView: UIScrollView = {
        return $0
    }(UIScrollView())

    // stackView
    private let stackViewTextField: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .equalCentering
        $0.alignment = .center
        $0.backgroundColor = .stackViewTextFieldColor
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0.5
        return $0
    }(UIStackView())

    // Line
    private lazy var line: UIView = {
        $0.backgroundColor = .lineColor
        $0.layer.cornerRadius = 8
        return $0
    }(UIView())

    //sign Up
    private let signUpLabel: UILabel = {
        $0.text = "already have an account"
        $0.textColor = .titleColor
        return $0
    }(UILabel())


    // LogInTextField
    private let logInTextField: UITextField = {
        $0.placeholder = "Email"
        $0.textColor = .black
        $0.keyboardType = .emailAddress
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.font = .systemFont(ofSize: 16)

        let imageView = UIImageView(image: UIImage(named: "envelope"))
        imageView.contentMode = .center
        imageView.frame.size = CGSize(width: 16, height: $0.frame.height)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: $0.frame.height))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        $0.leftView = containerView
        $0.leftViewMode = .always

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.titleColor,
            .font: $0.font!
        ]
        $0.attributedPlaceholder = NSAttributedString(string: $0.placeholder ?? "", attributes: placeholderAttributes)
        $0.autocapitalizationType = .none
        return $0
    }(UITextField())

    // PasswordTextField
    private let passwordTextField: UITextField = {
        $0.placeholder = "Password"
        $0.textColor = .black
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry = true
        $0.font = .systemFont(ofSize: 16)

        let imageView = UIImageView(image: UIImage(named: "at"))
        imageView.contentMode = .center
        imageView.frame.size = CGSize(width: 16, height: $0.frame.height)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: $0.frame.height))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        $0.leftView = containerView
        $0.leftViewMode = .always

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.titleColor,
            .font: $0.font!
        ]
        $0.attributedPlaceholder = NSAttributedString(string: $0.placeholder ?? "", attributes: placeholderAttributes)
        $0.autocapitalizationType = .none
        return $0
    }(UITextField())

}


// MARK: - SignUpPresentable

extension SignUpViewController: SignUpPresentable {

}

// MARK: - SignUpViewControllable

extension SignUpViewController: SignUpViewControllable {
    
}
