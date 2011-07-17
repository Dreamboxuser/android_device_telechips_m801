#
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

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

#
# This is the product configuration for a generic GSM passion,
# not specialized for any geography.
#

## (1) First, the most specific values, i.e. the aspects that are specific to GSM
PRODUCT_COPY_FILES := \
    device/telechips/m801/init.rc:root/init.rc \
    device/telechips/m801/init.m801_88.rc:root/init.m801_88.rc \
    device/telechips/m801/ueventd.m801_88.rc:root/ueventd.m801_88.rc

# configuration files
PRODUCT_COPY_FILES += \
        device/telechips/m801/etc/asound.conf:system/etc/asound.conf \
        device/telechips/m801/egl.cfg:system/lib/egl/egl.cfg \
        device/telechips/m801/etc/vold.conf:system/etc/vold.conf \
        device/telechips/m801/etc/vold.fstab:system/etc/vold.fstab \
        device/telechips/m801/key_921600.psr:system/key_921600.psr \
        device/telechips/m801/key_3000000.psr:system/key_3000000.psr \
        device/telechips/m801/ts.conf:system/ts.conf
#       device/telechips/m801/etc/media_profiles.xml:system/etc/media_profiles.xml \

# apns config file
PRODUCT_COPY_FILES += \
        vendor/cyanogen/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
	frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/base/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
        frameworks/base/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
	frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/base/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

PRODUCT_PROPERTY_OVERRIDES := \
    ro.sf.lcd_density=240 \
    rild.libpath=/system/lib/libreference-ril.so \
    rild.libargs=-d /dev/ttyUSB2 \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=15 \
    ro.ril.hsxpa=2 \
    ro.ril.gprsclass=10

# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
        ro.com.google.locationfeatures=1 \
        ro.com.google.networklocation=1

DEVICE_PACKAGE_OVERLAYS += device/telechips/m801/overlay

# Default network type.
# 0 => WCDMA preferred.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=0

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072

# This is a high density device with more memory, so larger vm heaps for it.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=24m

# Kernel Modules
PRODUCT_COPY_FILES += \
    device/telechips/m801/modules/ehci-hcd.ko:root/lib/modules/ehci-hcd.ko \
    device/telechips/m801/modules/ohci-hcd.ko:root/lib/modules/ohci-hcd.ko \
    device/telechips/m801/modules/tcc88xx_nand.ko:root/lib/modules/tcc88xx_nand.ko \
    device/telechips/m801/modules/tcc88xx_nand.ko:recovery/root/lib/modules/tcc88xx_nand.ko \
    device/telechips/m801/modules/ufsd.ko:root/lib/modules/ufsd.ko \

PRODUCT_COPY_FILES += \
    device/telechips/m801/modules/ar6000.ko:system/lib/modules/ar6000.ko \
    device/telechips/m801/modules/mali.ko:system/lib/modules/mali.ko \
    device/telechips/m801/modules/ump.ko:system/lib/modules/ump.ko \
    device/telechips/m801/modules/viqe.ko:system/lib/modules/viqe.ko \
    device/telechips/m801/modules/vpu_decoder.ko:system/lib/modules/vpu_decoder.ko \
    device/telechips/m801/modules/vpu_decoder_ext.ko:system/lib/modules/vpu_decoder_ext.ko \
    device/telechips/m801/modules/vpu_encoder.ko:system/lib/modules/vpu_encoder.ko \
    device/telechips/m801/modules/vpu_manager.ko:system/lib/modules/vpu_manager.ko

# Kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/telechips/m801/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/telechips/m801/m801-vendor.mk)
