################################################################################
#
# LiteX-M2SDR Driver
#
################################################################################

LITEX_M2SDR_DRIVER_VERSION = $(LITEX_M2SDR_VERSION)
LITEX_M2SDR_DRIVER_SOURCE = litex_m2sdr-$(LITEX_M2SDR_VERSION).tar.gz
LITEX_M2SDR_DRIVER_SITE = $(LITEX_M2SDR_SITE)
LITEX_M2SDR_DRIVER_DL_SUBDIR = litex_m2sdr

LITEX_M2SDR_DRIVER_LICENSE = $(LITEX_M2SDR_LICENSE)
LITEX_M2SDR_DRIVER_LICENSE_FILES = $(LITEX_M2SDR_LICENSE_FILES)

$(eval $(generic-package))
