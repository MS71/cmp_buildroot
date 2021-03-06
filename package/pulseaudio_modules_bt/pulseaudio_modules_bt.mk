################################################################################
#
# PULSEAUDIO_MODULES_BT
#
################################################################################

PULSEAUDIO_MODULES_BT_VERSION = v1.1.99
PULSEAUDIO_MODULES_BT_SITE = $(call github,EHfive,pulseaudio-modules-bt,$(PULSEAUDIO_MODULES_BT_VERSION))
PULSEAUDIO_MODULES_BT_LICENSE = GPL-2.0+
PULSEAUDIO_MODULES_BT_LICENSE_FILES = COPYING
PULSEAUDIO_MODULES_BT_INSTALL_STAGING = YES
PULSEAUDIO_MODULES_BT_INSTALL_TARGET = YES
PULSEAUDIO_MODULES_BT_DEPENDENCIES = faad2 mpg123 ldacbt
#qtmpris-DFORCE_LARGEST_PA_VERSION=ON ..

#PULSEAUDIO_MODULES_BT_CONF_OPTS += -DFORCE_LARGEST_PA_VERSION=ON

define CREATE_PA_LINK
    (cd $(@D); rm -rf pa; ln -s ../pulseaudio-12.2 pa)
endef

PULSEAUDIO_MODULES_BT_PRE_CONFIGURE_HOOKS += CREATE_PA_LINK

$(eval $(cmake-package))


