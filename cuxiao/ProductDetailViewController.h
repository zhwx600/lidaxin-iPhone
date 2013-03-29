//
//  ProductDetailViewController.h
//  lidaxin-iPhone
//
//  Created by apple on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanZhanReleaseTableObj.h"
#import "ImageTableObj.h"
#import "ZhanWeiProTableObj.h"


@interface ProductDetailViewController : UIViewController
{
    
}

@property (retain, nonatomic) IBOutlet UIImageView *m_productImageView;
@property (retain, nonatomic) IBOutlet UIScrollView *m_scrollView;

@property (retain,nonatomic) CanZhanReleaseTableObj* m_proObj;
@property (retain,nonatomic) ZhanWeiProTableObj* m_zhanweiproObj;

@property (retain, nonatomic) IBOutlet UILabel *m_titleLabel;

- (IBAction)close:(id)sender;
- (IBAction)applyButtonAct:(id)sender;
- (IBAction)zixunAct:(id)sender;
-(void) initParamScrollView:(NSArray*) arr;

@end
