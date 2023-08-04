//
//  UITableView.swift
//  Diploma
//
//  Created by Ульви Пашаев on 15.07.2023.
//

import UIKit

extension UITableView {
    
    // MARK: - Cells
    
    func registerCell<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }
    
    func dequeuCell<Cell: UITableViewCell>(_ type: Cell.Type, indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? Cell ?? Cell()
    }
}
