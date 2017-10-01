//
//  CollectionCell.swift
//  JodelChallenge
//
//  Created by Admin on 10/1/17.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
class CollectionCell : UICollectionViewCell{ 
    @IBOutlet weak var imageView: UIImageView!

    func setupWithPhoto(url:URL){
        self.imageView.setImageWith(url)
    }
}
