//
//  ProfileBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol ProfileDependency {
    var postsService: PostsService { get }
    var myPostsStream: PostsStream { get }
    var coreDataService: CoreDataService { get }
}

final class ProfileComponent: Component<ProfileDependency> {
    override init(dependency: ProfileDependency) {
        self.photoService = PhotoServiceImpl(
            coreDataService: dependency.coreDataService
        )
        super.init(dependency: dependency)
    }
    var photoService: PhotoService
}

extension ProfileComponent: PhotoDependency {
}

protocol ProfileBuildable: Buildable {
    func build() -> ProfileRouting
}

final class ProfileBuilder: Builder<ProfileDependency>, ProfileBuildable {
    func build() -> ProfileRouting {
        let viewController = ProfileViewController()
        let component = ProfileComponent(dependency: dependency)
        let interactor = ProfileInteractor(
            presenter: viewController,
            postsService: dependency.postsService,
            myPostsStream: dependency.myPostsStream,
            photoService: component.photoService
        )
        let photoBuilder = PhotoBuilder(dependency: component)
        return ProfileRouter(
            interactor: interactor,
            viewController: viewController,
            photosBuilder: photoBuilder
        )
    }
}
