################################################################################
#
# LiteX-M2SDR User
#
################################################################################

LITEX_M2SDR_USER_VERSION = $(LITEX_M2SDR_VERSION)
LITEX_M2SDR_USER_SOURCE = litex_m2sdr-$(LITEX_M2SDR_VERSION).tar.gz
LITEX_M2SDR_USER_SITE = $(LITEX_M2SDR_SITE)
LITEX_M2SDR_USER_DL_SUBDIR = litex_m2sdr
LITEX_M2SDR_USER_LICENSE = $(LITEX_M2SDR_LICENSE)
LITEX_M2SDR_USER_LICENSE_FILES = $(LITEX_M2SDR_LICENSE_FILES)
LITEX_M2SDR_USER_SUBDIR = litex_m2sdr/software/user
LITEX_M2SDR_USER_INSTALL_STAGING = YES

LITEX_M2SDR_USER_DEPENDENCIES = ffmpeg libsamplerate libsndfile

define LITEX_M2SDR_USER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" \
	-C $(@D)/$(LITEX_M2SDR_USER_SUBDIR) PREFIX=/usr
endef

define LITEX_M2SDR_USER_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" \
	-C $(@D)/$(LITEX_M2SDR_USER_SUBDIR) PREFIX=$(TARGET_DIR)/usr install
endef

define LITEX_M2SDR_USER_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" \
	-C $(@D)/$(LITEX_M2SDR_USER_SUBDIR) PREFIX=$(STAGING_DIR)/usr install_dev
endef

$(eval $(generic-package))
