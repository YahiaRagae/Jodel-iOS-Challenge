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
import JGProgressHUD

class FeedCollectionViewController:UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var feedCollectionViewModel:FeedCollectionViewModel!
    private let disposeBag = DisposeBag()
    var refreshControl :UIRefreshControl = UIRefreshControl()
    
    var hud:JGProgressHUD!

    
    // MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //init
        feedCollectionViewModel  = FeedCollectionViewModel(delegate: self); 
        
        initViews()
        loadData()
        bind()
    }
    // MARK:- Class Methods
    func initViews(){
        initCollectionView()
        initLoadMoreView()
        
    }
    
    func initCollectionView(){
        //init pull to resfresh
        collectionView.refreshControl =  refreshControl
        refreshControl.addTarget(self, action: #selector(refreshPhotos), for: .valueChanged)

        //init Layout Flow
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = view.bounds.width
            let itemHeight = layout.itemSize.height
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
    }
    
    func initLoadMoreView(){
        collectionView.rx.willDisplayCell.subscribe(onNext: { (cell, indexPath) in
            if(indexPath.row == self.feedCollectionViewModel.getPhotosCount()-1){
                self.loadData()
            }
        }).addDisposableTo(disposeBag)
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
    @objc func refreshPhotos(){
        feedCollectionViewModel.refreshPhotos()
    }
    @IBAction func showSoftAlert(_ sender: Any) {
        let toast =  JGProgressHUD(style: .light)
        toast?.indicatorView = nil
        toast?.position = JGProgressHUDPosition.bottomCenter
        toast?.textLabel.text = "Hint Sample"
        toast?.show(in: view)
        toast?.dismiss(afterDelay: 0.8)
    }
    @IBAction func showHardAlert(_ sender: Any) {
        let alert : UIAlertController = UIAlertController.init(title: "⚠️Alert⚠️", message: "Hard Alert", preferredStyle: .alert)
        let dismissAlertAction = UIAlertAction.init(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(dismissAlertAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
