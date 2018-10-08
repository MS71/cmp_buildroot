################################################################################
#
# LIBRTLSDR_BIASTEE
#
################################################################################

LIBRTLSDR_BIASTEE_VERSION = master
LIBRTLSDR_BIASTEE_SITE = $(call github,rtlsdrblog,rtl_biast,$(LIBRTLSDR_BIASTEE_VERSION))
LIBRTLSDR_BIASTEE_LICENSE = GPL-2.0+
LIBRTLSDR_BIASTEE_LICENSE_FILES = COPYING
LIBRTLSDR_BIASTEE_INSTALL_STAGING = YES
LIBRTLSDR_BIASTEE_DEPENDENCIES = libusb

# BUILD_SHARED_LIBS is handled in pkg-cmake.mk as it is a generic cmake variable
ifeq ($(BR2_STATIC_LIBS),y)
LIBRTLSDR_BIASTEE_CONF_OPTS += -DBUILD_STATIC_LIBS=ON
else ifeq ($(BR2_SHARED_STATIC_LIBS),y)
LIBRTLSDR_BIASTEE_CONF_OPTS += -DBUILD_STATIC_LIBS=ON
else ifeq ($(BR2_SHARED_LIBS),y)
LIBRTLSDR_BIASTEE_CONF_OPTS += -DBUILD_STATIC_LIBS=OFF
endif

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
LIBRTLSDR_BIASTEE_CONF_OPTS += -DINSTALL_UDEV_RULES=ON
endif

ifeq ($(BR2_PACKAGE_LIBRTLSDR_BIASTEE_DETACH_DRIVER),y)
LIBRTLSDR_BIASTEE_CONF_OPTS += -DDETACH_KERNEL_DRIVER=1
endif

# In case of static-lib-only builds, CMake's FindThreads.cmake code tries to
# get the right flags, checking first for -lpthreads, then -lpthread, and lastly
# for -pthread.
# The 2 first link checks fail because of undefined symbols: __libc_setup_tls.
# In the later check, CMake successfully compiles and links the test program,
# but it also tries to run it, which is wrong when cross-compiling.
#
# The following CMake variable only disables the TRY_RUN call in the -pthread
# test.
LIBRTLSDR_BIASTEE_CONF_OPTS += -DTHREADS_PTHREAD_ARG=OFF

$(eval $(cmake-package))
