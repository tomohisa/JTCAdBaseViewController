//
//  GADAppEventDelegate.h
//  Google Ads iOS SDK
//
//  Copyright (c) 2012 Google Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GADAppEventDelegate <NSObject>

// Implement your app event within this method. The delegate will be notified
// when the SDK receives an app event message from the ad.
- (void)didReceiveAppEvent:(NSString *)name withInfo:(NSString *)info;

@end
