@interface ZBConsoleViewController {

    BOOL respringRequired;
    BOOL zebraRestartRequired;

}

@property (nonatomic, assign, readwrite) BOOL respringRequired;
@property (nonatomic, assign, readwrite) BOOL zebraRestartRequired;

- (void)updateCompleteButton;
- (void)restartSpringBoard;
- (void)close;
- (void)closeZebra;
@end

%hook ZBConsoleViewController

-(void) updateCompleteButton {

BOOL *needRespring = MSHookIvar<BOOL *>(self, "respringRequired");

BOOL *needZebraRestart = MSHookIvar<BOOL *>(self, "zebraRestartRequired");

if (needRespring) {

[self restartSpringBoard];

}

else if (needZebraRestart) {

[self closeZebra];

}

else {

[self close];

 }

}

%end
