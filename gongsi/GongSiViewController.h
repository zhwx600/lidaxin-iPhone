//
//  GongSiViewController.h
//  lidaxin-iPhone
//
//  Created by apple on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GongSiViewController : UIViewController<UIScrollViewDelegate>
{
    NSMutableArray *viewArr;
    
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
    
    int imageCount;
}
@property (retain, nonatomic) IBOutlet UILabel *m_titleLabel;
@property (retain, nonatomic) IBOutlet UIPageControl *m_pageControl;
@property (retain, nonatomic) IBOutlet UIScrollView *m_scrollView;
@property (retain, nonatomic) IBOutlet UITextView *m_desTextView;
- (IBAction)close:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *m_imageView;
@property (nonatomic,retain)NSString* m_path;

- (IBAction)changePage:(id)sender;
@end
