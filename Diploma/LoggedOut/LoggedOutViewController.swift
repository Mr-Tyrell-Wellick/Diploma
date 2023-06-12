//
//  LoggedOutViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 05.06.2023.
//

import RIBs
import UIKit
import TinyConstraints

protocol LoggedOutViewControllerListener: AnyObject {

}

final class LoggedOutViewController: UIViewController {

    weak var listener: LoggedOutViewControllerListener?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .loggedOutBackgroundColor
        addView()
        addConstraints()
    }

    // MARK: - Functions
    func addView() {
        view.addSubview(logoImage)
        view.addSubview(signUpButton)
        view.addSubview(loginButton)
    }

    func addConstraints() {
        logoImage.top(to: view, offset: 124)
        logoImage.centerX(to: view)
        logoImage.width(300)
        logoImage.height(300)

        signUpButton.topToBottom(of: logoImage, offset: 80)
        signUpButton.centerX(to: view)
        signUpButton.height(50)
        signUpButton.leading(to: view, offset: 53)

        loginButton.topToBottom(of: signUpButton, offset: 80)
        loginButton.centerX(to: view)
    }

    // MARK: - Properties

    // лого
    private lazy var logoImage: UIImageView = {
        $0.image = UIImage(named: "loginLogo")
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

}
    // MARK: - LoggedOutPresentable

    extension LoggedOutViewController: LoggedOutPresentable {

    }

    // MARK: - LoggedOutViewControllable

    extension LoggedOutViewController: LoggedOutViewControllable {

    }
