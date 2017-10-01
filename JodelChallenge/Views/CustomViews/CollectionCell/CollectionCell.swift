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
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewLabelBg: UIView!
 
    
    func setupWithPhoto(photo:PhotoItem){
        showImage(url:photo.smallImageURL)
        showTitle(title:photo.title)
    }
    func showImage(url:URL){
        let imageReauest:URLRequest = URLRequest.init(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        self.imageView.setImageWith(imageReauest, placeholderImage: UIImage(), success: nil, failure: nil)
        
        self.imageView.layer.contentsRect = CGRect(x:  0.25, y: 0.25, width: 0.5, height: 0.5)
    }
    func showTitle(title:String){
        lblTitle.text = title
    }
 
}

