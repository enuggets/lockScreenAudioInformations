//
//  ViewController.h
//  pocLocScreenControls
//
//  Created by Elodie Durouchoux on 12/09/16.
//  Copyright © 2016 Elodie Durouchoux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;

- (void)initResource;
- (IBAction)playPausePressed:(id)sender;

@end
