//
//  AlertPresentable.swift
//  Diploma
//
//  Created by Ульви Пашаев on 08.07.2023.
//

import UIKit

enum AlertActionStyle {

    case standart
    case destructive
    case cancel
}

struct AlertActionViewModel {
    let title: String
    let action: String
    let style: AlertActionStyle
}

struct AlertViewModel {
    let title: String
    var message: String? = nil
    var actions: [AlertActionViewModel] = []
}


protocol AlertPresentable {
    func showAlert(_ viewModel: AlertViewModel)
    func didTapAlertAction(_ action: String)
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(_ viewModel: AlertViewModel) {
        let alertVC = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )

        viewModel.actions.forEach { viewModel in
            let style: UIAlertAction.Style
            switch viewModel.style {
            case .cancel:
                style = .cancel
            case .destructive:
                style = .destructive
            case .standart:
                style = .default
            }

            let action = UIAlertAction(
                title: viewModel.title,
                style: style
            ) { [weak self ] _ in
                self?.didTapAlertAction(viewModel.action)
            }
            alertVC.addAction(action)
        }

        present(alertVC, animated: true)
    }
}
