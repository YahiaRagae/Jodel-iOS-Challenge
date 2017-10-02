//
//  FeedCollectionViewModel.swift
//  JodelChallenge
//
//  Created by Admin on 10/1/17.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
import RxSwift
import AXPhotoViewer

protocol FeedCollectionViewModelDelegate: NSObjectProtocol {
    func showLoading(msg:String)
    func hideLoading()
    func showAlert(title:String, msg:String)
}

class FeedCollectionViewModel: NSObject{
    var photos:Variable<[PhotoItem]> =  Variable<[PhotoItem]>([])
    private var pageIndex:NSNumber = 0 ;
    private var isLoadingStatus:Bool = false
    private var isLoadMoreEnabled:Bool = true
    weak  var delegate:FeedCollectionViewModelDelegate!

    init(delegate:FeedCollectionViewModelDelegate) {    
        self.delegate = delegate
    }
    // MARK:- Actions
    func loadData(){
        if(!isLoadingStatus && isLoadMoreEnabled){
            isLoadingStatus = true
            self.delegate.showLoading(msg: "Loading Images...")
            pageIndex = NSNumber(value: pageIndex.intValue + 1)
            
            FlickrApi.fetchPhotos(withPageIndex: pageIndex){(newPhotos, error) in
                DispatchQueue.main.async(execute: {
                    if newPhotos != nil {
                        
                        for photo in newPhotos!{
                            self.photos.value.append(  photo)
                        }
                        if(newPhotos?.count == 0){
                            self.isLoadMoreEnabled = false
                        }
                        
                        
                    }
                    
                    self.delegate.hideLoading()
                    self.isLoadingStatus = false
                    
                    if(error != nil ){
                        self.delegate.showAlert(title: "Error", msg: (error?.localizedDescription)!)
                    }
                })
            }
        }
    }
    // MARK:- Getters
    func refreshPhotos(){
        pageIndex = 0
        isLoadMoreEnabled = true
        loadData()
    }
    func getPhotosCount()->Int{
        return photos.value.count
    }
    func getPhotoPreviewDataSource(selectedIndex:Int)->PhotosDataSource{
        return PhotosDataSource(photos: photos.value, initialPhotoIndex: selectedIndex, prefetchBehavior: .conservative)
    }
}

