//
//  PhotoCollectionViewCell.swift
//  Diploma
//
//  Created by Ульви Пашаев on 22.07.2023.
//

import UIKit
import TinyConstraints

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(galleryImage)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func addConstraints()  {
        galleryImage.edges(to: self)
    }
    
    func configurePhoto(with photoImage: UIImage?) {
        galleryImage.image = photoImage
    }
    
    // MARK: - Properties
    
    private lazy var galleryImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
}
