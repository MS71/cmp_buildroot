################################################################################
#
# WELLE_IO
#
################################################################################

#WELLE_IO_VERSION = master
WELLE_IO_VERSION = next
WELLE_IO_SITE = $(call github,MS71,welle.io,$(WELLE_IO_VERSION))
WELLE_IO_LICENSE = GPL-2.0+
WELLE_IO_LICENSE_FILES = COPYING
WELLE_IO_INSTALL_STAGING = YES
WELLE_IO_INSTALL_TARGET = YES
WELLE_IO_DEPENDENCIES = faad2 mpg123 qtmpris

WELLE_IO_CONF_OPTS += -DRTLSDR=1 -DAIRSPY=0 -DSOAPYSDR=0 -DMPRIS=1

#$(eval $(generic-package))
$(eval $(cmake-package))


