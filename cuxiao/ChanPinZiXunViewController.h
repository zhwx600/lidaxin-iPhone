//
//  ChanPinZiXunViewController.h
//  lidaxin-iPhone
//
//  Created by apple on 12-12-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChanPinZiXunViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *m_titleLabel;
@property (retain, nonatomic) IBOutlet UITextField *m_gongsimingchengLabel;
@property (retain, nonatomic) IBOutlet UITextField *m_lianxirenField;
@property (retain, nonatomic) IBOutlet UITextField *m_emailField;
@property (retain, nonatomic) IBOutlet UITextView *m_beizhuView;

@property (retain, nonatomic) IBOutlet UIScrollView *m_scrollView;

@property (nonatomic,retain)NSString* m_chanPinId;
@property (nonatomic,retain)UIAlertView* m_alertCommitView;

- (IBAction)commitAct:(id)sender;

- (IBAction)closeIme:(id)sender ;
- (IBAction)close:(id)sender;
-(void) initInputView;

-(void) receiveZiXunData:(NSData*) data;

@end
