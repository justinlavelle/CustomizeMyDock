#import <UIKit/UIKit.h>
#import "libcolorpicker.h" // local since it's in or proj folder

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
	if(enabled == YES) {
		if (backgroundViewAlpha == nil) {
			backgroundViewAlpha = MSHookIvar<SBWallpaperEffectView*>(dockView, "_backgroundView").alpha;
		}
		if (oldBgColor == nil) {
			oldBgColor = dockView.backgroundColor;
		}
		if (oldCornerRadius == nil) {
			oldCornerRadius = dockView.layer.cornerRadius;
		}
		if(hideDock == YES) {
			//Remove Dock Background
			MSHookIvar<SBWallpaperEffectView *>(dockView, "_backgroundView").alpha = 0.0f;
		} else {
			// Remove SBWallpaperEffectView so we can actually see the dock ;)
  			MSHookIvar<SBWallpaperEffectView *>(dockView, "_backgroundView").alpha = 0.0f;

			//Color Customization
    		dockView.backgroundColor = LCPParseColorString(dockColor, dockColor);

			//Corner Radius Customization
			dockView.layer.cornerRadius = cornerRadius;
		}
	} else {
		MSHookIvar<SBWallpaperEffectView *>(dockView, "_backgroundView").alpha = backgroundViewAlpha;
		dockView.backgroundColor = oldBgColor;
		dockView.layer.cornerRadius = oldCornerRadius;
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