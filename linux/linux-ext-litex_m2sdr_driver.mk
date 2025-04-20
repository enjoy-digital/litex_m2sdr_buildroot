################################################################################
#
# Patch the linux kernel with LiteX-M2SDR extension
#
################################################################################

LINUX_EXTENSIONS += litex_m2sdr_driver

define LITEX_M2SDR_DRIVER_PREPARE_KERNEL
	parent_dir=drivers/media/radio; \
	dest=drivers/media/radio/litex_m2sdr; \
	mkdir -p $(LINUX_DIR)/$${dest}; \
	cp -dpfr $(LITEX_M2SDR_DRIVER_DIR)/litex_m2sdr/software/kernel/* $(LINUX_DIR)/$${dest}/ ; \
	echo "source \"$${dest}/Kconfig\"" \
		>> $(LINUX_DIR)/$${parent_dir}/Kconfig ; \
	echo 'obj-y += litex_m2sdr/' >> $(LINUX_DIR)/$${parent_dir}/Makefile ; \
	echo "config LITEX_M2SDR_DRIVER" >> $(LINUX_DIR)/$${dest}/Kconfig ; \
	echo -e "\ttristate \"LiteX M2SDR driver for linux\"" >> $(LINUX_DIR)/$${dest}/Kconfig ; \
	echo -e "\tdepends on PCI" >> $(LINUX_DIR)/$${dest}/Kconfig ; \
	echo -e "\tdefault m" >> $(LINUX_DIR)/$${dest}/Kconfig ; \
	echo -e "\thelp" >> $(LINUX_DIR)/$${dest}/Kconfig ; \
	echo -e "\t  Say m to enable LiteX M2SDR driver" >> $(LINUX_DIR)/$${dest}/Kconfig ; \
	echo 'obj-$$(CONFIG_LITEX_M2SDR_DRIVER) += m2sdr.o' > $(LINUX_DIR)/$${dest}/Makefile; \
	echo 'm2sdr-objs = main.o' >> $(LINUX_DIR)/$${dest}/Makefile;
endef
