//
//  GeneralInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol GeneralRouting: ViewableRouting {

}

protocol GeneralPresentable: Presentable {
     
    var listener: GeneralViewControllerListener? { get set }
}


final class GeneralInteractor: PresentableInteractor<GeneralPresentable>, GeneralInteractable {

    weak var router: GeneralRouting?

    override init(presenter: GeneralPresentable) {
        super.init(presenter: presenter)
    }
}


// MARK: - GeneralViewControllerListener
extension GeneralInteractor: GeneralViewControllerListener {
    
}
