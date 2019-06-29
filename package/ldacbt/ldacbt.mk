################################################################################
#
# LDACBT
#
################################################################################

LDACBT_VERSION = v2.0.2.3
#LDACBT_SITE = $(call github,EHfive,ldacBT,$(LDACBT_VERSION))
LDACBT_SITE = https://github.com/EHfive/ldacBT.git
LDACBT_SITE_METHOD = git
LDACBT_GIT_SUBMODULES = YES
LDACBT_LICENSE = GPL-2.0+
LDACBT_LICENSE_FILES = COPYING
LDACBT_INSTALL_STAGING = YES
#LDACBT_DEPENDENCIES = 

#LDACBT_CONF_OPTS +=

$(eval $(cmake-package))
