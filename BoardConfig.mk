# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).
USE_CAMERA_STUB := true

# inherit from the proprietary version
-include vendor/telechips/m801/BoardConfigVendor.mk

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true
TARGET_GLOBAL_CFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

TARGET_PROVIDES_INIT_TARGET_RC := true
TARGET_RECOVERY_INITRC := device/telechips/m801/recovery.rc
TARGET_BOARD_PLATFORM := tcc88xx
TARGET_BOOTLOADER_BOARD_NAME := m801_88

BOARD_MOBILEDATA_INTERFACE_NAME := "pdp0"

# Audio
BOARD_USES_GENERIC_AUDIO := false

# Camera
USE_CAMERA_STUB := true
ifeq ($(USE_CAMERA_STUB),false)
BOARD_CAMERA_LIBRARIES := libcamera
endif

# Bluetooth
BOARD_HAVE_BLUETOOTH := true

# Gps
BOARD_HAVE_FAKE_GPS := true

# Kernel
BOARD_NAND_PAGE_SIZE := 4096 -s 128
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_CMDLINE := console=ttyTCC,115200n8
TARGET_PREBUILT_KERNEL := device/telechips/m801/kernel

BOARD_BOOTIMAGE_PARTITION_SIZE := 10485760
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 10485760
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 188743680
BOARD_USERDATAIMAGE_PARTITION_SIZE := 273678336
BOARD_FLASH_BLOCK_SIZE := 4096

# Connectivity - Wi-Fi
WPA_SUPPLICANT_VERSION := VER_0_6_X
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
WIFI_DRIVER_MODULE_PATH     := "/system/wifi/ar6000.ko"
WIFI_DRIVER_FW_STA_PATH     := "/system/wifi/athwlan.bin.z77"
WIFI_DRIVER_FW_AP_PATH      := "/system/wifi/athwlan.bin.z77"
WIFI_DRIVER_MODULE_NAME     :=  "ar6000"
WIFI_DRIVER_MODULE_ARG      :=  ""

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/telechips/m801/recovery/recovery_ui.c
