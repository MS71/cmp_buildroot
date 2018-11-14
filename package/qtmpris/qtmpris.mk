################################################################################
#
# QTMPRIS
#
################################################################################

QTMPRIS_VERSION = master
QTMPRIS_SITE = $(call github,nemomobile,qtmpris,$(QTMPRIS_VERSION))
QTMPRIS_LICENSE = GPL-2.0+
QTMPRIS_LICENSE_FILES = COPYING
QTMPRIS_INSTALL_STAGING = YES
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
#        $(QT5_LA_PRL_FILES_FIXUP)
endef

$(eval $(generic-package))