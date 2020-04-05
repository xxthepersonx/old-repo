@interface MediaControlsTimeControl
@property(nonatomic, assign, readwrite) UIView *knobView;
@end

float sliderSize;

%group hooks

%hook MediaControlsTimeControl

-(void)layoutSubviews {

%orig;

UIView *sliderView = MSHookIvar<UIView *>(self, "_knobView");

[sliderView setFrame:CGRectMake(sliderView.frame.origin.x-([[sliderSize objectForKey:@"kSize"] floatValue]/2)+(sliderView.frame.size.width/2), sliderView.frame.origin.y-([[sliderSize objectForKey:@"kSize"] floatValue]/2)+(sliderView.frame.size.height/2),[[sliderSize objectForKey:@"kSize"] floatValue],[[sliderSize objectForKey:@"kSize"] floatValue])];

sliderView.layer.cornerRadius = [[sliderSize objectForKey:@"kSize"] floatValue]/2;

        }

%end
%end

%ctor {

    NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.person.scrubupprefs"];

    if ([prefs boolForKey:@"enabled"]) {
    
    sliderSize = [prefs objectForKey:@"kSize"] floatValue];
    
    %init(hooks);
    
    }



}
