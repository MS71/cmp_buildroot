################################################################################
#
# python-pybluez
#
################################################################################

PYTHON_PYBLUEZ_VERSION = 0.22
PYTHON_PYBLUEZ_SOURCE = $(PYTHON_PYBLUEZ_VERSION).tar.gz
PYTHON_PYBLUEZ_SITE = https://github.com/pybluez/pybluez/archive
#PYTHON_PYBLUEZ_LICENSE = BSD-3-Clause
#PYTHON_PYBLUEZ_LICENSE_FILES = LICENSE.rst
PYTHON_PYBLUEZ_SETUP_TYPE = setuptools

$(eval $(python-package))
