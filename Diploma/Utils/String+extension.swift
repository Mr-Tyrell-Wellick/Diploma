//
//  String+extension.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import Foundation

extension String {
    func localizedString() -> String {
        NSLocalizedString(self, comment: "")
    }
}
