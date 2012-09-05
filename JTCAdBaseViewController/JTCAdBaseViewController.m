//
//  JTCAdBaseViewController.m
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

#import "JTCAdBaseViewController.h"
#import <iAd/iAd.h>
#import "GADBannerView.h"

#ifdef DEBUG
#define JTC_LOG(...) NSLog(__VA_ARGS__);
#define JTC_LOG_METHOD NSLog(@"%s", __func__);
#define JTC_LOG_S(...) NSLog(@"%@", __VA_ARGS__)
#else
#define JTC_LOG(...) ;
#define JTC_LOG_METHOD ;
#define JTC_LOG_S(...) ;
#endif


@interface JTCAdBaseViewController () <ADBannerViewDelegate, GADBannerViewDelegate>
@property ADBannerView * iAdBannerView;
@property GADBannerView * gAdBannerView;
@property (readonly) float adHeight;
@end

@implementation JTCAdBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createFirstView];
    [self addChildViewController:_mainViewController];
    _mainViewController.view.frame = self.view.bounds;
    [self.view addSubview:_mainViewController.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(float) adHeight {
    if (_isAdRemoved) {
        return 0;
    }else{
        if (_iAdBannerView.superview) {
            return _iAdBannerView.frame.size.height;
        }
        return 0;
    }
}

#pragma mark - create and destroy
-(void) createFirstView {
    if (_isAdRemoved) {
        [self destroyAllView];
        return;
    }
    if (_adPriority==JTCAdBaseViewAdPriority_iAd) {
        [self create_iAdView];
    }else{
        [self createGAdMobView];
    }
}


-(void) create_iAdView{
    if (_isAdRemoved) {
        [self destroyAllView];
        return;
    }
    CGRect iAdRect;
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        iAdRect.size = [ADBannerView sizeFromBannerContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];
    }else{
        iAdRect.size = [ADBannerView sizeFromBannerContentSizeIdentifier:ADBannerContentSizeIdentifierLandscape];
    }
    if (_adLocation==JTCAdBaseViewAdLocationBottom) {
        iAdRect.origin = CGPointMake(0, CGRectGetMaxY(self.view.bounds));
    }else{
        iAdRect.origin = CGPointMake(0, - iAdRect.size.height);
    }
    _iAdBannerView = [[ADBannerView alloc] initWithFrame:iAdRect];
    if (_adLocation==JTCAdBaseViewAdLocationBottom) {
        _iAdBannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    }else{
        _iAdBannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    _iAdBannerView.delegate = self;
}
-(void) destroy_iAdView{
    [_iAdBannerView removeFromSuperview];
    _iAdBannerView.delegate = nil;
    _iAdBannerView = nil;
}

-(void) destroyAllView {
    [self destroyGADView];
    [self destroy_iAdView];
}

-(void) createGAdMobView{
    if (_isAdRemoved) {
        [self destroyAllView];
        return;
    }
    if (!_GADBannerViewPublisherID || [_GADBannerViewPublisherID isEqualToString:@""]) {
        [self create_iAdView];
    }
    CGRect gadRect;
    GADAdSize gadSize;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        gadSize = kGADAdSizeFullBanner;
        gadRect.size = kGADAdSizeFullBanner.size;
    }else{
        gadSize = kGADAdSizeBanner;
        gadRect.size = kGADAdSizeBanner.size;
    }
    if (_adLocation==JTCAdBaseViewAdLocationBottom) {
        gadRect.origin = CGPointMake((self.view.bounds.size.width - gadRect.size.width) / 2, CGRectGetMaxY(self.view.bounds));
    }else{
        gadRect.origin = CGPointMake((self.view.bounds.size.width - gadRect.size.width) / 2, - gadRect.size.height);
    }
    _gAdBannerView = [[GADBannerView alloc] initWithAdSize:gadSize];
    _gAdBannerView.frame = gadRect;
    _gAdBannerView.adUnitID = self.GADBannerViewPublisherID;
    _gAdBannerView.rootViewController = self;
    if (_adLocation==JTCAdBaseViewAdLocationBottom) {
        _gAdBannerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }else{
        _gAdBannerView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    _gAdBannerView.delegate = self;
    [_gAdBannerView loadRequest:[GADRequest request]];
}
-(void) destroyGADView {
    [_gAdBannerView removeFromSuperview];
    _gAdBannerView.delegate = nil;
    _gAdBannerView = nil;
}


#pragma mark - rotation
- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    JTC_LOG_METHOD;
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)){
        _iAdBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    } else {
        _iAdBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    }
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone && _iAdBannerView.superview) {
        CGSize newSize = [ADBannerView sizeFromBannerContentSizeIdentifier:_iAdBannerView.currentContentSizeIdentifier];
        
        float footerHeight,headerHeight;
        if (_adLocation==JTCAdBaseViewAdLocationBottom) {
            footerHeight = newSize.height;
            headerHeight = 0;
        }else{
            footerHeight = 0;
            headerHeight = newSize.height;
        }
        __weak JTCAdBaseViewController * wself = self;
        [UIView animateWithDuration:duration animations:^{
            wself.mainViewController.view.frame = CGRectMake(0, headerHeight, wself.view.bounds.size.width, wself.view.bounds.size.height - footerHeight - headerHeight);
        } completion:^(BOOL finished) {
            wself.mainViewController.view.frame = CGRectMake(0, headerHeight, wself.view.bounds.size.width, wself.view.bounds.size.height - footerHeight - headerHeight);
        }];

        
    }
    if (_gAdBannerView && !_gAdBannerView.superview) {
        CGRect gadRect;
        GADAdSize gadSize;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            gadSize = kGADAdSizeFullBanner;
            gadRect.size = kGADAdSizeFullBanner.size;
        }else{
            gadSize = kGADAdSizeBanner;
            gadRect.size = kGADAdSizeBanner.size;
        }
        if (_adLocation==JTCAdBaseViewAdLocationBottom) {
            gadRect.origin = CGPointMake((self.view.bounds.size.width - gadRect.size.width) / 2, CGRectGetMaxY(self.view.bounds));
        }else{
            gadRect.origin = CGPointMake((self.view.bounds.size.width - gadRect.size.width) / 2, - gadRect.size.height);
        }
        _gAdBannerView.frame = gadRect;
    }
}
-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    JTC_LOG_METHOD;
}


