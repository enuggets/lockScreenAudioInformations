//
//  ViewController.m
//  pocLocScreenControls
//
//  Created by Elodie Durouchoux on 12/09/16.
//  Copyright © 2016 Elodie Durouchoux. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController () {
    AVAudioPlayer *player;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // AVAudioSession *session = [AVAudioSession sharedInstance];
    // [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    [self initResource];
    [[MPRemoteCommandCenter sharedCommandCenter].playCommand addTarget:self action:@selector(playPausePressed:)];
    [[MPRemoteCommandCenter sharedCommandCenter].pauseCommand addTarget:self action:@selector(playPausePressed:)];
    [[MPRemoteCommandCenter sharedCommandCenter].nextTrackCommand addTarget:self action:@selector(resetPlay)];
    [[MPRemoteCommandCenter sharedCommandCenter].previousTrackCommand addTarget:self action:@selector(resetPlay)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playPausePressed:(id)sender {
    
    if( ! player.playing) {
        
        [player play];
        
        [_playPauseButton setTitle:@"PAUSE" forState:UIControlStateNormal];
        
        [self setRemoteInformations ];
    }
    else {
        
        [player pause];
        [_playPauseButton setTitle:@"PLAY" forState:UIControlStateNormal];
    }
}

- (void)initResource {
    
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* track = [bundle pathForResource:@"Reckoner" ofType:@"mp3"];
    NSURL* trackUrl = [NSURL fileURLWithPath: track];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    player = [[AVAudioPlayer alloc] initWithContentsOfURL:trackUrl error:nil];
    [player prepareToPlay];
}

- (void)resetPlay {
    
    player.currentTime = 0;
    [self setRemoteInformations];
    
    if( player.isPlaying ) {
        
        [player stop];
        [player play];
    }
}

-(void)setRemoteInformations {
 
    Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
    
    if (playingInfoCenter) {
        
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        
        MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage: [UIImage imageNamed:@"InRainbows.jpg"]];
        
        [songInfo setObject:@"Reckoner" forKey:MPMediaItemPropertyTitle];
        [songInfo setObject:@"Radiohead" forKey:MPMediaItemPropertyArtist];
        [songInfo setObject:@"In Rainbows" forKey:MPMediaItemPropertyAlbumTitle];
        [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
        [songInfo setObject:[NSString stringWithFormat:@"%f", player.currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        [songInfo setObject:[NSString stringWithFormat:@"%f", player.duration] forKey:MPMediaItemPropertyPlaybackDuration];
        
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
    }
}

@end
