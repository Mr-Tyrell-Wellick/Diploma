//
//  TabBarModel.swift
//  Diploma
//
//  Created by Ульви Пашаев on 05.06.2023.
//

import Foundation
import UIKit

// для удобства использования создаем структуру с TabBarItem
struct TabBarItems {
    static var items = [
    UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0),
    UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 1)
    ]
}
