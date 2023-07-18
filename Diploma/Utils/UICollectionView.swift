//
//  UICollectionView.swift
//  Diploma
//
//  Created by Ульви Пашаев on 13.07.2023.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cell: T.Type) {
        register(cell.self, forCellWithReuseIdentifier: cell.identifier)
    }

    func reusableCell<T: UICollectionViewCell>(_ cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            return T.init(frame: .zero)
        }
        return cell
    }
}

