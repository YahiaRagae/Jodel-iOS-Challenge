//
//  FeedCollectionViewController.swift
//  JodelChallenge
//
//  Created by Admin on 10/1/17.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class FeedCollectionViewController:UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var feedCollectionViewModel:FeedCollectionViewModel = FeedCollectionViewModel();
    private let disposeBag = DisposeBag()

    
    // MARK:- Life Cycle Methods
    override func viewDidLoad() {
        loadData()
        bind()
    }
    // MARK:- Class Methods
    func loadData(){
        feedCollectionViewModel.loadData()
    }
    private func bind (){
        feedCollectionViewModel.photos.asObservable().bind(to: (collectionView?.rx.items(cellIdentifier: "CollectionCell", cellType: CollectionCell.self))!){
            row, photo, cell in
                cell.setupWithPhoto(url: photo.smallImageURL)
            }.addDisposableTo(disposeBag)
        
    }
    // MARK:- IBAction Methods
    
}
