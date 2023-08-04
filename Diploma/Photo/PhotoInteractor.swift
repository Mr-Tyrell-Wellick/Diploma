//
//  PhotoInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 19.07.2023.
//

import RIBs
import RxRelay
import RxSwift
import UIKit

struct PhotoGalleryViewModel {
    let image: UIImage
}

protocol PhotoRouting: ViewableRouting {
}

protocol PhotoPresentable: Presentable {

    func showViewModel(_ viewModel: [PhotoGalleryViewModel])
    func showLoadingIndicator(_ show: Bool)
    var listener: PhotoViewControllerListener? { get set }
}

protocol PhotoListener: AnyObject {
    func photoDidClose()
}

final class PhotoInteractor: PresentableInteractor<PhotoPresentable>, PhotoInteractable {
    
    weak var router: PhotoRouting?
    weak var listener: PhotoListener?
    
     init(
        presenter: PhotoPresentable,
        photoService: PhotoService
     ) {
         self.photoService = photoService
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        logActivate()
        subscribeOnUiReady()
    }
    
    override func willResignActive() {
        logDeactivate()
    }

    private func subscribeOnUiReady() {
        uiReady
            .filter { $0 }
            .do(onNext: { [unowned self] _ in
                presenter.showLoadingIndicator(true)
            })
            .flatMapLatest { [unowned self] _ in
                photoService.getPhotos()
            }
            .map { $0.map { PhotoGalleryViewModel(image: $0) } }
            .do(onNext: { [unowned self] _ in
                presenter.showLoadingIndicator(false)
            })
            .bind { [unowned self] images in
                presenter.showViewModel(images)
            }
            .disposeOnDeactivate(interactor: self)
    }

    private let photoService: PhotoService
    private let uiReady = BehaviorRelay<Bool>(value: false)
}

// MARK: - PhotoViewControllerListener

extension PhotoInteractor: PhotoViewControllerListener {

    func viewDidAppear() {
        uiReady.accept(true)
    }

    func viewDidDissappear() {
        listener?.photoDidClose()
    }
}
