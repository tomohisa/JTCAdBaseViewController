//
//  JTCAdBaseViewController.h
//  FetalKickCounter
//
//  Created by Tomohisa Takaoka on 9/1/12.
//  Copyright (c) 2012 Tomohisa Takaoka, J-Tech Creations, Inc. All rights reserved.
//
/*
 The MIT License (MIT)
 Copyright (c) 2012 2012 Tomohisa Takaoka, J-Tech Creations, Inc.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#import <UIKit/UIKit.h>

typedef enum  {
    JTCAdBaseViewAdLocationTop = 0,
    JTCAdBaseViewAdLocationBottom = 1,
} JTCAdBaseViewAdLocation;
typedef enum  {
    JTCAdBaseViewAdPriority_iAd = 0,
    JTCAdBaseViewAdPriorityAdMob = 1,
} JTCAdBaseViewAdPriority;
@class JTCAdBaseViewController;
@protocol JTCAdBaseViewControllerDelegate <NSObject>

@optional
-(void) adBaseViewController:(JTCAdBaseViewController*) adBaseViewController willChangeFrameTo:(CGSize)size duration:(float)duration;
@end


@interface JTCAdBaseViewController : UIViewController
@property UIViewController<JTCAdBaseViewControllerDelegate> * mainViewController;
@property BOOL isAdRemoved;
@property JTCAdBaseViewAdLocation adLocation;
@property JTCAdBaseViewAdPriority adPriority;
@property NSString * GADBannerViewPublisherID;
@end
