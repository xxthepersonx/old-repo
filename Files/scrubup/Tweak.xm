@interface MediaControlsTimeControl
@property(nonatomic, assign, readwrite) UIView *knobView;
@end

float sliderSize;

%group hooks

%hook MediaControlsTimeControl

-(void)layoutSubviews {

%orig;

UIView *sliderView = MSHookIvar<UIView *>(self, "_knobView");

[sliderView setFrame:CGRectMake(sliderView.frame.origin.x-(sliderSize/2)+(sliderView.frame.size.width/2), sliderView.frame.origin.y-(sliderSize/2)+(sliderView.frame.size.height/2),sliderSize,sliderSize)];

sliderView.layer.cornerRadius = sliderSize/2;

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
