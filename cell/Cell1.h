
#import <UIKit/UIKit.h>

@interface Cell1 : UITableViewCell


@property (nonatomic,retain)IBOutlet UILabel *titleLabel;
@property (nonatomic,retain)IBOutlet UIImageView *arrowImageView;
@property (retain, nonatomic) IBOutlet UILabel *m_subTitleLabel;

- (void)changeArrowWithUp:(BOOL)up;
@end
