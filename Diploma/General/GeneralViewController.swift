//
//  GeneralViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs
import UIKit
import TinyConstraints
import RxSwift
import RxGesture

protocol GeneralViewControllerListener: AnyObject {
    
}

final class GeneralViewController: UIViewController {
    
    weak var listener: GeneralViewControllerListener?
}


// MARK: - GeneralPresentable

extension GeneralViewController: GeneralPresentable {
    
    
}

// MARK: - GeneralViewControllable

extension GeneralViewController: GeneralViewControllable {
    
}
