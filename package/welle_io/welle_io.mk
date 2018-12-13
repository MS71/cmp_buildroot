################################################################################
#
# WELLE_IO
#
################################################################################

#WELLE_IO_VERSION = master
WELLE_IO_VERSION = next
WELLE_IO_SITE = $(call github,AlbrechtL,welle.io,$(WELLE_IO_VERSION))
WELLE_IO_LICENSE = GPL-2.0+
WELLE_IO_LICENSE_FILES = COPYING
WELLE_IO_INSTALL_STAGING = YES
WELLE_IO_DEPENDENCIES = faad2 mpg123

WELLE_IO_CONF_OPTS += -DRTLSDR=1 

define WELLE_IO_CONFIGURE_CMDS
    (cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake)
endef

define WELLE_IO_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define WELLE_IO_INSTALL_STAGING_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
endef

define QTDBUSEXTENDED_INSTALL_TARGET_CMDS
    cp -dpf $(STAGING_DIR)/usr/bin/welle-io $(TARGET_DIR)/usr/bin
endef


$(eval $(generic-package))


