ARCHS = armv7 arm64
TARGET = iphone:clang

include @@THEOS@@/makefiles/common.mk

TWEAK_NAME = @@PROJECTNAME@@
@@PROJECTNAME@@_FILES = @@CLASSPREFIX@@Listener.xm
@@PROJECTNAME@@_LIBRARIES = cephei activator

include $(THEOS_MAKE_PATH)/tweak.mk


@@KILL_RULE@@

SUBPROJECTS += @@PROJECTNAME@@Prefs
include $(THEOS_MAKE_PATH)/aggregate.mk