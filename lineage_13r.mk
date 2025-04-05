#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from 13r device
$(call inherit-product, device/oneplus/13r/device.mk)

# Inherit from sm8650-common
$(call inherit-product, device/oneplus/sm8650-common/common.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_13r
PRODUCT_DEVICE := 13r
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := OnePlus 13R

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="OnePlus13R-user 15.0.0.0 RKQ1.201217.002 eng.root.20240201.000000 release-keys"

BUILD_FINGERPRINT := OnePlus/OnePlus13R/OnePlus13R:15.0.0.0/RKQ1.201217.002/root02201000:user/release-keys 