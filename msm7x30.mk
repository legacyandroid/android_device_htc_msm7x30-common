#
# Copyright (C) 2016 The CyanogenMod Project
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

$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)
$(call inherit-product, device/common/gps/gps_eu_supl.mk)
$(call inherit-product-if-exists, $(SRC_TARGET_DIR)/product/go_defaults_512.mk)

# System Properties
-include $(LOCAL_PATH)/system_prop.mk

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := hdpi
PRODUCT_LOCALES += en_US

# Boot Animation
TARGET_SCREEN_HEIGHT := 800
TARGET_SCREEN_WIDTH := 480
TARGET_BOOTANIMATION_HALF_RES := true
PRODUCT_BOOTANIMATION := $(LOCAL_PATH)/rootdir/system/media/bootanimation.zip

# Overlay
PRODUCT_PACKAGE_OVERLAYS += device/htc/msm7x30-common/overlay

# Permissions
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml

# Codecs
PRODUCT_COPY_FILES += \
	frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_video_le.xml:system/etc/media_codecs_google_video_le.xml \
	$(LOCAL_PATH)/rootdir/system/etc/media_codecs.xml:system/etc/media_codecs.xml \
	$(LOCAL_PATH)/rootdir/system/etc/media_profiles.xml:system/etc/media_profiles.xml \
	$(LOCAL_PATH)/rootdir/system/etc/audio_policy.conf:system/etc/audio_policy.conf

# Ramdisk
PRODUCT_PACKAGES += \
	init.htc7x30.rc \
	init.htc7x30.power.rc \
	init.htc7x30.usb.rc \
	ueventd.htc7x30.rc

# Camera
PRODUCT_PACKAGES += \
	camera.msm7x30 \
	libshim_camera \
	libshim_skia

# Audio
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.primary.msm7x30 \
	libaudio-resampler \
	libaudioparameter

# GPS
PRODUCT_PACKAGES += librpc

# Adreno
PRODUCT_PACKAGES += \
    libstlport

# Video
PRODUCT_PACKAGES += \
	copybit.msm7x30 \
	gralloc.msm7x30 \
	hwcomposer.msm7x30 \
	libgenlock

# Wifi
PRODUCT_PACKAGES += \
	libnetcmdiface \
	dhcpcd.conf \
	hostapd \
	wpa_supplicant \
	wpa_supplicant.conf

# HAL
PRODUCT_PACKAGES += \
	power.msm7x30 \
	lights.msm7x30 \
	memtrack.msm7x30 \
	sensors.msm7x30

# Media
PRODUCT_PACKAGES += \
	libOmxCore \
	libOmxVdec \
	libOmxVenc \
	libc2dcolorconvert \
	libstagefrighthw

# IPv6 tethering
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes

# DeviceSettings
PRODUCT_PACKAGES += DeviceSettings

# ART
PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.dex2oat-filter=balanced \
	dalvik.vm.dex2oat-swap=false \
	dalvik.vm.image-dex2oat-filter=speed

# For applications to determine if they should turn off specific memory-intensive
# features that work poorly on low-memory devices.
PRODUCT_PROPERTY_OVERRIDES += \
	ro.config.low_ram=true \
	persist.sys.force_highendgfx=true

# Bluetooth/Wifi firmware
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/firmware/bcm4330.hcd:system/vendor/firmware/bcm4330.hcd \
    $(LOCAL_PATH)/firmware/bcm4329.hcd:system/vendor/firmware/bcm4329.hcd

# ODPUpdater
PRODUCT_PACKAGES += ODPUpdater

ifeq ($(TARGET_UNOFFICIAL_BUILD_ID),)
PRODUCT_PROPERTY_OVERRIDES += ro.odp.releasetype=NIGHTLY
else
PRODUCT_PROPERTY_OVERRIDES += ro.odp.releasetype=SNAPSHOT
endif

# Wifi
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/device-bcm.mk)

# proprietary blobs for msm7x30
$(call inherit-product, vendor/htc/msm7x30-common/msm7x30-common-vendor.mk)
