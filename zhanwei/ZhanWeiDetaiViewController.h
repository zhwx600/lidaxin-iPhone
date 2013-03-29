//
//  ZhanWeiDetaiViewController.h
//  lidaxin-iPhone
//
//  Created by zheng wanxiang on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanZhanTableObj.h"

@interface ZhanWeiDetaiViewController  : UIViewController<UIScrollViewDelegate>{
    
    NSMutableArray *viewArr;
    
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
    
    int imageCount;
}

@property (retain, nonatomic) IBOutlet UILabel *m_titleLabel;
@property (retain, nonatomic) IBOutlet UITextView *m_desTextView;
@property (retain, nonatomic) IBOutlet UIPageControl *m_pageControl;
@property (retain, nonatomic) IBOutlet UIScrollView *m_scrollView;
@property (retain, nonatomic) CanZhanTableObj* m_proObj;


- (IBAction)close:(id)sender;
- (IBAction)moreButton:(id)sender;
- (IBAction)pageChangeAct:(id)sender;



@end
