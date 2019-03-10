#import <UIKit/UIKit.h>
#import "libcolorpicker.h" // local since it's in or proj folder

@interface SBWallpaperEffectView : UIView
@end

@interface SBDockView : UIView
@property(retain, nonatomic) SBWallpaperEffectView *_backgroundView;
@end

NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.conorthedev.customizemydock.prefbundle.plist"];

%hook SBDockView

-(void)setBackgroundAlpha:(double)arg1 {
	// Runs original method
	%orig;

	static BOOL enabled = ([[prefs objectForKey:@"Enabled"] boolValue]);
	static BOOL hideDock = ([[prefs objectForKey:@"HideDock"] boolValue]);
	static int cornerRadius = ([[prefs objectForKey:@"cCornerRadius"] intValue]);
	static NSString * dockColor = ([[prefs objectForKey:@"DockColor"] stringValue]);

	if(enabled == YES) {
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
		}
	}
}

%end