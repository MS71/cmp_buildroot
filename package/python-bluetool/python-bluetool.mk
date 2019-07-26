################################################################################
#
# python-bluetool
#
################################################################################

PYTHON_BLUETOOL_VERSION = 0.1.7
PYTHON_BLUETOOL_SOURCE = bluetool-$(PYTHON_BLUETOOL_VERSION).tar.gz
PYTHON_BLUETOOL_SITE = https://github.com/emlid/bluetool/releases/download/$(PYTHON_BLUETOOL_VERSION)
PYTHON_BLUETOOL_SETUP_TYPE = setuptools

$(eval $(python-package))
