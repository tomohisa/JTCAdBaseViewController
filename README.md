JTCAdBaseViewController
=======================
## Description
This ViewController add automatically add iAD and ADMob to the screen and with AddedChildView, viewController resize childview.view.frame depends on the ads size.

## Usage
1. Create subclass of JTCAdBaseViewController
2. in viewDidLoad, add your viewController as mainViewController 
3. Setup Options.

## What's new
12/13/2012 iOS6 Support. to respons rotation, just respond 
- (NSUInteger) supportedOrientaions 
- (UIOrientation) prefferedOrientaion

12/13/2012 XIB sample is in the sample project.

12/13/2012 Tested Autolayout

12/13/2012 Navigation Controller sample made.

``` objective-c
#import "JTCAdBaseViewController.h"
@interface TNCAdBaseViewController : JTCAdBaseViewController
@end
``` 


``` objective-c
- (void)viewDidLoad
{
    self.mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainViewController"];
    //self.adLocation = JTCAdBaseViewAdLocationTop;
    self.adLocation = JTCAdBaseViewAdLocationBottom;
    self.GADBannerViewPublisherID = @"put your Publisher ID";
    // if user purchase ad, you simply put self.isAdRemoved = YES; and Ads doesn't show.
    self.isAdRemoved = NO;
    // if you prefer admob first, put JTCAdBaseViewAdPriorityAdMob
    self.adPriority = JTCAdBaseViewAdPriority_iAd;
//    self.adPriority = JTCAdBaseViewAdPriorityAdMob;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (YES);
}

```

## Options

### adLocation
set up place for Ads (top or bottom)
+ JTCAdBaseViewAdLocationTop
+ JTCAdBaseViewAdLocationBottom

### GADBannerViewPublisherID
set up ADMob Publisher ID. If you don't set this, it only shows iAd.

### isAdRemoved
if you set this YES, ad won't show. you can use this with remove ads in app purchase opthis.

### adPriority
set if which ads (iAd or Admob) has priority (first show.)

### rotation
just responds with shouldAutorotateToInterfaceOrientation in subclass of JTCAdBaseViewController

![With Ads](https://dl.dropbox.com/u/1157820/JTCAdBaseViewController/withAds.png)
![Without Ads](https://dl.dropbox.com/u/1157820/JTCAdBaseViewController/withoutAds.png)

[see sample on Youtube](http://www.youtube.com/watch?v=axE8ckFovRc&feature=youtube_gdata_player)
## License
The MIT License (MIT)
Copyright (c) 2012 2012 Tomohisa Takaoka, J-Tech Creations, Inc.
 
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Contact
please contact twitter [@tomohisa](http://twitter.com/tomohisa) or tomohisa.takaoka [ at ] gmail [ dot ] com
