//
//  FeedCollectionViewModel.swift
//  JodelChallenge
//
//  Created by Admin on 10/1/17.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
import RxSwift

protocol FeedCollectionViewModelDelegate: NSObjectProtocol {
    func showLoading(msg:String)
    func hideLoading()
}

class FeedCollectionViewModel: NSObject{
    var photos:Variable<[PhotoItem]> =  Variable<[PhotoItem]>([])
    private var pageIndex:NSNumber = 0 ;
    
    weak  var delegate:FeedCollectionViewModelDelegate!

    init(delegate:FeedCollectionViewModelDelegate) {    
        self.delegate = delegate
    }
    // MARK:- Actions
    func loadData(){
        self.delegate.showLoading(msg: "Loading Images...")
        pageIndex = NSNumber(value: pageIndex.intValue + 1)
        
        FlickrApi.fetchPhotos(withPageIndex: pageIndex){(newPhotos, error) in
            
            if newPhotos != nil {
                DispatchQueue.main.async(execute: {
                    for photo in newPhotos!{
                        self.photos.value.append(  photo)
                    }
                    self.delegate.hideLoading()
                }
                )
            }
        }
    }
    // MARK:- Getters
    
}

