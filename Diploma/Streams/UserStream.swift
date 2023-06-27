//
//  UserStream.swift
//  Diploma
//
//  Created by Ульви Пашаев on 23.06.2023.
//

import RxSwift
import RxRelay

protocol UserStream {
    var user: Observable<User?> { get }
}

protocol UserMutableStream: UserStream {
    func updateUser(_ user: User)
    func clearUser()
}

final class UserMutableStreamImpl: UserMutableStream {

    func updateUser(_ user: User) {
        userVariable.accept(user)
    }

    func clearUser() {
        userVariable.accept(nil)
    }

    var user: Observable<User?> {
        userVariable.asObservable()
    }

    private var userVariable = BehaviorRelay<User?>(value: nil)
}
