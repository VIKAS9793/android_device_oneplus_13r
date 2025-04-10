# Copyright (C) 2024 The LineageOS Project
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

# Inherit from oneplus sm8650-common
include device/oneplus/sm8650-common/BoardConfigCommon.mk

DEVICE_PATH := device/oneplus/13r

# Assert
TARGET_OTA_ASSERT_DEVICE := 13r

# Display
TARGET_SCREEN_DENSITY := 450

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/device.prop:$(TARGET_COPY_OUT_VENDOR)/etc/device.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 103

# Fingerprint
TARGET_USES_FOD_ZPOS := true
BOARD_USES_FOD_ZPOS := true

# NFC
BOARD_USES_NQ_NFC := true
BOARD_NFC_CHIPSET := nqx

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_QCOM_BT := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth

# Camera
BOARD_USES_CAMERA_HAL3 := true
BOARD_USES_QTI_CAMERA_DEVICE := true

# Audio
BOARD_USES_ALSA_AUDIO := true
USE_XML_AUDIO_POLICY_CONF := 1

# Display
TARGET_USES_HWC2 := true
TARGET_USES_GRALLOC1 := true
TARGET_USES_GRALLOC4 := true

# Removed network/charger configs (now in vendor.prop)

# Build fingerprint
BUILD_FINGERPRINT := OnePlus/OnePlus13R/OnePlus13R_IN:15/TQH1.250301.001/250301001:user/release-keys

# Include proprietary files
include vendor/oneplus/13r/BoardConfigVendor.mk
