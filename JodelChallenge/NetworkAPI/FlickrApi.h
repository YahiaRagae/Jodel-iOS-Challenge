//
// Created by Dmitry on 14/03/2017.
// Copyright (c) 2017 company. All rights reserved.
//


#import <Foundation/Foundation.h>
@class PhotoItem;

@interface FlickrApi : NSObject
+ (void)fetchPhotosWithCompletion:(void (^)(NSArray<PhotoItem *> *, NSError *))completion ;
+ (void)fetchPhotosWithPageIndex:(NSNumber*)pageIndex andCompletion:(void (^)(NSArray<PhotoItem *> *, NSError *))completion ;


@end
