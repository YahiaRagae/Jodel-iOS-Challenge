//
// Created by Dmitry on 14/03/2017.
// Copyright (c) 2017 company. All rights reserved.
//

#import "FlickrApi.h"
#import <UIKit/UIKit.h>
#import <FlickrKit/FlickrKit.h>
#import "JodelChallenge-Swift.h"


@implementation FlickrApi

+ (void)fetchPhotosWithCompletion:(void (^)(NSArray<PhotoItem *> *, NSError *))completion {
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
    
    [fk initializeWithAPIKey:@"92111faaf0ac50706da05a1df2e85d82" sharedSecret:@"89ded1035d7ceb3a"];

    FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
    interesting.per_page = @"10";
    interesting.page = @"1";
    
    [fk call:interesting completion:^(NSDictionary *response, NSError *error) {
        NSMutableArray *photos = nil;
        if (response) {
            photos  = [NSMutableArray array];
            for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
                
                NSString * title = [photoData valueForKey:@"title"];
                NSURL *smallURL = [fk photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
                NSURL *bigURL = [fk photoURLForSize:FKPhotoSizeLarge1024 fromPhotoDictionary:photoData];
                PhotoItem * item = [[PhotoItem alloc]  initWithTitle:title smallImageURL:smallURL bigImageURL:bigURL];
                
                [photos addObject:item];
            }
        }
        if (completion) {
            completion(photos, error);
        }
    }];
}

+ (void)fetchPhotosWithPageIndex:(NSNumber*)pageIndex andCompletion:(void (^)(NSArray<PhotoItem *> *, NSError *))completion {
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
    
    [fk initializeWithAPIKey:@"92111faaf0ac50706da05a1df2e85d82" sharedSecret:@"89ded1035d7ceb3a"];
    
    FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
    interesting.per_page = @"10";
    interesting.page = [NSString stringWithFormat:@"%d",pageIndex.intValue];
    
    [fk call:interesting completion:^(NSDictionary *response, NSError *error) {
        NSMutableArray *photos = nil;
        if (response) {
            photos  = [NSMutableArray array];
            for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
                
                NSString * title = [photoData valueForKey:@"title"];
                NSURL *smallURL = [fk photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
                NSURL *bigURL = [fk photoURLForSize:FKPhotoSizeLarge1024 fromPhotoDictionary:photoData];
                PhotoItem * item = [[PhotoItem alloc]  initWithTitle:title smallImageURL:smallURL bigImageURL:bigURL];
                
                [photos addObject:item];
            }
        }
        if (completion) {
            completion(photos, error);
        }
    }];
}
@end
