//
//  PhotoItem+AXPhotoViewerProtocol.swift
//  JodelChallenge
//
//  Created by Admin on 10/2/17.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
import AXPhotoViewer

extension PhotoItem : PhotoProtocol{
    var imageData: Data? {
        get {
            return bigImageData
        }
        set(newValue) {
            bigImageData = newValue
        }
    }
    
    var image: UIImage? {
        get {
            return bigImage
        }
        set(newValue) {
            bigImage = newValue
        }
    }
    
    var url: URL? {
        return bigImageURL
    }
    
    var attributedTitle: NSAttributedString?{
        get{
            
            return NSAttributedString(string: title, attributes: [ NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)  ])

        }
    }
}
