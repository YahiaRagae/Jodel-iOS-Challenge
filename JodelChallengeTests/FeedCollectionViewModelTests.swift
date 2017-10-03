//
//  FeedCollectionViewModelTests.swift
//  JodelChallengeTests
//
//  Created by Admin on 10/3/17.
//  Copyright © 2017 Jodel. All rights reserved.
//
import XCTest

@testable import JodelChallenge

class DelegateStub:NSObject,FeedCollectionViewModelDelegate{
    func showLoading(msg: String) {
        
    }
    func hideLoading() {
        
    }
    func showAlert(title: String, msg: String) {
        
    }
}


class FeedCollectionViewModelTests: XCTestCase
{
    var delegateStub:DelegateStub!
    
    var exepetion:XCTestExpectation!
    
    
    override func setUp() {
        super.setUp()
        
        delegateStub = DelegateStub ()
        exepetion = self.expectation(description: "Items count are less than the minimum count")
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMinimumItemsCountReturnedFromServer() {
        
        let minCount = 10 ;
        let mv: FeedCollectionViewModel =  FeedCollectionViewModel(delegate: delegateStub)
        
        let _ = mv.photos.asObservable().subscribe(onNext: { results in
            //NSLog("results.count : \(results.count)")
            if(results.count >= minCount){
                self.exepetion.fulfill()
            }
        })
        
        mv.loadData()
        self.wait(for: [exepetion], timeout: 10)
    }
    
}

