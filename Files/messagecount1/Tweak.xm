NSString * plistStringValue;

int messagesSent;

%hook SMSApplication

- (void)_messageSent:(id)arg1 {

%orig;

messagesSent ++;

[[NSUserDefaults standardUserDefaults] setObject:[@(messagesSent) stringValue] forKey:@"NumberOfSentMessages"];
[[NSUserDefaults standardUserDefaults] synchronize];

}

%end

%hook CKMessageEntryContentView

- (void)setPlaceholderText:(NSString *)arg1 {

NSString * newText = [NSString stringWithFormat:@"Sent Messages - %d", messagesSent];

%orig(newText);

}
%end

%ctor {

plistStringValue = [[NSUserDefaults standardUserDefaults]
    stringForKey:@"NumberOfSentMessages"];

messagesSent = [plistStringValue intValue];

}
