//
//  ChanPinZiXunViewController.m
//  lidaxin-iPhone
//
//  Created by apple on 12-12-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChanPinZiXunViewController.h"
#import "IDispatcher.h"
#import "HttpProcessor.h"
#import "xmlparser.h"

#import "DataBase.h"
#import "ZhanWeiInfoTableObj.h"

#import "IDispatcher.h"
#import "HttpProcessor.h"
#import "xmlparser.h"

#import "ZiXunYuYueRequestObj.h"


@interface ChanPinZiXunViewController ()

@end

@implementation ChanPinZiXunViewController

@synthesize m_titleLabel;
@synthesize m_gongsimingchengLabel;
@synthesize m_lianxirenField;
@synthesize m_emailField;
@synthesize m_beizhuView;
@synthesize m_scrollView;
@synthesize m_chanPinId;
@synthesize m_alertCommitView;

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
    // Do any additional setup after loading the view from its nib.
    [self.m_scrollView setContentSize:CGSizeMake(320, 416)];
    [self initInputView];
    
    if (!self.m_alertCommitView) {
        self.m_alertCommitView = [[UIAlertView alloc] initWithTitle:@"Upgrade tips" message:@"Data is being submitted, please do not exit the program.\r\n" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        UIActivityIndicatorView* actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        CGRect rect = [actView frame];
        rect.origin = CGPointMake(130, 108);
        actView.frame = rect;
        [self.m_alertCommitView addSubview:actView];
        
        [actView startAnimating];
        
        
        
        [actView release];
    }

}

- (void)viewDidUnload
{
    [self setM_titleLabel:nil];
    [self setM_gongsimingchengLabel:nil];
    [self setM_lianxirenField:nil];
    [self setM_emailField:nil];
    [self setM_beizhuView:nil];
    [self setM_scrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField       // return NO to disallow editing.
{
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.m_gongsimingchengLabel == textField) {

//            self.m_scrollView.frame = CGRectMake(0, 44, 320, 460-44);
//            [self.m_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            
        }else if(self.m_lianxirenField == textField){
            
        }else if(self.m_emailField == textField){
            
        }
        self.m_scrollView.frame = CGRectMake(0, 44, 320, 460-44);
        [self.m_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
//    if (self.m_scrollView.frame.size.height >= 460-44) {
//        
//    }else {
//        self.m_scrollView.frame = CGRectMake(0, 44, 320, 460-44-246);
//    }
//    self.m_scrollView.frame = CGRectMake(0, 44, 320, 460-44);
//    [self.m_scrollView setContentOffset:CGPointMake(0, 120) animated:YES];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        if (self.m_scrollView.frame.size.height >= 460-44) {
            self.m_scrollView.frame = CGRectMake(0, 44, 320, 460-44-246);
        }
        [self.m_scrollView setContentOffset:CGPointMake(0, 180) animated:YES];        
    } completion:^(BOOL finished) {
        
    }];
    
}


- (IBAction)commitAct:(id)sender 
{
    if (self.m_gongsimingchengLabel.text.length <= 0 || self.m_lianxirenField.text.length<=0
        || self.m_emailField.text.length <= 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Some information input is empty!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 0;
        [alert show];
        [alert release];
        return;
    }
    
    [self.m_alertCommitView show];
    
    ZiXunYuYueRequestObj* temzixun = [[ZiXunYuYueRequestObj alloc] init];
    temzixun.m_proId = self.m_chanPinId;
    temzixun.m_company = self.m_gongsimingchengLabel.text;
    
    temzixun.m_contact = self.m_lianxirenField.text;
    temzixun.m_email = self.m_emailField.text;
    temzixun.m_description = self.m_beizhuView.text;
    
    NSString* str = [MyXMLParser EncodeToStr:temzixun Type:@"proinquiry"];
    [temzixun release];
    
    NSLog(@"proinquiry str = %@",str);
    
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveZiXunData:)];
    http.m_recResult = NO;
    [http threadFunStart];
    
    [http release];
    
}



-(void) receiveZiXunData:(NSData*) data;
{
    [self.m_alertCommitView dismissWithClickedButtonIndex:0 animated:YES];
    if (data) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Submitted to the Advisory success!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1;
        [alert show];
        [alert release];
        
        NSLog(@"receiveZiXunData  success!");
        
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Commit failed, please try again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 0;
        [alert show];
        [alert release];
        NSLog(@"receiveZiXunData  faile!");
    }
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        [self closeIme:nil];
        [self close:nil];
    }else{
        
    }
}

- (IBAction)closeIme:(id)sender 
{
    if (self.m_scrollView.frame.size.height <= 460-44-246) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.m_scrollView.frame = CGRectMake(0, 44, 320, 460-44);
            [self.m_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        } completion:^(BOOL finished) {
            
        }];
    }
    
    [self.m_gongsimingchengLabel resignFirstResponder]; 
    [self.m_lianxirenField resignFirstResponder];  
    [self.m_emailField resignFirstResponder];  
    [self.m_beizhuView resignFirstResponder];  
}

-(void) initInputView
{
    
    UIView* topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    topview.backgroundColor = [UIColor clearColor];
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(285, 0, 30, 30)];
    [button setBackgroundImage:[UIImage imageNamed:@"closeime.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(closeIme:) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:button]; 
    [button release];
    [self.m_gongsimingchengLabel setInputAccessoryView:topview];
    
    [self.m_lianxirenField setInputAccessoryView:topview];
    
    [self.m_emailField setInputAccessoryView:topview];
    
    [self.m_beizhuView setInputAccessoryView:topview];
    [topview release];
}

- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [m_titleLabel release];
    [m_gongsimingchengLabel release];
    [m_lianxirenField release];
    [m_emailField release];
    [m_beizhuView release];
    [m_scrollView release];
    [m_alertCommitView release];
    [super dealloc];
}





@end

