#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>
#import "libcolorpicker.h" 

static BOOL enabled = true;
static BOOL hideDock = false;
static BOOL floatingDock = false;
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

@class SBFloatingDockController; @class SBDockView; 
static void (*_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$)(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST, SEL, double); static void _logos_method$_ungrouped$SBDockView$setBackgroundAlpha$(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST, SEL, double); static BOOL (*_logos_meta_orig$_ungrouped$SBFloatingDockController$isFloatingDockSupported)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static BOOL _logos_meta_method$_ungrouped$SBFloatingDockController$isFloatingDockSupported(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static BOOL (*_logos_orig$_ungrouped$SBFloatingDockController$_systemGestureManagerAllowsFloatingDockGesture)(_LOGOS_SELF_TYPE_NORMAL SBFloatingDockController* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$_ungrouped$SBFloatingDockController$_systemGestureManagerAllowsFloatingDockGesture(_LOGOS_SELF_TYPE_NORMAL SBFloatingDockController* _LOGOS_SELF_CONST, SEL); 

#line 21 "Tweak.xm"


static void _logos_method$_ungrouped$SBDockView$setBackgroundAlpha$(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, double arg1) {
	
	_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$(self, _cmd, arg1);
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
			
			MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView").alpha = 0.0f;
		} else {
			
  			MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView").alpha = 0.0f;

			
    		self.backgroundColor = LCPParseColorString(dockColor, dockColor);

			
			self.layer.cornerRadius = cornerRadius;
		}
	} else if(floatingDock == YES){
		  	MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView").alpha = 0.0f;

			
    		self.backgroundColor = LCPParseColorString(dockColor, dockColor);

			
			self.layer.cornerRadius = cornerRadius;
	} else {
		
	}
}




static BOOL _logos_meta_method$_ungrouped$SBFloatingDockController$isFloatingDockSupported(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return floatingDock;
}

static BOOL _logos_method$_ungrouped$SBFloatingDockController$_systemGestureManagerAllowsFloatingDockGesture(_LOGOS_SELF_TYPE_NORMAL SBFloatingDockController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return NO;
}


static void loadPreferences() {
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.conorthedev.customizemydock.prefbundle.plist"];
	NSLog(@"CustomizeMyDock: reading prefs");
	if (prefs) {
		enabled = [prefs objectForKey:@"Enabled"] ? [[prefs objectForKey:@"Enabled"] boolValue] : enabled;
		hideDock = [prefs objectForKey:@"HideDock"] ? [[prefs objectForKey:@"HideDock"] boolValue] : hideDock;
		cornerRadius = [prefs objectForKey:@"cCornerRadius"] ? [[prefs objectForKey:@"cCornerRadius"] intValue] : cornerRadius;
		dockColor = [prefs objectForKey:@"DockColor"] ? [[prefs objectForKey:@"DockColor"] stringValue] : dockColor;
		floatingDock = [prefs objectForKey:@"FloatingDock"] ? [[prefs objectForKey:@"FloatingDock"] boolValue] : floatingDock;
	}
	[prefs release];
}

static __attribute__((constructor)) void _logosLocalCtor_d6d2aec7(int __unused argc, char __unused **argv, char __unused **envp) {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("com.conorthedev.customizemydock.prefbundle/updated"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	loadPreferences();
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBDockView = objc_getClass("SBDockView"); MSHookMessageEx(_logos_class$_ungrouped$SBDockView, @selector(setBackgroundAlpha:), (IMP)&_logos_method$_ungrouped$SBDockView$setBackgroundAlpha$, (IMP*)&_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$);Class _logos_class$_ungrouped$SBFloatingDockController = objc_getClass("SBFloatingDockController"); Class _logos_metaclass$_ungrouped$SBFloatingDockController = object_getClass(_logos_class$_ungrouped$SBFloatingDockController); MSHookMessageEx(_logos_metaclass$_ungrouped$SBFloatingDockController, @selector(isFloatingDockSupported), (IMP)&_logos_meta_method$_ungrouped$SBFloatingDockController$isFloatingDockSupported, (IMP*)&_logos_meta_orig$_ungrouped$SBFloatingDockController$isFloatingDockSupported);MSHookMessageEx(_logos_class$_ungrouped$SBFloatingDockController, @selector(_systemGestureManagerAllowsFloatingDockGesture), (IMP)&_logos_method$_ungrouped$SBFloatingDockController$_systemGestureManagerAllowsFloatingDockGesture, (IMP*)&_logos_orig$_ungrouped$SBFloatingDockController$_systemGestureManagerAllowsFloatingDockGesture);} }
#line 91 "Tweak.xm"