#pragma mark - ADBannerViewDelegate
// This method is invoked when the banner has confirmation that an ad will be presented, but before the ad
// has loaded resources necessary for presentation.
- (void)bannerViewWillLoadAd:(ADBannerView *)banner __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0){
    JTC_LOG_METHOD;
    
}

// This method is invoked each time a banner loads a new advertisement. Once a banner has loaded an ad,
// it will display that ad until another ad is available. The delegate might implement this method if
// it wished to defer placing the banner in a view hierarchy until the banner has content to display.
- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    JTC_LOG_METHOD;
    if (!_iAdBannerView.superview) {
        [self.view addSubview:banner];
        __weak JTCAdBaseViewController *wself = self;
        
        float footerHeight,headerHeight;
        if (_adLocation==JTCAdBaseViewAdLocationBottom) {
            footerHeight = banner.frame.size.height;
            headerHeight = 0;
        }else{
            footerHeight = 0;
            headerHeight = banner.frame.size.height;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            if (_adLocation==JTCAdBaseViewAdLocationBottom) {
                banner.frame = CGRectMake(wself.view.bounds.origin.x, CGRectGetMaxY(wself.view.bounds)-banner.frame.size.height, banner.frame.size.width, banner.frame.size.height);
            }else{
                banner.frame = CGRectMake(wself.view.bounds.origin.x, CGRectGetMinY(wself.view.bounds), banner.frame.size.width, banner.frame.size.height);
            }
            wself.mainViewController.view.frame = CGRectMake(0, headerHeight, wself.view.bounds.size.width, wself.view.bounds.size.height - footerHeight - headerHeight);
        } completion:^(BOOL finished) {
            wself.mainViewController.view.frame = CGRectMake(0, headerHeight, wself.view.bounds.size.width, wself.view.bounds.size.height - footerHeight - headerHeight);
        }];
    }
    
}

// This method will be invoked when an error has occurred attempting to get advertisement content.
// The ADError enum lists the possible error codes.
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    JTC_LOG_METHOD;
    if (banner.superview) {
        [self destroy_iAdView];
        __weak JTCAdBaseViewController * wself = self;
        [UIView animateWithDuration:0.25 animations:^{
            wself.mainViewController.view.frame = self.view.bounds;
        } completion:^(BOOL finished) {
            wself.mainViewController.view.frame = self.view.bounds;
        }];
    }
    [self destroy_iAdView];
    [self createGAdMobView];
}

