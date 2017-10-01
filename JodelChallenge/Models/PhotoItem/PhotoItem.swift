//
//  PhotoItem.swift
//  JodelChallenge
//
//  Created by Admin on 10/1/17.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
@objc class PhotoItem : NSObject{
    var title:String
    var smallImageURL:URL
    var bigImageURL:URL
    
    @objc init(title:String , smallImageURL:URL , bigImageURL:URL) {
        self.title  = title
        self.smallImageURL  = smallImageURL
        self.bigImageURL  = bigImageURL
    }
    
}
