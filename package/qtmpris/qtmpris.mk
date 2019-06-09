################################################################################
#
# QTMPRIS
#
################################################################################

QTMPRIS_VERSION = origin/master
#QTMPRIS_SITE = $(call github,nemomobile,qtmpris,$(QTMPRIS_VERSION))
QTMPRIS_SITE = https://git.merproject.org/mer-core/qtmpris
#QTMPRIS_SITE = $(call git.merproject.org,mer-core,qtmpris,$(QTMPRIS_VERSION))
QTMPRIS_SITE_METHOD = git
QTMPRIS_LICENSE = GPL-2.0+
QTMPRIS_LICENSE_FILES = COPYING
#QTMPRIS_INSTALL_STAGING = YES
QTMPRIS_DEPENDENCIES = qtdbusextended

#QTMPRIS_CONF_OPTS +=

define QTMPRIS_CONFIGURE_CMDS
    (cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake)
endef

define QTMPRIS_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QTMPRIS_INSTALL_STAGING_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
endef

define QTMPRIS_INSTALL_TARGET_CMDS
    cp -dpf $(BUILD_DIR)/qtmpris-origin_master/src/libmpris-qt5.so* $(STAGING_DIR)/usr/lib
    cp -dpf $(BUILD_DIR)/qtmpris-origin_master/src/pkgconfig/*.pc $(STAGING_DIR)/usr/lib/pkgconfig/.
    mkdir -p $(STAGING_DIR)/usr/include/qt5/MprisQt
    cp -dpf $(BUILD_DIR)/qtmpris-origin_master/src/MprisQt $(STAGING_DIR)/usr/include/qt5/MprisQt/Mpris
    cp -dpf $(BUILD_DIR)/qtmpris-origin_master/src/MprisPlayer $(STAGING_DIR)/usr/include/qt5/MprisQt/.
    cp -dpf $(BUILD_DIR)/qtmpris-origin_master/src/*.h $(STAGING_DIR)/usr/include/qt5/MprisQt/.
    cp -dpf $(STAGING_DIR)/usr/lib/libmpris-qt5.so* $(TARGET_DIR)/usr/lib
endef

$(eval $(generic-package))
