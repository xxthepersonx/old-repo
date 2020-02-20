#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.person.sbwy"];

NSBundle *soundsFolder = [NSBundle bundleWithPath:@"/var/mobile/SBWelcomesYou/"];

NSString * soundName = @"sound";
NSString * soundExtension = @"mp3";

%hook SpringBoard
-(void)applicationDidFinishLaunching:(id)application{

if ([prefs boolForKey:@"enabled"]) {

if ([prefs boolForKey:@"customSoundEnabled"]) {

soundName = [prefs objectForKey:@"nameOfSound"];
soundExtension = [prefs objectForKey:@"extOfSound"];

if ([soundName isEqualToString:@""] || [soundExtension isEqualToString:@""]) {

soundName = @"sound";
soundExtension = @"mp3";

}
}

%orig;

[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:NULL];

AVPlayerItem *sound = [AVPlayerItem playerItemWithURL:[soundsFolder URLForResource:soundName withExtension: soundExtension]];

AVPlayer *soundPlayer = [[AVPlayer alloc] initWithPlayerItem:sound];
    soundPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;

[soundPlayer play];

} else {

%orig;
}

}
%end