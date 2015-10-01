

#import "UATitledModalPanel.h"

@protocol ReviewDelegate

@required
-(void)questionSelectedAtIndex:(NSUInteger)index;
@end

@interface ModalReviewPanel : UATitledModalPanel <UITableViewDataSource,UITableViewDelegate> {
}

@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, strong) UITableView *questionsList;
@property (nonatomic, weak) id<ReviewDelegate> reviewDelegate;

- (void)setupView;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title NS_DESIGNATED_INITIALIZER;
- (IBAction)buttonPressed:(id)sender;

@end
