//
//  UIImage.swift
//  Diploma
//
//  Created by Ульви Пашаев on 20.06.2023.
//

import UIKit

extension UIImage {

    // MARK: - LoggedOut Screen
    
    // Logo
    class var logoImage: UIImage {
        UIImage(named: "loginLogo") ?? UIImage()
    }
    
    // FaceID
    class var faceIDImage: UIImage {
        UIImage(named: "faceid") ?? UIImage()
    }
    
    // TextFieldImage
    class var atImage: UIImage {
        UIImage(named: "at") ?? UIImage()
    }
    
    class var lockImage: UIImage {
        UIImage(named: "lock") ?? UIImage()
    }
    
    
    // MARK: - SignUp Screen
    
    class var launchImage: UIImage {
        UIImage(named: "launchScreen") ?? UIImage()
    }

    // MARK: - TabBar
    
    class var homeTabBarImage: UIImage {
        UIImage(named: "home") ?? UIImage()
    }
    
    class var profileTabBarImage: UIImage {
        UIImage(named: "profile") ?? UIImage()
    }
    
    class var favoritesTabBarImage: UIImage {
        UIImage(named: "favorites") ?? UIImage()
    }

    // MARK: - Profile Screen

    class var arrowImage: UIImage {
        UIImage(named: "arrow") ?? UIImage()
    }

    class var heartFillImage: UIImage {
        UIImage(named: "heart.fill") ?? UIImage()
    }

    class var heartImage: UIImage {
        UIImage(named: "heart") ?? UIImage()
    }

    class var avatarImage: UIImage {
        UIImage(named: "Lalo") ?? UIImage()
    }

    // MARK: - User photos

    class var friendOneImage: UIImage {
        UIImage(named: "friend1") ?? UIImage()
    }

    class var friendTwoImage: UIImage {
        UIImage(named: "friend2") ?? UIImage()
    }

    class var friendThreeImage: UIImage {
        UIImage(named: "friend3") ?? UIImage()
    }

    class var friendFourImage: UIImage {
        UIImage(named: "friend4") ?? UIImage()
    }

    class var friendFiveImage: UIImage {
        UIImage(named: "friend5") ?? UIImage()
    }

    class var friendSixImage: UIImage {
        UIImage(named: "friend6") ?? UIImage()
    }


    // MARK: - Authors Post photos

    class var dogImage: UIImage {
        UIImage(named: "dog") ?? UIImage()
    }

    class var bengalCatImage: UIImage {
        UIImage(named: "bengalCat") ?? UIImage()
    }

    class var catsImage: UIImage {
        UIImage(named: "cats") ?? UIImage()
    }

    class var houseImage: UIImage {
        UIImage(named: "house") ?? UIImage()
    }

    class var dolphinImage: UIImage {
        UIImage(named: "dolphin") ?? UIImage()
    }

    class var lakeImage: UIImage {
        UIImage(named: "lake") ?? UIImage()
    }


    // MARK: - Gallery photos

    class var galleryOneImage: UIImage {
        UIImage(named: "gallery1") ?? UIImage()
    }

    class var galleryTwoImage: UIImage {
        UIImage(named: "gallery2") ?? UIImage()
    }

    class var galleryThreeImage: UIImage {
        UIImage(named: "gallery3") ?? UIImage()
    }

    class var galleryFourImage: UIImage {
        UIImage(named: "gallery4") ?? UIImage()
    }

    class var galleryFiveImage: UIImage {
        UIImage(named: "gallery5") ?? UIImage()
    }

    class var gallerySixImage: UIImage {
        UIImage(named: "gallery6") ?? UIImage()
    }

    class var gallerySevenImage: UIImage {
        UIImage(named: "gallery7") ?? UIImage()
    }

    class var galleryEightImage: UIImage {
        UIImage(named: "gallery8") ?? UIImage()
    }

    class var galleryNineImage: UIImage {
        UIImage(named: "gallery9") ?? UIImage()
    }

    class var galleryTenImage: UIImage {
        UIImage(named: "gallery10") ?? UIImage()
    }

    // MARK: My posts

    class var myPostOneImage: UIImage {
        UIImage(named: "myPostOne") ?? UIImage()
    }

    class var myPostTwoImage: UIImage {
        UIImage(named: "myPostTwo") ?? UIImage()
    }

    class var myPostThreeImage: UIImage {
        UIImage(named: "myPostThree") ?? UIImage()
    }
}
