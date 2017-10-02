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
import AXPhotoViewer
class FeedCollectionViewController:UIViewController,UICollectionViewDelegate{
    
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
    func showImagePreview(indexPath:IndexPath){
        let dataSource = feedCollectionViewModel.getPhotoPreviewDataSource(selectedIndex:indexPath.row)
        let pagingConfig:PagingConfig = PagingConfig(interPhotoSpacing: 2)
        let currentCell:CollectionCell = collectionView.cellForItem(at: indexPath) as! CollectionCell
        
        let transitionInfo = TransitionInfo(interactiveDismissalEnabled: true, startingView: currentCell.imageView) { [weak self] (photo, index) -> UIImageView? in
            guard let uSelf = self else {
                return nil
            }
            
            let indexPath = IndexPath(row: index, section: 0)
            guard let cell = uSelf.collectionView.cellForItem(at: indexPath) else {
                return nil
            }
            
            // adjusting the reference view attached to our transition info to allow for contextual animation
            return cell.contentView.viewWithTag(666) as? FLAnimatedImageView
        }
        
        
        let photosViewController = PhotosViewController(dataSource: dataSource, pagingConfig: pagingConfig, transitionInfo: transitionInfo)
        
        self.present(photosViewController, animated: true)
    }
    // MARK:- UICollectionViewDelegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showImagePreview(indexPath:indexPath)
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
        showAlert(title:"⚠️Alert⚠️", msg:"Hard Alert")
    }
}

