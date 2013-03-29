//
//  ApplyAreaViewController.m
//  lidaxin-iPhone
//
//  Created by apple on 13-3-12.
//
//

#import "ApplyAreaViewController.h"
#import "DataBase.h"
#import "ImageTableObj.h"
#import "ProTypeTableObj.h"
#import "CanZhanTableObj.h"
#import "CanZhanTableObj.h"
#import "CanZhanReleaseTableObj.h"



@interface ApplyAreaViewController ()

@end

@implementation ApplyAreaViewController
@synthesize m_titleLabel;
@synthesize m_desTextView;
@synthesize m_pageControl;
@synthesize m_scrollView;
@synthesize m_proObj;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [m_titleLabel release];
    [m_desTextView release];
    [m_pageControl release];
    [m_scrollView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setM_titleLabel:nil];
    [self setM_desTextView:nil];
    [self setM_pageControl:nil];
    [self setM_scrollView:nil];
    [super viewDidUnload];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
    self.m_desTextView.text = self.m_proObj.m_changjingDescription;
    
    [self initImageView];
    
    
    
    // a page is the width of the scroll view
    self.m_scrollView.pagingEnabled = YES;
    self.m_scrollView.contentSize = CGSizeMake(self.m_scrollView.frame.size.width * imageCount, self.m_scrollView.frame.size.height);
    self.m_scrollView.showsHorizontalScrollIndicator = NO;
    self.m_scrollView.showsVerticalScrollIndicator = NO;
    self.m_scrollView.scrollsToTop = NO;
    self.m_scrollView.delegate = self;

    self.m_pageControl.numberOfPages = imageCount;
    self.m_pageControl.currentPage = 0;
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    //
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    
    
    
    
    
}




- (IBAction)close:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)moreButton:(id)sender {
}

- (IBAction)pageChangeAct:(id)sender {
    
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


-(void) initImageView
{
    viewArr = [[NSMutableArray alloc] init];
    
    @try {
        NSArray* changjingArr = (NSArray*)[DataBase getOneZChangJingInfoByProductId:self.m_proObj.m_productId];
        
        imageCount = changjingArr.count;

        for (unsigned i = 0; i < imageCount; i++)
        {
            
            ChangJinTableObj* changjingObj = [changjingArr objectAtIndex:i];

            ImageTableObj* imageobj = [DataBase getOneImageTableInfoImageid:changjingObj.m_imageId];
            
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
