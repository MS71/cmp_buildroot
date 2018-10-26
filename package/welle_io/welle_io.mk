################################################################################
#
# WELLE_IO
#
################################################################################

WELLE_IO_VERSION = master
#WELLE_IO_VERSION = next
WELLE_IO_SITE = $(call github,AlbrechtL,welle.io,$(WELLE_IO_VERSION))
WELLE_IO_LICENSE = GPL-2.0+
WELLE_IO_LICENSE_FILES = COPYING
WELLE_IO_INSTALL_STAGING = YES
WELLE_IO_DEPENDENCIES = faad2 mpg123

WELLE_IO_CONF_OPTS += -DRTLSDR=1

$(eval $(cmake-package))
