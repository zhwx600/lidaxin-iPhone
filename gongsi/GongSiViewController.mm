//
//  GongSiViewController.m
//  lidaxin-iPhone
//
//  Created by apple on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GongSiViewController.h"
#import "GongSiImageTableObj.h"
#import "ImageTableObj.h"
#import "DataBase.h"
#import "xmlCommand.h"

@interface GongSiViewController ()

@end

@implementation GongSiViewController
@synthesize m_imageView;
@synthesize m_titleLabel;
@synthesize m_pageControl;
@synthesize m_scrollView;
@synthesize m_desTextView;
@synthesize m_path;

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
    
    
}

- (void)viewDidUnload
{
    [self setM_titleLabel:nil];
    [self setM_imageView:nil];
    [self setM_pageControl:nil];
    [self setM_scrollView:nil];
    [self setM_desTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void) tapInView
{

    UIApplication *application = [UIApplication sharedApplication];  
    [application openURL:[NSURL URLWithString:@"http://www.leedarson.com"]]; 
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImage* image = [UIImage imageWithContentsOfFile:self.m_path];
    self.m_imageView.image = image;

    NSArray* temarr = [DataBase getAllGongSiTableObj];
    if (temarr && temarr.count>0) {
        GongSiImageTableObj* gongsiobj = [temarr objectAtIndex:0];

        self.m_desTextView.text = [[gongsiobj.m_companyDescription stringByReplacingOccurrencesOfString:PARAM_SPARETESTR withString:@"\n"] stringByReplacingOccurrencesOfString:PARAM_KONGGE withString:@" "];
        
        NSLog(@"des:%@",self.m_desTextView.text);
        
        //self.m_desTextView.text = @"des:Tel: 86-592-3699963 Fax: 86-592-3988108 Web: http://www.leedarson.com/";
    }
    
    [self initImageView];
    
    
    
    // a page is the width of the scroll view
    self.m_scrollView.pagingEnabled = YES;
    self.m_scrollView.contentSize = CGSizeMake(self.m_scrollView.frame.size.width * imageCount, self.m_scrollView.frame.size.height);
    self.m_scrollView.showsHorizontalScrollIndicator = NO;
    self.m_scrollView.showsVerticalScrollIndicator = NO;
    self.m_scrollView.scrollsToTop = NO;
    self.m_scrollView.delegate = self;
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView)];
    
    [self.m_scrollView addGestureRecognizer:gesture];
    [gesture release];
    
    self.m_pageControl.numberOfPages = imageCount;
    self.m_pageControl.currentPage = 0;
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    //
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    
    
    
    
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [m_titleLabel release];
    [m_imageView release];
    [m_pageControl release];
    [m_scrollView release];
    [m_desTextView release];
    [viewArr release];
    
    [super dealloc];
}
- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



-(void) initImageView
{
    viewArr = [[NSMutableArray alloc] init];
    NSString* imageStr = nil;
    
    imageStr = @"videoModel_%d.png";
    
    @try {
        NSArray* imageArr = [DataBase getAllGongSiTableObj];
        imageCount = imageArr.count;
        
        
        
        
        for (unsigned i = 0; i < imageCount; i++)
        {
            
            GongSiImageTableObj* gongsiobj = [imageArr objectAtIndex:i];
            ImageTableObj* imageobj = [DataBase getOneImageTableInfoImageid:gongsiobj.m_companyImageId];

            NSString* path = [DataProcess getImageFilePathByUrl:imageobj.m_imageUrl];
            UIImage* image = [UIImage imageWithContentsOfFile:path];
            
            UIImageView* wwView = [[UIImageView alloc] initWithImage:image];
            [wwView setFrame:self.m_scrollView.frame];
            wwView.tag = i;
            [viewArr addObject:wwView];
            [wwView release];
            
           // self.m_desTextView.text = imageobj.m_imageDescription;
            
        }

        
    }
    @catch (NSException *exception) {
        imageCount = 0;
    }
    @finally {
        
    }
    
}


- (IBAction)changePage:(id)sender 
{
    int page = self.m_pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = self.m_scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.m_scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
    
}





- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= imageCount)
        return;
    
    // replace the placeholder if necessary
    UIImageView* temview = [viewArr objectAtIndex:page];
    // add the controller's view to the scroll view
    if (temview.superview == nil)
    {
        CGRect frame = self.m_scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        temview.frame = frame;
        [self.m_scrollView addSubview:temview];
        //        
        //        NSDictionary *numberItem = [self.contentList objectAtIndex:page];
        //        controller.numberImage.image = [UIImage imageNamed:[numberItem valueForKey:ImageKey]];
        //        controller.numberTitle.text = [numberItem valueForKey:NameKey];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.m_scrollView.frame.size.width;
    
    
    //下取整
    int page = floor((self.m_scrollView.contentOffset.x + pageWidth / 2) / pageWidth);
    self.m_pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    NSLog(@"contentOffset = %f, page = %d",self.m_scrollView.contentOffset.x,page);
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}




@end
