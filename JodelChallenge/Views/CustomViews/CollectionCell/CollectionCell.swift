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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    func setupWithPhoto(photo:PhotoItem){
        showImage(url:photo.smallImageURL)
        showTitle(title:photo.title)
    }
    func showImage(url:URL){
        self.imageView.image = UIImage()
        let imageReauest:URLRequest = URLRequest.init(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        self.activityIndicator.startAnimating()
        self.imageView.setImageWith(imageReauest, placeholderImage: nil, success:  { (reuqest, response, image) in
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
            self.imageView.layer.contentsRect = CGRect(x:  0.2, y: 0.2, width: 0.7, height: 0.7)
        }, failure: nil)
        
        
    }
    func showTitle(title:String){
        lblTitle.text = title
    }
 
}

