#include "RDXIPBRootListController.h"

@implementation RDXIPBRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

- (void)respring {
    NSTask *t = [[[NSTask alloc] init] autorelease];
    [t setLaunchPath:@"/usr/bin/killall"];
    [t setArguments:[NSArray arrayWithObjects:@"SpringBoard", nil]];
    [t launch];
}

- (void)supportShow {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.patreon.com/ConorTheDev"]];
}
- (void)websiteShow {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://conorthedev.com"]];
}

@end
