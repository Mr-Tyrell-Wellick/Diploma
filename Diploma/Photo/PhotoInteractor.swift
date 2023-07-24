//
//  PhotoInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 19.07.2023.
//

import RIBs

protocol PhotoRouting: ViewableRouting {
    
}

protocol PhotoPresentable: Presentable {
    
    var listener: PhotoViewControllerListener? { get set }
}

final class PhotoInteractor: PresentableInteractor<PhotoPresentable>, PhotoInteractable {
    
    weak var router: PhotoRouting?
    
    override init(presenter: PhotoPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        logActivate()
    }
    
    override func willResignActive() {
        logDeactivate()
    }
}

// MARK: - PhotoViewControllerListener

extension PhotoInteractor: PhotoViewControllerListener {
    
}