// This message will be sent when the user taps on the banner and some action is to be taken.
// Actions either display full screen content in a modal session or take the user to a different
// application. The delegate may return NO to block the action from taking place, but this
// should be avoided if possible because most advertisements pay significantly more when
// the action takes place and, over the longer term, repeatedly blocking actions will
// decrease the ad inventory available to the application. Applications may wish to pause video,
// audio, or other animated content while the advertisement's action executes.
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    JTC_LOG_METHOD;
    return YES;
}

// This message is sent when a modal action has completed and control is returned to the application.
// Games, media playback, and other activities that were paused in response to the beginning
// of the action should resume at this point.
- (void)bannerViewActionDidFinish:(ADBannerView *)banner{
    JTC_LOG_METHOD;

}

#pragma mark - GADBannerViewDelegate
// Sent when an ad request loaded an ad.  This is a good opportunity to add this
// view to the hierarchy if it has not yet been added.  If the ad was received
// as a part of the server-side auto refreshing, you can examine the
// hasAutoRefreshed property of the view.
- (void)adViewDidReceiveAd:(GADBannerView *)view{
    JTC_LOG_METHOD;

    if (!view.superview) {
        [self.view addSubview:view];
        __weak JTCAdBaseViewController *wself = self;
        
        float footerHeight,headerHeight;
        if (_adLocation==JTCAdBaseViewAdLocationBottom) {
            footerHeight = view.frame.size.height;
            headerHeight = 0;
        }else{
            footerHeight = 0;
            headerHeight = view.frame.size.height;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            if (_adLocation==JTCAdBaseViewAdLocationBottom) {
                view.frame = CGRectMake(view.frame.origin.x, CGRectGetMaxY(wself.view.bounds)-view.frame.size.height, view.frame.size.width, view.frame.size.height);
            }else{
                view.frame = CGRectMake(view.frame.origin.x, CGRectGetMinY(wself.view.bounds), view.frame.size.width, view.frame.size.height);
            }
            wself.mainViewController.view.frame = CGRectMake(0, headerHeight, wself.view.bounds.size.width, wself.view.bounds.size.height - footerHeight - headerHeight);
        } completion:^(BOOL finished) {
            wself.mainViewController.view.frame = CGRectMake(0, headerHeight, wself.view.bounds.size.width, wself.view.bounds.size.height - footerHeight - headerHeight);
        }];
    }

}

// Sent when an ad request failed.  Normally this is because no network
// connection was available or no ads were available (i.e. no fill).  If the
// error was received as a part of the server-side auto refreshing, you can
// examine the hasAutoRefreshed property of the view.
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error{
    JTC_LOG_METHOD;
    if (view.superview) {
        __weak JTCAdBaseViewController * wself = self;
        [UIView animateWithDuration:0.25 animations:^{
            wself.mainViewController.view.frame = self.view.bounds;
        } completion:^(BOOL finished) {
            wself.mainViewController.view.frame = self.view.bounds;
        }];
    }
    [self destroyGADView];
    [self create_iAdView];
}

#pragma mark Click-Time Lifecycle Notifications

// Sent just before presenting the user a full screen view, such as a browser,
// in response to clicking on an ad.  Use this opportunity to stop animations,
// time sensitive interactions, etc.
//
// Normally the user looks at the ad, dismisses it, and control returns to your
// application by calling adViewDidDismissScreen:.  However if the user hits the
// Home button or clicks on an App Store link your application will end.  On iOS
// 4.0+ the next method called will be applicationWillResignActive: of your
// UIViewController (UIApplicationWillResignActiveNotification).  Immediately
// after that adViewWillLeaveApplication: is called.
- (void)adViewWillPresentScreen:(GADBannerView *)adView{
    JTC_LOG_METHOD;
    
}

// Sent just before dismissing a full screen view.
- (void)adViewWillDismissScreen:(GADBannerView *)adView{
    JTC_LOG_METHOD;
    
}

// Sent just after dismissing a full screen view.  Use this opportunity to
// restart anything you may have stopped as part of adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(GADBannerView *)adView{
    JTC_LOG_METHOD;
    
}

// Sent just before the application will background or terminate because the
// user clicked on an ad that will launch another application (such as the App
// Store).  The normal UIApplicationDelegate methods, like
// applicationDidEnterBackground:, will be called immediately before this.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView{
    JTC_LOG_METHOD;
    
}



@end
