################################################################################
#
# QTDBUSEXTENDED
#
################################################################################

QTDBUSEXTENDED_VERSION = master
QTDBUSEXTENDED_SITE = $(call github,nemomobile,qtdbusextended,$(QTDBUSEXTENDED_VERSION))
QTDBUSEXTENDED_LICENSE = GPL-2.0+
QTDBUSEXTENDED_LICENSE_FILES = COPYING
QTDBUSEXTENDED_INSTALL_STAGING = YES
#QTDBUSEXTENDED_DEPENDENCIES = 

#QTDBUSEXTENDED_CONF_OPTS +=

define QTDBUSEXTENDED_CONFIGURE_CMDS
    (cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake)
endef

define QTDBUSEXTENDED_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QTDBUSEXTENDED_INSTALL_STAGING_CMDS
        $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
#        $(QT5_LA_PRL_FILES_FIXUP)
endef

$(eval $(generic-package))
