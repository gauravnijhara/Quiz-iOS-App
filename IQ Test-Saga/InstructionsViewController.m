//
//  InstructionsViewController.m
//  IQ Test-Saga
//
//  Created by Gaurav Nijhara on 31/05/15.
//  Copyright (c) 2015 Gaurav Nijhara. All rights reserved.
//

#import "InstructionsViewController.h"

static NSString* IQInstructions = @"Test your IQ (Intelligent Quotient) on a timed test of 15 questions! The question set will change each time you attempt the test. You, your friends and your family can take the test unlimited times and we will provide you unique questions each time! ;)\n\nIf you are unsure about your answer to a question, you can review it later by checking the 'Mark for Review' button.\n\nThere is a 'REVIEW' button which helps you to keep a track of your progress. It directs you to a page where you can easily see the questions you have not attempted and the questions which have been marked by you for further review when you were unsure about an answer! \n\nPress the 'SUBMIT' button only after you have attempted all the questions and double-checked them (if you have enough time). Pressing the button will direct you to the 'RESULT' page where you can see a complete analysis of the test and the correct 'ANSWERS' to all the questions. Make sure that you utilise this feature to improve your errors in the future.\nYou can share the result with your Facebook friends and challenge them :)\n\nAlso, you can see the date, time and score of your previous tests in the 'HISTORY' page. You can easily keep a track of each performance relative to previous or last test taken. Our aim is to ignite the gray cells of your brain and keep them active :)\n\nBe Warned! 'Time and tide wait for none.' You have only 10 minutes to attempt a test containing 15 questions!! The timer is always ticking.";

static NSString* IQRFInstructions = @"Are you hungry for tricky, mind-sizzling questions? Or you think that you are unbeatable? \n\nThen 'Unleash the BEAST' inside you! Show us if you have what it takes to be called a true GENIUS!\n\nCheck whether you can handle our 'IQ Rapid Fire' and for how long! \n\nEvery level there will be a question which has to be answered correctly within a minute. If you are unable to submit within a minute, then we will automatically consider the option which you have marked as your answer.\n\nFor every correct answer, you proceed to the next level where we continue to dare you ;)\n\nGive a wrong answer and it's GAME OVER!! Your streak is over, you were beaten and you have to start afresh from Level 1 next time. There is no scope for a single error!! The aim is to make you proficient in adaptive tests (like GRE, GMAT, CAT, etc) in an entertaining and challenging way :)\nAlso, you can see the date, time and score of your previous tests in the 'HISTORY' page. You can always keep a track of your performance :)\n\nGet a decent, unbeatable high score and Challenge your friends on Facebook :)\n\nBeware! the timer is always ticking.";


@implementation InstructionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.iqTestBtn setSelected:YES];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [self.iqTestBtn setTitle:@"IQ TEST" forState:UIControlStateNormal];
    [self.iqRapidFireBtn setTitle:@"RAPID FIRE" forState:UIControlStateNormal];
    
    [self.iqTestBtn setTitleColor:[UIColor colorWithRed:241.0/255.0 green:126.0/255.0 blue:34.0/255.0 alpha:1.0] forState:UIControlStateSelected];
    [self.iqTestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.iqTestBtn setBackgroundColor:[UIColor whiteColor]];
    self.iqTestBtn.layer.borderWidth = 1.0f;
    self.iqTestBtn.layer.cornerRadius = 14.0f;
    self.iqTestBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [self.iqRapidFireBtn setTitleColor:[UIColor colorWithRed:241.0/255.0 green:126.0/255.0 blue:34.0/255.0 alpha:1.0] forState:UIControlStateSelected];
    [self.iqRapidFireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];


    [self.instructionsTextView setText:IQInstructions];
    [self.instructionsTextView setTextColor:[UIColor whiteColor]];
    [self.instructionsTextView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.1]];
    [self.instructionsTextView setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16.0f]];
}

- (IBAction)toggleInstructions:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    
    
    
    if (button.tag == 0) {
        if (!self.iqTestBtn.selected) {
            [self.iqTestBtn setSelected:YES];
            [self.iqRapidFireBtn setSelected:NO];
            [self.instructionsTextView setText:IQInstructions];
            [self.instructionsTextView setTextColor:[UIColor whiteColor]];
            
            [self.iqTestBtn setBackgroundColor:[UIColor whiteColor]];
            self.iqTestBtn.layer.borderWidth = 1.0f;
            self.iqTestBtn.layer.cornerRadius = 14.0f;
            self.iqTestBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
            
            [self.iqRapidFireBtn setBackgroundColor:[UIColor clearColor]];
            self.iqRapidFireBtn.layer.borderWidth = 0.0f;
            self.iqRapidFireBtn.layer.cornerRadius = 14.0f;
            self.iqRapidFireBtn.layer.borderColor = [[UIColor whiteColor] CGColor];

            


        }
        
    } else {
        if (!self.iqRapidFireBtn.selected) {
            [self.iqTestBtn setSelected:NO];
            [self.iqRapidFireBtn setSelected:YES];
            [self.instructionsTextView setText:IQRFInstructions];
            [self.instructionsTextView setTextColor:[UIColor whiteColor]];
            
            [self.iqTestBtn setBackgroundColor:[UIColor clearColor]];
            self.iqTestBtn.layer.borderWidth = 0.0f;
            self.iqTestBtn.layer.cornerRadius = 14.0f;
            self.iqTestBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
            
            [self.iqRapidFireBtn setBackgroundColor:[UIColor whiteColor]];
            self.iqRapidFireBtn.layer.borderWidth = 1.0f;
            self.iqRapidFireBtn.layer.cornerRadius = 14.0f;
            self.iqRapidFireBtn.layer.borderColor = [[UIColor whiteColor] CGColor];


        }
    }
    
    [self.instructionsTextView setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16.0f]];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
