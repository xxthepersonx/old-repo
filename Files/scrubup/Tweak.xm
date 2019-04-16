#import <UIKit/UIKit.h>

@interface MediaControlsTimeControl
@property(nonatomic, assign, readwrite) UIView *knobView;
@end

NSDictionary *sliderSize = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"/var/mobile/Library/Preferences/com.person.scrubupprefs.plist"]];

NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.person.scrubupprefs"];

%hook MediaControlsTimeControl

-(void)layoutSubviews {


        if ([prefs boolForKey:@"enabled"]) {

%orig;

UIView *sliderView = MSHookIvar<UIView *>(self, "_knobView");

[sliderView setFrame:CGRectMake(sliderView.frame.origin.x-([[sliderSize objectForKey:@"kSize"] floatValue]/2)+(sliderView.frame.size.width/2), sliderView.frame.origin.y-([[sliderSize objectForKey:@"kSize"] floatValue]/2)+(sliderView.frame.size.height/2),[[sliderSize objectForKey:@"kSize"] floatValue],[[sliderSize objectForKey:@"kSize"] floatValue])];

sliderView.layer.cornerRadius = [[sliderSize objectForKey:@"kSize"] floatValue]/2;

        } else {

      %orig;

        }

}

%end
