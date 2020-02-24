#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>



NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.person.sbwy"];

NSBundle *soundsFolder = [NSBundle bundleWithPath:@"/var/mobile/SBWelcomesYou/"];

NSString * soundNameRaw = [prefs objectForKey:@"soundFromList"];

NSString * soundName = [[soundNameRaw lastPathComponent] stringByDeletingPathExtension];
NSString * soundExtension = [soundNameRaw pathExtension];


%hook SpringBoard
-(void)applicationDidFinishLaunching:(id)application{

if ([prefs boolForKey:@"enabled"]) {


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