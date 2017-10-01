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
        initViews()
        loadData()
        bind()
    }
    // MARK:- Class Methods
    func initViews(){
        //init Collection View layout
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = view.bounds.width 
            let itemHeight = layout.itemSize.height
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
    }
    
    func loadData(){
        feedCollectionViewModel.loadData()
    }
    private func bind (){
        feedCollectionViewModel.photos.asObservable().bind(to: (collectionView?.rx.items(cellIdentifier: "CollectionCell", cellType: CollectionCell.self))!){
            row, photo, cell in
            cell.setupWithPhoto(photo: photo)
            }.addDisposableTo(disposeBag)
        
    }
    // MARK:- IBAction Methods
    
}
