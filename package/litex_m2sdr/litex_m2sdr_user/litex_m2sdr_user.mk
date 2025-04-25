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

LITEX_M2SDR_USER_BINARIES = m2sdr_eb_util m2sdr_play \
	m2sdr_record m2sdr_rf m2sdr_tone m2sdr_util
LITEX_M2SDR_USER_LIBS = liblitepcie/liblitepcie.a \
	libm2sdr/libm2sdr.a ad9361/libad9361_m2sdr.a
LITEX_M2SDR_USER_LITEPCIE_HEADERS = liblitepcie/litepcie_helpers.h \
	liblitepcie/litepcie_dma.h \
	liblitepcie/liblitepcie.h \
	liblitepcie/litepcie_flash.h
LITEX_M2SDR_USER_LITEETH_HEADERS = libliteeth/etherbone.h
LITEX_M2SDR_USER_LIBM2SDR_HEADERS = libm2sdr/m2sdr_si5351_i2c.h \
	libm2sdr/libm2sdr.h \
	libm2sdr/m2sdr_config.h \
	libm2sdr/m2sdr_ad9361_spi.h

LITEX_M2SDR_USER_AD9361_HEADERS = ad9361/platform.h \
	ad9361/ad9361.h \
	ad9361/ad9361_api.h \
	ad9361/common.h \
	ad9361/util.h \
	ad9361/config.h

define LITEX_M2SDR_USER_BUILD_CMDS
	echo $(@D)
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" \
	-C $(@D)/$(LITEX_M2SDR_USER_SUBDIR) PREFIX=/usr
endef

define LITEX_M2SDR_USER_INSTALL_TARGET_CMDS
	$(foreach binary,$(LITEX_M2SDR_USER_BINARIES), \
		$(INSTALL) -D -m 0644 $(@D)/$(LITEX_M2SDR_USER_SUBDIR)/$(binary) \
		$(TARGET_DIR)/usr/bin
	)
endef

define LITEX_M2SDR_USER_INSTALL_STAGING_CMDS
	$(foreach library,$(LITEX_M2SDR_USER_LIBS), \
		$(INSTALL) -D -m 0644 $(@D)/$(LITEX_M2SDR_USER_SUBDIR)/$(library) \
		$(STAGING_DIR)/usr/lib
	)
	$(foreach header,$(LITEX_M2SDR_USER_LITEPCIE_HEADERS), \
		$(INSTALL) -D -m 0644 $(@D)/$(LITEX_M2SDR_USER_SUBDIR)/$(header) \
		$(STAGING_DIR)/usr/include/$(header)
	)
	$(foreach header,$(LITEX_M2SDR_USER_LITEETH_HEADERS), \
		$(INSTALL) -D -m 0644 $(@D)/$(LITEX_M2SDR_USER_SUBDIR)/$(header) \
		$(STAGING_DIR)/usr/include/$(header)
	)
	$(foreach header,$(LITEX_M2SDR_USER_LIBM2SDR_HEADERS), \
		$(INSTALL) -D -m 0644 $(@D)/$(LITEX_M2SDR_USER_SUBDIR)/$(header) \
		$(STAGING_DIR)/usr/include/$(header)
	)
	$(foreach header,$(LITEX_M2SDR_USER_AD9361_HEADERS), \
		$(INSTALL) -D -m 0644 $(@D)/$(LITEX_M2SDR_USER_SUBDIR)/$(header) \
		$(STAGING_DIR)/usr/include/$(header)
	)
endef

$(eval $(generic-package))
