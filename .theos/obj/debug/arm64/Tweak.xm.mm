#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>
#import "libcolorpicker.h" 

@interface SBWallpaperEffectView : UIView
@end

@interface SBDockView : UIView
@property(retain, nonatomic) SBWallpaperEffectView *_backgroundView;
@end

NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.conorthedev.customizemydock.prefbundle.plist"];


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

#line 13 "Tweak.xm"


static void _logos_method$_ungrouped$SBDockView$setBackgroundAlpha$(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, double arg1) {
	
	_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$(self, _cmd, arg1);

	static BOOL enabled = ([[prefs objectForKey:@"Enabled"] boolValue]);
	static BOOL hideDock = ([[prefs objectForKey:@"HideDock"] boolValue]);
	static int cornerRadius = ([[prefs objectForKey:@"cCornerRadius"] intValue]);
	static NSString * dockColor = ([[prefs objectForKey:@"DockColor"] stringValue]);

	if(enabled == YES) {
		if(hideDock == YES) {
			
			MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView").alpha = 0.0f;
		} else {
			
  			MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView").alpha = 0.0f;

			
    		self.backgroundColor = LCPParseColorString(dockColor, dockColor);

			
			self.layer.cornerRadius = cornerRadius;
		}
	}
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBDockView = objc_getClass("SBDockView"); MSHookMessageEx(_logos_class$_ungrouped$SBDockView, @selector(setBackgroundAlpha:), (IMP)&_logos_method$_ungrouped$SBDockView$setBackgroundAlpha$, (IMP*)&_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$);} }
#line 42 "Tweak.xm"
