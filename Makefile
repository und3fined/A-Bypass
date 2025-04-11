export TARGET = iphone:clang:16.5:14.0
export SDK_PATH = $(THEOS)/sdks/iPhoneOS16.5.sdk/
export ARCHS = arm64 arm64e
export SYSROOT = $(SDK_PATH)

# PREFIX="/Library/Developer/TheosToolchains/Xcode11.xctoolchain/usr/bin/"
# STRIP = 0

CURDIR := $(shell pwd)

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = !ABypass2
!ABypass2_FILES = Tweak.xm ABWindow.m
!ABypass2_LIBRARIES = mryipc MobileGestalt

include $(THEOS_MAKE_PATH)/tweak.mk

# after-install::
# 	install.exec "killall -9 SpringBoard"

before-stage::
	find . -name ".DS\_Store" -delete

SUBPROJECTS += abypassprefs
SUBPROJECTS += abypassloader
SUBPROJECTS += ABdyld
SUBPROJECTS += absubloader
include $(THEOS_MAKE_PATH)/aggregate.mk


after-stage::
	@mkdir -p $(THEOS_STAGING_DIR)/usr/lib
	@mv $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/ABDYLD.dylib $(THEOS_STAGING_DIR)/usr/lib/ABDYLD.dylib
	@rm $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/ABDYLD.plist
	@mv $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/ABSubLoader.dylib $(THEOS_STAGING_DIR)/usr/lib/ABSubLoader.dylib
	@rm $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/ABSubLoader.plist
	@./afterProcess.sh $(DEBUG)
