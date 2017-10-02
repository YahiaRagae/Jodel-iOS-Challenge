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
    }
}
