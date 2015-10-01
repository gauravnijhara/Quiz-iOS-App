//
//  MoreOptionsViewController.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 20/06/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "MoreOptionsViewController.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "iRate.h"
#import <StartApp/StartApp.h>
#import "UIButton+Styling.h"


static int ratingAlertCount = 0;

@interface MoreOptionsViewController ()<MFMailComposeViewControllerDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIView *feedbackVIew;
@property (weak, nonatomic) IBOutlet UIView *creditsView;
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;

@property (strong, nonatomic) FBSDKLikeControl *likeButton;
@property (strong, nonatomic) FBSDKShareButton *shareButton;

@end

@implementation MoreOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.feedbackTextView.layer.borderWidth = 1.0f;
//    self.feedbackTextView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.feedbackTextView.layer.cornerRadius = 5.0f;
    self.feedbackTextView.backgroundColor = [UIColor colorWithRed:243.0/255.0f green:241.0/255.0f blue:143.0/255.0f alpha:1.0];
    self.feedbackTextView.textColor = [UIColor colorWithRed:244.0/255.0f green:97.0/255.0f blue:21.0/255.0f alpha:1.0f];
    
    
    
        
    self.feedbackTextView.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = FALSE;
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (ratingAlertCount < 1) {
        if (![iRate sharedInstance].ratedThisVersion) {
            [[iRate sharedInstance] promptForRating];
        }
        ratingAlertCount++;
    } else {
        
        [STAStartAppAdBasic showAd];

    }
}

- (void)viewDidLayoutSubviews
{
    
    if (!self.likeButton && !self.shareButton) {
        [self addFBShareAndLikeButtons];
            
    }
    
    self.contentViewWidth.constant = self.view.frame.size.width - 45;
    [super viewDidLayoutSubviews];
    
}

- (void)addFBShareAndLikeButtons
{
    CGRect frame;
    
    self.likeButton = [FBSDKLikeControl new];
    self.likeButton.objectID = @"https://www.facebook.com/pages/iPhone-Application-Development/127517843995233";
    frame = self.likeButton.frame;
    frame.origin.y = 50;
    frame.origin.x = 75;
    self.likeButton.frame = frame;
    self.likeButton.enabled = YES;
    [self.shareView addSubview:self.likeButton];
    
    
    self.shareButton = [FBSDKShareButton new];
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"https://www.facebook.com/pages/iPhone-Application-Development/127517843995233"];
    content.contentTitle = @"IQ Test Score";
    content.contentDescription = [NSString stringWithFormat:@"Hey .! Try out this cool app IQ TEST"];
    
    self.shareButton.shareContent = content;
    frame = self.shareButton.frame;
    frame.origin.y = 50;
    frame.origin.x = 200;
    self.shareButton.frame = frame;
    [self.shareView addSubview:self.shareButton];
    
    
    
}
- (IBAction)rateUsBtnPressed:(id)sender {
    
    // rate us button
    
}

- (IBAction)sendFeedbackPressed:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        // Show the composer
        
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setToRecipients:@[@"iqtest.ios@gmail.com"]];
        [controller setSubject:@"Feedback"];
        [controller setMessageBody:self.feedbackTextView.text isHTML:NO];
        if (controller) [self presentViewController:controller animated:YES completion:nil];
        
    } else {
        // Handle the error
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail not configured .!" message:@"Cannot send email" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    [controller dismissViewControllerAnimated:YES completion:^{
        [STAStartAppAdBasic showAd];
    }];
    

    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feedback Sent" message:@"Thanks for reaching out ." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];

    }
    
    if (result == MFMailComposeResultFailed) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error !" message:@"Feedback not sent" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];

    }
    

}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    [textView becomeFirstResponder];
    [self.mainScrollView setContentOffset:CGPointMake(0,self.feedbackVIew.frame.origin.y) animated:YES];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
