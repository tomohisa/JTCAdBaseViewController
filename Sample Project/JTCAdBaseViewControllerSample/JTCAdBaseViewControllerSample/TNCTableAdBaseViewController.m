//
//  TNCTableAdBaseViewController.m
//  AdBaseViewSampleAutolayout
//
//  Created by Tomohisa Takaoka on 12/13/12.
//  Copyright (c) 2012 J-Tech Creations, Inc. All rights reserved.
//

#import "TNCTableAdBaseViewController.h"

@interface TNCTableAdBaseViewController ()

@end

@implementation TNCTableAdBaseViewController

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
    self.mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"table"];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
