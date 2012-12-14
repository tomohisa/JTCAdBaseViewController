//
//  TNCViewController.m
//  JTCAdBaseViewControllerSample
//
//  Created by Tomohisa Takaoka on 9/4/12.
//  Copyright (c) 2012 J-Tech Creations, Inc. All rights reserved.
//

#import "TNCViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TNCViewController ()

@end

@implementation TNCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.layer.borderWidth = 2;
    self.view.layer.borderColor = [UIColor greenColor].CGColor;
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

// return this to specify which orientation to support.
- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


// return this to specify which orientation were to preffered at start
// notice: this won't call for rootview controller.
// specify at info.plist for launch Orientation.
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

@end
