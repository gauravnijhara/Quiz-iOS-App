
#import "ModalReviewPanel.h"
#import "TestCardView.h"

#define BLACK_BAR_COMPONENTS				{ 0, 0, 0, 0, 0, 0, 0, 0 }
#define kiPhone6Height 667
#define kiPhone6Width  375
#define kDeviceScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kDeviceScreenWidth [[UIScreen mainScreen] bounds].size.width

@implementation ModalReviewPanel


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
	if ((self = [super initWithFrame:frame])) {
		
		self.headerLabel.text = title;
		
		
		////////////////////////////////////
		// RANDOMLY CUSTOMIZE IT
		////////////////////////////////////
		// Show the defaults mostly, but once in awhile show a completely random funky one
        // Funky time.
        UADebugLog(@"Showing a randomized panel for modalPanel: %@", self);
        
        // Margin between edge of container frame and panel. Default = {20.0, 20.0, 20.0, 20.0}
        
        // Margin between edge of panel and the content area. Default = {20.0, 20.0, 20.0, 20.0}
        
        // Border color of the panel. Default = [UIColor whiteColor]
        
        // Border width of the panel. Default = 1.5f;
        
        // Corner radius of the panel. Default = 4.0f
        
        // Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
       // self.contentColor = [UIColor colorWithRed:255.0/255.0f green:255.0/255.0f blue:204.0/255.0f alpha:1.0];
        self.contentColor = [UIColor colorWithRed:252.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
        
//        UIImage *img = [UIImage imageNamed:@"notebookpage.jpg"];
//        CGSize imgSize = frame.size;
//        
//        UIGraphicsBeginImageContext( imgSize );
//        [img drawInRect:CGRectMake(0,0,imgSize.width,imgSize.height)];
//        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//
//        
//        self.contentColor = [UIColor colorWithPatternImage:newImage];

        // Shows the bounce animation. Default = YES
        self.shouldBounce = YES;
        
        CGFloat colors[8] = {0, 0, 0, 0, 0, 0, 0, 0};
        [self.titleBar setColorComponents:colors];

        // Height of the title view. Default = 40.0f
        [self setTitleBarHeight:30.0f];
        
        // The background color gradient of the title
        
        // The gradient style (Linear, linear reversed, radial, radial reversed, center highlight). Default = UAGradientBackgroundStyleLinear
        [[self titleBar] setGradientStyle:(2)];
        
        // The line mode of the gradient view (top, bottom, both, none). Top is a white line, bottom is a black line.
        [[self titleBar] setLineMode:UAGradientLineModeNone];
        
        [[self titleBar] setBackgroundColor:[UIColor clearColor] ];
        // The header label, a UILabel with the same frame as the titleBar
        [self headerLabel].font = [UIFont boldSystemFontOfSize:floor(self.titleBarHeight / 2.0)];

        self.headerLabel.textColor = [UIColor blackColor];
        
        
        self.questionsList = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height)];
        self.questionsList.dataSource = self;
        self.questionsList.delegate = self;
        self.questionsList.backgroundColor = [UIColor clearColor];
        [self.questionsList setContentInset:UIEdgeInsetsMake(15, 0, 0, 0)];
        [self.questionsList setSeparatorColor:[UIColor clearColor]];
        [self.contentView addSubview:self.questionsList];
	}	
	return self;
}

- (void)setupView
{
    [self.questionsList reloadData];
}

- (void)layoutSubviews {
    
	[super layoutSubviews];
    
    [self.questionsList setFrame:self.contentView.bounds];


}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questions count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 35.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSString *cellIdentifier = @"ModalPanelCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
	
    cell.backgroundColor = [UIColor clearColor];
    //cell.contentView.layer.borderWidth = 0.5f;
    [cell.textLabel setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:14*kDeviceScreenWidth/kiPhone6Width]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:14*kDeviceScreenWidth/kiPhone6Width]];
    [cell.detailTextLabel setTextColor:[UIColor whiteColor]];
    [cell.detailTextLabel setText:@"Not Marked"];
	[cell.textLabel setText:[NSString stringWithFormat:@"Question no: %ld", (long)indexPath.row + 1]];
	
    TestCardView *card = (TestCardView*)[self.questions objectAtIndex:indexPath.row];
    
    NSString *text;
    if (card.isMarked) {
        text = @"Answered";
        
    } else {
        text = @"Not Marked";
    }
    
    if (card.isMarkedForReview){
        
        NSString *pad = [text stringByPaddingToLength:text.length+1 withString:@"/" startingAtIndex:0];
        [cell.detailTextLabel setText:[pad stringByAppendingString:@"Review"]];
        
    }
    else {
        [cell.detailTextLabel setText:text];
    }
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.reviewDelegate) {
        [self.reviewDelegate questionSelectedAtIndex:indexPath.row];
    }
    [self removeFromSuperview];
}

#pragma mark - Actions

@end
