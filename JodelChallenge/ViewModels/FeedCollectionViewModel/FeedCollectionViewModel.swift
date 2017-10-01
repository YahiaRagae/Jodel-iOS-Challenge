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
    private var pageIndex:NSNumber = 0 ;
    
    // MARK:- Actions
    func loadData(){
        pageIndex = NSNumber(value: pageIndex.intValue + 1)
        
        FlickrApi.fetchPhotos(withPageIndex: pageIndex){(newPhotos, error) in
            
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

