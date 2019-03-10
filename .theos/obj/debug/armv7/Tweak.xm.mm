#line 1 "Tweak.xm"
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


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBDockView; 
static void (*_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$)(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST, SEL, double); static void _logos_method$_ungrouped$SBDockView$setBackgroundAlpha$(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST, SEL, double); 

#line 20 "Tweak.xm"


static void _logos_method$_ungrouped$SBDockView$setBackgroundAlpha$(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, double arg1) {
	
	_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$(self, _cmd, arg1);
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
			
			MSHookIvar<SBWallpaperEffectView *>(dockView, "_backgroundView").alpha = 0.0f;
		} else {
			
  			MSHookIvar<SBWallpaperEffectView *>(dockView, "_backgroundView").alpha = 0.0f;

			
    		dockView.backgroundColor = LCPParseColorString(dockColor, dockColor);

			
			dockView.layer.cornerRadius = cornerRadius;
		}
	} else {
		MSHookIvar<SBWallpaperEffectView *>(dockView, "_backgroundView").alpha = backgroundViewAlpha;
		dockView.backgroundColor = oldBgColor;
		dockView.layer.cornerRadius = oldCornerRadius;
	}	
}



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

static __attribute__((constructor)) void _logosLocalCtor_bbe4a825(int __unused argc, char __unused **argv, char __unused **envp) {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("com.conorthedev.customizemydock.prefbundle/updated"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	loadPreferences();
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBDockView = objc_getClass("SBDockView"); MSHookMessageEx(_logos_class$_ungrouped$SBDockView, @selector(setBackgroundAlpha:), (IMP)&_logos_method$_ungrouped$SBDockView$setBackgroundAlpha$, (IMP*)&_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$);} }
#line 73 "Tweak.xm"
