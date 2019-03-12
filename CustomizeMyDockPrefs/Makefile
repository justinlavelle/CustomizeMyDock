include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CustomizeMyDockPrefs
CustomizeMyDockPrefs_FILES = RDXIPBRootListController.m
CustomizeMyDockPrefs_INSTALL_PATH = /Library/PreferenceBundles
CustomizeMyDockPrefs_FRAMEWORKS = UIKit
CustomizeMyDockPrefs_PRIVATE_FRAMEWORKS = Preferences
CustomizeMyDockPrefs_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/customizemydockprefs.plist$(ECHO_END)
