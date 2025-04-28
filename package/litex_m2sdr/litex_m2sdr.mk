################################################################################
#
# LiteX-M2SDR
#
################################################################################

LITEX_M2SDR_VERSION = d247a11338453008c1388b95414f014eea67c85a
LITEX_M2SDR_SITE = $(call github,enjoy-digital,litex_m2sdr,$(LITEX_M2SDR_VERSION))

LITEX_M2SDR_LICENSE = BSD-2-Clause
LITEX_M2SDR_LICENSE_FILES = LICENSE

include $(sort $(wildcard $(BR2_EXTERNAL_LITEX_M2SDR_BUILDROOT_PATH)/package/litex_m2sdr/*/*.mk))
