//
//  ApplyAreaViewController.h
//  lidaxin-iPhone
//
//  Created by apple on 13-3-12.
//
//

#import <UIKit/UIKit.h>
#import "CanZhanReleaseTableObj.h"
#import "ZhanWeiProTableObj.h"

@interface ApplyAreaViewController : UIViewController<UIScrollViewDelegate>{

    NSMutableArray *viewArr;
    
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
    
    int imageCount;
}

@property (retain, nonatomic) IBOutlet UILabel *m_titleLabel;
@property (retain, nonatomic) IBOutlet UITextView *m_desTextView;
@property (retain, nonatomic) IBOutlet UIPageControl *m_pageControl;
@property (retain, nonatomic) IBOutlet UIScrollView *m_scrollView;
@property (retain, nonatomic) CanZhanReleaseTableObj* m_proObj;
@property (retain,nonatomic) ZhanWeiProTableObj* m_zhanweiproObj;

- (IBAction)close:(id)sender;
- (IBAction)moreButton:(id)sender;
- (IBAction)pageChangeAct:(id)sender;

-(void) initImageView;
-(void) initImageViewForZhanwei;

@end
