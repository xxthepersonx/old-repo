#import "PrivateFrameworkHeaders.h"

%hook FBSystemServiceOpenApplicationRequest

- (void)setBundleIdentifier:(NSString *)arg1 {
	if([arg1 isEqualToString:@"com.apple.Maps"])
		arg1 = @"com.google.Maps";
	%orig;
}

- (void)setOptions:(FBSOpenApplicationOptions *)arg1 {
	if([[self bundleIdentifier] isEqualToString:@"com.apple.Maps"] || [[self bundleIdentifier] isEqualToString:@"com.google.Maps"]) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
		[dict addEntriesFromDictionary: [arg1 dictionary]];

		NSString *payload = [[dict objectForKey:@"__PayloadURL"] absoluteString];
		payload = [payload substringFromIndex:[payload rangeOfString:@"="].location];

		[dict setObject:[NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?q%@", payload]] forKey:@"__PayloadURL"];

		if(payload) [arg1 setDictionary:dict];
	}

	%orig;
}

%end
