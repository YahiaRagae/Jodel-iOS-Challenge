//
//  FeedCollectionViewController.swift
//  JodelChallenge
//
//  Created by Admin on 10/1/17.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation

class FeedCollectionViewController:UICollectionViewController{
    var photos:[PhotoItem] = [PhotoItem]()
    // MARK:- Life Cycle Methods

    override func viewDidLoad() {
        FlickrApi.fetchPhotos { (photos, error) in
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
            })
            
            self.photos = photos!   
        }
    }
    // MARK:- Class Methods
    
    // MARK:- UICollectionViewController DataSource Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count;
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        let photo:PhotoItem = self.photos[ indexPath.row]
        cell.setupWithPhoto(url: photo.smallImageURL)
        
        return cell;
    }
    // MARK:- IBAction Methods
    
}
