//
//  AppDelegate.swift
//  Diploma
//
//  Created by Ульви Пашаев on 02.06.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if !CommandLine.arguments.contains("-stub") {
            configureFirebase()
            IQKeyboardManager.shared.enable = true
        }
        return true
    }

    func configureFirebase() {
        guard let firebasePlistFileName = Bundle.main.infoDictionary?["GOOGLE_SERVICE_INFO_PLIST"] as? String,
              let path = Bundle.main.path(forResource: firebasePlistFileName, ofType: "plist"),
              let firebaseOptions = FirebaseOptions(contentsOfFile: path) else {
            return
        }
        FirebaseApp.configure(options: firebaseOptions)
    }
}
