# Buildroot External for LiteX-M2SDR

This repository provides **Buildroot** support for the **LiteX-M2SDR** mounted on a **Raspberry Pi 5** board.
It uses the `BR2_EXTERNAL` mechanism to extend Buildroot with additional packages and configurations.

This support has been tested with the latest stable Buildroot release **2025.08** (commit `3386677f0a4d1c0150e772eb07cede05e88a2d6d`).

## Hardware setup

Below is the [LiteX-M2SDR](https://github.com/enjoy-digital/litex_m2sdr) installed on a [Raspberry Pi 5](https://www.raspberrypi.com/products/raspberry-pi-5/).

![Connecting LiteX-M2SDR to the Raspberry Pi 5](https://github.com/user-attachments/assets/7205b4a2-814d-4db2-87c0-573993c92a3e)
![Raspberry Pi 5 Max from the CPU side](https://github.com/user-attachments/assets/4f821f79-f274-4270-8642-5e7e556e8577)

To connect the LiteX-M2SDR on the Raspberry Pi 5 board, you need an M.2 hat like the [Pineboards HatDrive BM1L](https://pineboards.io/products/hatdrive-bottom-2230-2242-2280-for-rpi5).

## How to Use

### Download Buildroot
You can either download the tarball:

```bash
wget https://buildroot.org/downloads/buildroot-2025.08.tar.gz
tar xf buildroot-2025.08.tar.gz
cd buildroot-2025.08
```

Or clone the repository:

```bash
git clone https://gitlab.com/buildroot.org/buildroot.git
cd buildroot
git checkout 2025.08
```

### Buildroot Prerequisites
buildroot has requirements (tools and libraries). They must be installed on the host development
computer. To avoid duplicate documentation and an out-of-date list, install the mandatory packages
indicated in the
[Buildroot documentation](https://buildroot.org/downloads/manual/manual.html#requirement) before going
any further.

### Configure shell environment

To enable LiteX-M2SDR support, source the `source.me` script, which sets `BR2_EXTERNAL` in your environment:

```bash
source /path/to/litex_m2sdr_buildroot/source.me
```

Alternatively, you can add the following line to your `~/.bashrc`:

```bash
export BR2_EXTERNAL=/path/to/litex_m2sdr_buildroot
```

### Configure Buildroot
From the Buildroot directory, select a default configuration:

- Minimal system (LiteX-M2SDR driver, utilities, and SoapySDR):

  ```bash
  make raspberrypi5_defconfig
  ```

- Minimal system plus GNU Radio support:

  ```bash
  make raspberrypi5_gnuradio_defconfig
  ```

### build all
Once configured, build everything (cross-compiler, U-Boot, Linux kernel, and root filesystem):

```bash
make
```

### flash the SD card
After the build completes, an image named **`sdcard.img`** will be generated in `output/images/`.

Flash it to your SD card with:

```bash
sudo dd if=output/images/sdcard.img of=/dev/yourSdCard bs=4M status=progress
sync
```

Replace `/dev/yourSdCard` with the correct device node (commonly `/dev/sdb` or `/dev/mmcblk0`).
You can verify the device name with `dmesg`.

⚠️ <font color="red">**Warning:** This step will overwrite all data on the target device. Double-check the device name before proceeding.</font>


## Notes

### Configuration

As mentioned in [LiteX M2SDR documentation for RPI5](https://github.com/enjoy-digital/litex_m2sdr/blob/main/doc/hosts/raspberry-pi-5.md#tweaking-the-system), the `config.txt` must be modified. In this
repository this step is not required: *boards/raspberrypi5/config_5.txt* contains required
parameters.

### CPUFreq

By default, CPUs are configured with a `scaling_governor` set to `ondemand`. To pass to CPUs in
`performance` mode, please use this command:
```bash
for i in $(seq 0 3); do echo performance > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor ; done
```

## Repository structure

```bash
.
├── board
│   ├── overlay
│   │   ├── boot
│   │   └── etc
│   │       ├── fstab
│   │       └── ssh
│   │           └── sshd_config
│   └── raspberrypi5
│       ├── cmdline_5.txt
│       ├── config_5.txt
│       ├── genimage.cfg.in
│       ├── linux-4k-page-size.fragment
│       ├── patches
│       │   ├── linux
│       │   │   └── linux.hash
│       │   └── linux-headers
│       │       └── linux-headers.hash -> ../linux/linux.hash
│       ├── post-build.sh
│       ├── post-image.sh
│       └── readme.txt
├── Config.in
├── configs
│   ├── raspberrypi5_defconfig
│   └── raspberrypi5_gnuradio_defconfig
├── external.desc
├── external.mk
├── linux
│   ├── Config.ext.in
│   └── linux-ext-litex_m2sdr_driver.mk
├── package
│   ├── gnuradio_soapy
│   │   ├── Config.in
│   │   ├── gnuradio_soapy.hash
│   │   └── gnuradio_soapy.mk
│   ├── litex_m2sdr
│   │   ├── Config.in
│   │   ├── litex_m2sdr_driver
│   │   │   ├── Config.in
│   │   │   ├── litex_m2sdr_driver.hash -> ../litex_m2sdr.hash
│   │   │   └── litex_m2sdr_driver.mk
│   │   ├── litex_m2sdr.hash
│   │   ├── litex_m2sdr.mk
│   │   ├── litex_m2sdr_soapysdr
│   │   │   ├── Config.in
│   │   │   ├── litex_m2sdr_soapysdr.hash -> ../litex_m2sdr.hash
│   │   │   └── litex_m2sdr_soapysdr.mk
│   │   └── litex_m2sdr_user
│   │       ├── Config.in
│   │       ├── litex_m2sdr_user.hash -> ../litex_m2sdr.hash
│   │       └── litex_m2sdr_user.mk
├── README.md
└── source.me
```

### Directory overview

- **`board/overlay/`**
  Files copied into the target root filesystem before image creation (e.g., enabling `root` SSH logins).

- **`board/raspberrypi5/`**
  Scripts and configurations for image preparation.
  The `patches/` subdirectory contains package patches and updated hashes.
- **`configs/`** Default Buildroot configurations for Raspberry Pi 5.
- **`linux/`** Kernel integration files and rules for the LiteX-M2SDR driver.
- **`package/`** Custom packages not yet available in upstream Buildroot:
  - **`gnuradio_soapy/`**: GNU Radio with SoapySDR support (patch applied but not yet in master).
  - **`litex_m2sdr/`**: Dedicated package with sub-packages for:
    - Kernel driver
    - SoapySDR module
    - User utilities