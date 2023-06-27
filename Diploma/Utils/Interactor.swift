//
//  Interactor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import RIBs

extension Interactable {
    func logActivate() {
        print("Activated RIB: \(String(describing: self))")
    }

    func logDeactivate() {
print("Deactivated RIB: \(String(describing: self))")
    }
}
