#import <UIKit/UIKit.h>
#import "libcolorpicker.h"

static BOOL enabled = true;
static BOOL hideDock = false;
static int cornerRadius = 15;
static NSString* dockColor = @"#FFFFFF";

static float backgroundViewAlpha;
static UIColor* oldBgColor;
static int oldCornerRadius;

@interface SBWallpaperEffectView : UIView
@end

@interface SBDockView : UIView
@property(retain, nonatomic) SBWallpaperEffectView *_backgroundView;
@end

%hook SBDockView

-(void)setBackgroundAlpha:(double)arg1 {
	// Runs original method
	%orig;
	if(enabled == YES && floatingDock == NO) {
		if (backgroundViewAlpha == nil) {
			backgroundViewAlpha = MSHookIvar<SBWallpaperEffectView*>(self, "_backgroundView").alpha;
		}
		if (oldBgColor == nil) {
			oldBgColor = self.backgroundColor;
		}
		if (oldCornerRadius == nil) {
			oldCornerRadius = self.layer.cornerRadius;
		}
		if(hideDock == YES) {
			//Remove Dock Background
			MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView").alpha = 0.0f;
		} else {
			// Remove SBWallpaperEffectView so we can actually see the dock ;)
  			MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView").alpha = 0.0f;

			//Color Customization
    		self.backgroundColor = LCPParseColorString(dockColor, dockColor);

			//Corner Radius Customization
			self.layer.cornerRadius = cornerRadius;
		} else {
		// Do Nothing
	}
}

%end

static void loadPreferences() {
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.conorthedev.customizemydock.prefbundle.plist"];
	NSLog(@"CustomizeMyDock: reading prefs");
	if (prefs) {
		enabled = [prefs objectForKey:@"Enabled"] ? [[prefs objectForKey:@"Enabled"] boolValue] : enabled;
		hideDock = [prefs objectForKey:@"HideDock"] ? [[prefs objectForKey:@"HideDock"] boolValue] : hideDock;
		cornerRadius = [prefs objectForKey:@"cCornerRadius"] ? [[prefs objectForKey:@"cCornerRadius"] intValue] : cornerRadius;
		dockColor = [prefs objectForKey:@"DockColor"] ? [[prefs objectForKey:@"DockColor"] stringValue] : dockColor;
	}
	[prefs release];
}

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("com.conorthedev.customizemydock.prefbundle/updated"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	loadPreferences();
}