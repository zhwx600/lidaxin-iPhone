//
//  ProductDetailViewController.m
//  lidaxin-iPhone
//
//  Created by apple on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "DataBase.h"
#import "xmlCommand.h"

#import "ApplyAreaViewController.h"
#import "ChanPinZiXunViewController.h"


@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController
@synthesize m_productImageView;
@synthesize m_scrollView;
@synthesize m_proObj;
@synthesize m_titleLabel;
@synthesize m_zhanweiproObj;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.m_zhanweiproObj = nil;
        self.m_proObj = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ImageTableObj* selectimageobj = nil;
    
    if (self.m_zhanweiproObj) {
        selectimageobj = [DataBase getOneImageTableInfoImageid:self.m_zhanweiproObj.m_showProImageId];
    }else{
        selectimageobj = [DataBase getOneImageTableInfoImageid:self.m_proObj.m_imageId];
    }
    
    NSString* path = [DataProcess getImageFilePathByUrl:selectimageobj.m_imageUrl];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    
    NSLog(@"image.page w = %lf, h=%lf -------",image.size.width,image.size.height);
    
    self.m_productImageView.image = image;
    
    NSArray* temarr = [selectimageobj.m_imageDescription componentsSeparatedByString:PARAM_SPARETESTR];
    
    [self initParamScrollView:temarr];
    
}

- (void)viewDidUnload
{
    [self setM_productImageView:nil];
    [self setM_scrollView:nil];
    [self setM_titleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [m_productImageView release];
    [m_scrollView release];
    [m_titleLabel release];
    [super dealloc];
}



- (IBAction)close:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)applyButtonAct:(id)sender 
{
    ApplyAreaViewController* temAppView = [[ApplyAreaViewController alloc] init];
    
    if (self.m_zhanweiproObj) {
        temAppView.m_zhanweiproObj = self.m_zhanweiproObj;

    }else{
        temAppView.m_proObj = self.m_proObj;
    }

    [self.navigationController pushViewController:temAppView animated:YES];
    [temAppView release];
    
    
}

- (IBAction)zixunAct:(id)sender
{
    ChanPinZiXunViewController* zixunview = [[ChanPinZiXunViewController alloc] init];
    
    if (self.m_zhanweiproObj) {
        zixunview.m_chanPinId = self.m_zhanweiproObj.m_showProId;
    }else{
        zixunview.m_chanPinId = self.m_proObj.m_productId;
    }
    
    
    [self.navigationController pushViewController:zixunview animated:YES];
    [zixunview release];
}

-(void) initParamScrollView:(NSArray*) arr
{
 
    int startVerOff = 220;
    
    for (int i=0; i<arr.count; i++) {
        
        NSString* textstr = [arr objectAtIndex:i];
        UIFont *font =  [UIFont fontWithName:@"Helvetica" size:15.0f];;
        CGSize size = [textstr sizeWithFont:font constrainedToSize:CGSizeMake(278, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(21, startVerOff, size.width, size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentLeft;
        label.font = [UIFont fontWithName:@"Helvetica" size:15.0f];;
        label.textColor = [UIColor whiteColor];
        [label setNumberOfLines:0];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        
        label.text = textstr;
        [self.m_scrollView addSubview:label];
        [label release];
        
        startVerOff += size.height + 9;
        
        NSLog(@"nitParamScrollView: %@",[arr objectAtIndex:i]);
    }
    [self.m_scrollView setContentSize:CGSizeMake(0, startVerOff)];
    
}



@end
