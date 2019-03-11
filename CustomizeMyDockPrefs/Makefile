include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CustomizeMyDockPrefs
customizemydockprefs_FILES = RDXIPBRootListController.m
customizemydockprefs_INSTALL_PATH = /Library/PreferenceBundles
customizemydockprefs_FRAMEWORKS = UIKit
customizemydockprefs_PRIVATE_FRAMEWORKS = Preferences
customizemydockprefs_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/customizemydockprefs.plist$(ECHO_END)
