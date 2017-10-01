//
//  FeedCollectionViewModel.swift
//  JodelChallenge
//
//  Created by Admin on 10/1/17.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
import RxSwift
class FeedCollectionViewModel: NSObject{
    var photos:Variable<[PhotoItem]> =  Variable<[PhotoItem]>([])
    
    // MARK:- Actions
    func loadData(){
        FlickrApi.fetchPhotos { (newPhotos, error) in
            
            if newPhotos != nil {
                DispatchQueue.main.async(execute: {
                    for photo in newPhotos!{
                        self.photos.value.append(  photo)
                    }
                }
                )
            }
        }
    }
    // MARK:- Getters
    
}

