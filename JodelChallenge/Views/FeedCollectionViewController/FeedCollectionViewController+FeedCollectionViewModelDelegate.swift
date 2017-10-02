//
//  FeedCollectionViewController+FeedCollectionViewModelDelegate.swift
//  JodelChallenge
//
//  Created by Admin on 10/2/17.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
import JGProgressHUD
extension FeedCollectionViewController : FeedCollectionViewModelDelegate{

    func showLoading(msg:String){
        if(hud==nil){
            hud =  JGProgressHUD(style: .light)
        }
        hud.textLabel.text = msg
 
        
        hud.show(in: view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    func hideLoading() {
        if(hud != nil && !hud.isHidden){
            hud.dismiss()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        refreshControl.endRefreshing()
    }
    func showAlert(title:String, msg:String){
        let alert : UIAlertController = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        let dismissAlertAction = UIAlertAction.init(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(dismissAlertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
