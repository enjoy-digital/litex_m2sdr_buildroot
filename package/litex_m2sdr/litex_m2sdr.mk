################################################################################
#
# LiteX-M2SDR
#
################################################################################

LITEX_M2SDR_VERSION = 8c32d5d85653023d0e5262ed909d82564412731f
LITEX_M2SDR_SITE = $(call github,enjoy-digital,litex_m2sdr,$(LITEX_M2SDR_VERSION))

LITEX_M2SDR_LICENSE = BSD-2-Clause
LITEX_M2SDR_LICENSE_FILES = LICENSE

include $(sort $(wildcard $(BR2_EXTERNAL_LITEX_M2SDR_BUILDROOT_PATH)/package/litex_m2sdr/*/*.mk))
