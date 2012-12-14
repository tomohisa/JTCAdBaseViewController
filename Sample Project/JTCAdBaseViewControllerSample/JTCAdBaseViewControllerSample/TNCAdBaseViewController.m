//
//  TNCAdBaseViewController.m
//  JTCAdBaseViewControllerSample
//
//  Created by Tomohisa Takaoka on 9/4/12.
//  Copyright (c) 2012 J-Tech Creations, Inc. All rights reserved.
//

#import "TNCAdBaseViewController.h"

@interface TNCAdBaseViewController ()

@end

@implementation TNCAdBaseViewController

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
    self.mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainViewController"];
    self.adLocation = JTCAdBaseViewAdLocationBottom;
    // uncomment this and put your publisher ID to activate adMob
    self.GADBannerViewPublisherID = @"your publisher id";
    self.GADBannerViewPublisherID = @"a14e93dc3d720f9";
    // if user purchase ad, you simply put self.isAdRemoved = YES; and Ads doesn't show.
    self.isAdRemoved = NO;
    // if you prefer admob first, put JTCAdBaseViewAdPriorityAdMob
    self.adPriority = JTCAdBaseViewAdPriority_iAd;
//    self.adPriority = JTCAdBaseViewAdPriorityAdMob;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
