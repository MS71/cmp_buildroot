################################################################################
#
# BLUEZ_QT
#
################################################################################

BLUEZ_QT_VERSION = v5.47.0
BLUEZ_QT_SITE = $(call github,KDE,bluez-qt,$(BLUEZ_QT_VERSION))
BLUEZ_QT_LICENSE = GPL-2.0+
BLUEZ_QT_LICENSE_FILES = COPYING
BLUEZ_QT_INSTALL_STAGING = YES
#BLUEZ_QT_DEPENDENCIES = faad2

#BLUEZ_QT_CONF_OPTS += -DRTLSDR=1

$(eval $(cmake-package))
