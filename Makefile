GO_EASY_ON_ME=1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CustomizeMyDock
CustomizeMyDock_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += prefbundle
include $(THEOS_MAKE_PATH)/aggregate.mk

CustomizeMyDock_LIBRARIES = colorpicker
