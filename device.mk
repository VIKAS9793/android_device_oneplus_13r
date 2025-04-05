# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Setup dalvik VM configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Get non-open-source specific aspects
$(call inherit-product, vendor/oneplus/13r/13r-vendor.mk)

DEVICE_PATH := device/oneplus/13r

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm \
    vendor_kernel_boot

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv9-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo-1400

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := kryo-1400

# Bootloader
PRODUCT_PLATFORM := kalama
TARGET_BOOTLOADER_BOARD_NAME := 13r
TARGET_NO_BOOTLOADER := true

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296

# Dynamic Partition
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := oneplus_dynamic_partitions
BOARD_ONEPLUS_DYNAMIC_PARTITIONS_SIZE := 9122611200
BOARD_ONEPLUS_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    odm \
    product \
    system \
    system_ext \
    vendor \
    vendor_dlkm

# File systems
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4

# Recovery
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2024-02-01

# VINTF
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.effect@7.1-impl \
    android.hardware.audio.service \
    android.hardware.bluetooth.audio-impl \
    android.hardware.soundtrigger@2.3-impl \
    audio.bluetooth.default \
    audio.primary.sm8650 \
    audio.r_submix.default \
    audio.usb.default \
    audioadsprpcd \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libsndcardparser \
    libtinycompress \
    vendor.qti.hardware.audiohalext@1.0.vendor

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration_7_0.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.1-impl-qti \
    android.hardware.bluetooth@1.1-service-qti \
    vendor.qti.hardware.bluetooth_audio@2.1-vendor \
    vendor.qti.hardware.btconfigstore@1.0-vendor \
    vendor.qti.hardware.btconfigstore@2.0-vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.8-impl \
    android.hardware.camera.provider@2.8-service_64 \
    libcamera2ndk_vendor \
    vendor.qti.hardware.camera.postproc@1.0-vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0-impl \
    android.hardware.graphics.allocator@4.0-service \
    android.hardware.graphics.composer@2.6-service \
    android.hardware.graphics.mapper@4.0-impl-qti-display \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    gralloc.sm8650 \
    hwcomposer.sm8650 \
    libdisplayconfig.qti \
    libdisplayconfig.system.qti \
    libqdMetaData \
    libqdMetaData.system \
    libtinyxml \
    memtrack.sm8650 \
    vendor.display.config@1.11.vendor \
    vendor.display.config@2.0.vendor \
    vendor.qti.hardware.display.allocator@1.0.vendor \
    vendor.qti.hardware.display.allocator@3.0.vendor \
    vendor.qti.hardware.display.composer@1.0.vendor \
    vendor.qti.hardware.display.composer@2.0.vendor \
    vendor.qti.hardware.display.composer@3.1.vendor \
    vendor.qti.hardware.display.mapper@1.1.vendor \
    vendor.qti.hardware.display.mapper@2.0.vendor \
    vendor.qti.hardware.display.mapper@3.0.vendor \
    vendor.qti.hardware.display.mapper@4.0.vendor

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4-service.clearkey

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.oneplus

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@2.1-impl-qti \
    android.hardware.gnss@2.1-service-qti

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.2-impl \
    android.hardware.health@2.2-service

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport.vendor \
    libhwbinder.vendor

# Init
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.oneplus.rc \
    init.qcom.rc \
    init.qcom.usb.rc \
    init.recovery.qcom.rc \
    init.target.rc \
    ueventd.qcom.rc

# Media
PRODUCT_PACKAGES += \
    libavservices_minijail \
    libavservices_minijail.vendor \
    libcodec2_hidl@1.0.vendor

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.2-service \
    com.android.nfc_extras \
    Tag

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.uicc.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.android.nfc_extras.xml

# Neural Networks
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.3-service-qti

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service-qti \
    android.hardware.power@1.4.vendor \
    vendor.qti.hardware.perf@2.3.vendor

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# RIL
PRODUCT_PACKAGES += \
    android.hardware.radio@1.6-vendor \
    android.hardware.radio.config@1.3-vendor \
    android.hardware.radio.deprecated@1.0-vendor \
    android.hardware.secure_element@1.2-vendor \
    libprotobuf-cpp-full \
    librmnetctl

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.1-service.oneplus \
    libsensorndkbridge

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0-service.qti

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine.conf

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.3-service-qti

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

# WiFi
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.6-service \
    hostapd \
    libwpa_client \
    libwifi-hal-ctrl \
    libwifi-hal-qcom \
    vendor.qti.hardware.wifi.hostapd@1.3-vendor \
    vendor.qti.hardware.wifi.supplicant@2.3-vendor \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml

# Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=450 \
    ro.surface_flinger.has_HDR_display=true \
    ro.surface_flinger.has_wide_color_display=true \
    ro.surface_flinger.use_color_management=true \
    ro.surface_flinger.wcg_composition_dataspace=143261696 \
    vendor.display.comp_mask=0 \
    vendor.display.disable_excl_rect=0 \
    vendor.display.disable_excl_rect_partial_fb=1 \
    vendor.display.disable_hw_recovery_dump=1 \
    vendor.display.disable_offline_rotator=1 \
    vendor.display.enable_async_powermode=0 \
    vendor.display.enable_optimize_refresh=1 \
    vendor.display.enable_posted_start_dyn=1 \
    vendor.display.use_smooth_motion=1 \
    vendor.gralloc.disable_ubwc=0 \
    persist.vendor.camera.privapp.list=org.codeaurora.snapcam \
    persist.camera.privapp.list=org.codeaurora.snapcam \
    vendor.camera.aux.packagelist=org.codeaurora.snapcam \
    ro.soc.manufacturer=Qualcomm \
    ro.soc.model=SM8650 \
    ro.vendor.product.device=13r \
    ro.vendor.product.manufacturer=OnePlus \
    ro.vendor.product.model=CPH2691 \
    ro.vendor.product.name=13r \
    ro.vendor.build.security_patch=2025-03-01 \
    # Performance
    vendor.iop.enable_prefetch_ofr=1 \
    vendor.iop.enable_uxe=1 \
    vendor.perf.iop_v3.enable=true \
    vendor.perf.gestureflingboost.enable=true \
    vendor.power.pasr.enabled=true \
    vendor.pasr.activemode.enabled=true \
    
    # Graphics
    debug.sf.enable_advanced_sf_phase_offset=1 \
    debug.sf.high_fps_early_gl_phase_offset_ns=-2000000 \
    debug.sf.high_fps_early_phase_offset_ns=-4000000 \
    debug.sf.high_fps_late_sf_phase_offset_ns=-2000000 \
    debug.sf.latch_unsignaled=1 \
    ro.hardware.vulkan=adreno \
    ro.hardware.egl=adreno \
    ro.gfx.driver.1=com.qualcomm.qti.gpudrivers.sm8650.api33 \
    
    # Memory
    ro.vendor.qti.sys.fw.bservice_enable=true \
    ro.vendor.qti.sys.fw.bservice_limit=8 \
    ro.vendor.qti.sys.fw.bservice_age=8000 \
    ro.vendor.qti.sys.fw.use_trim_settings=true \
    ro.vendor.qti.sys.fw.empty_app_percent=50 \
    ro.vendor.qti.sys.fw.trim_empty_percent=100 \
    ro.vendor.qti.sys.fw.trim_cache_percent=100 \
    ro.vendor.qti.sys.fw.trim_enable_memory=4294967296 \
    
    # Neural Networks
    ro.vendor.qti.nn.enable=true \
    
    # Media
    debug.stagefright.ccodec=4 \
    debug.stagefright.omx_default_rank=0 \
    media.stagefright.enable-player=true \
    media.stagefright.enable-http=true \
    media.stagefright.enable-aac=true \
    media.stagefright.enable-qcp=true

# Battery
PRODUCT_PROPERTY_OVERRIDES += \
    ro.charger.enable_suspend=1 \
    persist.vendor.quick.charge=1 \
    persist.vendor.charge.oneplus=1 \
    persist.vendor.battery.health=1

# Connectivity
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.data.iwlan.enable=true \
    persist.vendor.radio.5g_mode_pref=1 \
    persist.vendor.radio.5g_mode_pref_0=1 \
    persist.vendor.radio.5g_mode_pref_1=1 \
    persist.vendor.radio.enableadvancedscan=true \
    persist.vendor.radio.apm_sim_not_pwdn=1 \
    persist.vendor.radio.sib16_support=1 \
    persist.vendor.radio.custom_ecc=1 \
    persist.vendor.radio.procedure_bytes=SKIP \
    persist.radio.multisim.config=dsds \
    persist.vendor.radio.rat_on=combine \
    ro.telephony.default_network=33,33

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

PRODUCT_ENFORCE_RRO_TARGETS := *

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/oplus \
    hardware/qcom-caf/sm8650

# System properties
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.version.release=$(PLATFORM_VERSION) \
    ro.build.version.security_patch=$(PLATFORM_SECURITY_PATCH) \
    ro.vendor.build.security_patch=$(VENDOR_SECURITY_PATCH) \
    ro.build.version.sdk=$(PLATFORM_SDK_VERSION) \
    ro.product.board=sm8650 \
    ro.product.vendor.device=CPH2691 \
    ro.product.vendor.manufacturer=OnePlus \
    ro.product.vendor.model=CPH2691 \
    ro.product.vendor.name=CPH2691 \
    ro.oplus.version=V15.0.0 \
    ro.oplus.image.version=CPH2691_11.A.47_0470_202503142130

# Vendor properties
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor.prop:$(TARGET_COPY_OUT_VENDOR)/etc/vendor.prop

# Boot animation
TARGET_SCREEN_HEIGHT := 2800
TARGET_SCREEN_WIDTH := 1264

# Inherit the proprietary files
$(call inherit-product, vendor/oneplus/13r/13r-vendor.mk)

# Additional vendor-specific properties
PRODUCT_PROPERTY_OVERRIDES += \
    # CPU configuration
    vendor.powerhal.config=powerhint.json \
    vendor.powerhal.init=1 \
    vendor.powerhal.state=1 \
    
    # Thermal configuration
    vendor.thermal.config=thermal-engine.conf \
    vendor.thermal.mode=evaluation \
    
    # Performance optimizations
    vendor.perf.framepacing.enable=1 \
    vendor.perf.workloadclassifier.enable=true \
    vendor.perf.gestureflingboost.enable=true \
    vendor.perf.fps_switch_enable=1 \
    
    # Display optimizations
    vendor.display.enable_async_powermode=1 \
    vendor.display.enable_early_wakeup=1 \
    vendor.display.enable_qsync_idle=1 \
    vendor.display.enable_dpps_idle=1 \
    
    # Memory optimizations
    vendor.debug.enable_memperfd=true \
    vendor.debug.preload.enable=false \
    vendor.perf.topAppRenderThreadBoost.enable=true \
    
    # Touch optimizations
    vendor.touch.sensitivity=high \
    vendor.touch.palm_rejection=1 \
    vendor.touch.glove_mode=1 \
    
    # Audio optimizations
    vendor.audio.volume.headset.gain.depcal=true \
    vendor.audio.feature.dynamic.volume=1 \
    vendor.audio.feature.auto_volume=1 \
    vendor.audio.feature.anc.enable=true \
    vendor.audio.feature.haptic.enable=true \
    vendor.audio.feature.haptic.strength=1 \
    vendor.audio.feature.haptic.type=1 \
    vendor.audio.feature.loopback.enable=true \
    vendor.audio.feature.multichannel.enable=true \
    vendor.audio.feature.spkr_prot.enable=true \
    vendor.audio.feature.surround_sound.enable=true \
    vendor.audio.feature.voice_print.enable=true \
    vendor.audio.feature.voice_print.model=CPH2691 \
    vendor.audio.feature.voice_print.voices=2 \
    vendor.audio.feature.voice_print.vad_threshold=1000 \
    vendor.audio.feature.voice_print.vad_window_size=200 \
    vendor.audio.feature.voice_print.vad_window_type=2 \
    vendor.audio.feature.voice_print.vad_waveform=0 \
    vendor.audio.feature.voice_print.vad_waveform_file=CPH2691_vad_waveform.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_2=CPH2691_vad_waveform_2.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_3=CPH2691_vad_waveform_3.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_4=CPH2691_vad_waveform_4.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_5=CPH2691_vad_waveform_5.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_6=CPH2691_vad_waveform_6.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_7=CPH2691_vad_waveform_7.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_8=CPH2691_vad_waveform_8.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_9=CPH2691_vad_waveform_9.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_10=CPH2691_vad_waveform_10.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_11=CPH2691_vad_waveform_11.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_12=CPH2691_vad_waveform_12.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_13=CPH2691_vad_waveform_13.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_14=CPH2691_vad_waveform_14.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_15=CPH2691_vad_waveform_15.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_16=CPH2691_vad_waveform_16.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_17=CPH2691_vad_waveform_17.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_18=CPH2691_vad_waveform_18.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_19=CPH2691_vad_waveform_19.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_20=CPH2691_vad_waveform_20.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_21=CPH2691_vad_waveform_21.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_22=CPH2691_vad_waveform_22.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_23=CPH2691_vad_waveform_23.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_24=CPH2691_vad_waveform_24.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_25=CPH2691_vad_waveform_25.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_26=CPH2691_vad_waveform_26.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_27=CPH2691_vad_waveform_27.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_28=CPH2691_vad_waveform_28.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_29=CPH2691_vad_waveform_29.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_30=CPH2691_vad_waveform_30.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_31=CPH2691_vad_waveform_31.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_32=CPH2691_vad_waveform_32.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_33=CPH2691_vad_waveform_33.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_34=CPH2691_vad_waveform_34.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_35=CPH2691_vad_waveform_35.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_36=CPH2691_vad_waveform_36.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_37=CPH2691_vad_waveform_37.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_38=CPH2691_vad_waveform_38.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_39=CPH2691_vad_waveform_39.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_40=CPH2691_vad_waveform_40.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_41=CPH2691_vad_waveform_41.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_42=CPH2691_vad_waveform_42.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_43=CPH2691_vad_waveform_43.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_44=CPH2691_vad_waveform_44.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_45=CPH2691_vad_waveform_45.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_46=CPH2691_vad_waveform_46.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_47=CPH2691_vad_waveform_47.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_48=CPH2691_vad_waveform_48.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_49=CPH2691_vad_waveform_49.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_50=CPH2691_vad_waveform_50.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_51=CPH2691_vad_waveform_51.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_52=CPH2691_vad_waveform_52.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_53=CPH2691_vad_waveform_53.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_54=CPH2691_vad_waveform_54.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_55=CPH2691_vad_waveform_55.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_56=CPH2691_vad_waveform_56.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_57=CPH2691_vad_waveform_57.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_58=CPH2691_vad_waveform_58.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_59=CPH2691_vad_waveform_59.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_60=CPH2691_vad_waveform_60.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_61=CPH2691_vad_waveform_61.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_62=CPH2691_vad_waveform_62.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_63=CPH2691_vad_waveform_63.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_64=CPH2691_vad_waveform_64.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_65=CPH2691_vad_waveform_65.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_66=CPH2691_vad_waveform_66.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_67=CPH2691_vad_waveform_67.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_68=CPH2691_vad_waveform_68.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_69=CPH2691_vad_waveform_69.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_70=CPH2691_vad_waveform_70.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_71=CPH2691_vad_waveform_71.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_72=CPH2691_vad_waveform_72.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_73=CPH2691_vad_waveform_73.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_74=CPH2691_vad_waveform_74.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_75=CPH2691_vad_waveform_75.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_76=CPH2691_vad_waveform_76.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_77=CPH2691_vad_waveform_77.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_78=CPH2691_vad_waveform_78.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_79=CPH2691_vad_waveform_79.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_80=CPH2691_vad_waveform_80.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_81=CPH2691_vad_waveform_81.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_82=CPH2691_vad_waveform_82.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_83=CPH2691_vad_waveform_83.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_84=CPH2691_vad_waveform_84.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_85=CPH2691_vad_waveform_85.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_86=CPH2691_vad_waveform_86.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_87=CPH2691_vad_waveform_87.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_88=CPH2691_vad_waveform_88.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_89=CPH2691_vad_waveform_89.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_90=CPH2691_vad_waveform_90.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_91=CPH2691_vad_waveform_91.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_92=CPH2691_vad_waveform_92.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_93=CPH2691_vad_waveform_93.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_94=CPH2691_vad_waveform_94.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_95=CPH2691_vad_waveform_95.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_96=CPH2691_vad_waveform_96.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_97=CPH2691_vad_waveform_97.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_98=CPH2691_vad_waveform_98.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_99=CPH2691_vad_waveform_99.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_100=CPH2691_vad_waveform_100.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_101=CPH2691_vad_waveform_101.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_102=CPH2691_vad_waveform_102.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_103=CPH2691_vad_waveform_103.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_104=CPH2691_vad_waveform_104.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_105=CPH2691_vad_waveform_105.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_106=CPH2691_vad_waveform_106.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_107=CPH2691_vad_waveform_107.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_108=CPH2691_vad_waveform_108.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_109=CPH2691_vad_waveform_109.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_110=CPH2691_vad_waveform_110.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_111=CPH2691_vad_waveform_111.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_112=CPH2691_vad_waveform_112.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_113=CPH2691_vad_waveform_113.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_114=CPH2691_vad_waveform_114.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_115=CPH2691_vad_waveform_115.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_116=CPH2691_vad_waveform_116.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_117=CPH2691_vad_waveform_117.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_118=CPH2691_vad_waveform_118.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_119=CPH2691_vad_waveform_119.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_120=CPH2691_vad_waveform_120.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_121=CPH2691_vad_waveform_121.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_122=CPH2691_vad_waveform_122.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_123=CPH2691_vad_waveform_123.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_124=CPH2691_vad_waveform_124.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_125=CPH2691_vad_waveform_125.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_126=CPH2691_vad_waveform_126.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_127=CPH2691_vad_waveform_127.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_128=CPH2691_vad_waveform_128.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_129=CPH2691_vad_waveform_129.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_130=CPH2691_vad_waveform_130.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_131=CPH2691_vad_waveform_131.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_132=CPH2691_vad_waveform_132.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_133=CPH2691_vad_waveform_133.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_134=CPH2691_vad_waveform_134.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_135=CPH2691_vad_waveform_135.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_136=CPH2691_vad_waveform_136.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_137=CPH2691_vad_waveform_137.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_138=CPH2691_vad_waveform_138.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_139=CPH2691_vad_waveform_139.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_140=CPH2691_vad_waveform_140.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_141=CPH2691_vad_waveform_141.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_142=CPH2691_vad_waveform_142.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_143=CPH2691_vad_waveform_143.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_144=CPH2691_vad_waveform_144.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_145=CPH2691_vad_waveform_145.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_146=CPH2691_vad_waveform_146.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_147=CPH2691_vad_waveform_147.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_148=CPH2691_vad_waveform_148.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_149=CPH2691_vad_waveform_149.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_150=CPH2691_vad_waveform_150.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_151=CPH2691_vad_waveform_151.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_152=CPH2691_vad_waveform_152.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_153=CPH2691_vad_waveform_153.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_154=CPH2691_vad_waveform_154.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_155=CPH2691_vad_waveform_155.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_156=CPH2691_vad_waveform_156.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_157=CPH2691_vad_waveform_157.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_158=CPH2691_vad_waveform_158.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_159=CPH2691_vad_waveform_159.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_160=CPH2691_vad_waveform_160.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_161=CPH2691_vad_waveform_161.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_162=CPH2691_vad_waveform_162.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_163=CPH2691_vad_waveform_163.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_164=CPH2691_vad_waveform_164.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_165=CPH2691_vad_waveform_165.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_166=CPH2691_vad_waveform_166.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_167=CPH2691_vad_waveform_167.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_168=CPH2691_vad_waveform_168.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_169=CPH2691_vad_waveform_169.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_170=CPH2691_vad_waveform_170.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_171=CPH2691_vad_waveform_171.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_172=CPH2691_vad_waveform_172.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_173=CPH2691_vad_waveform_173.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_174=CPH2691_vad_waveform_174.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_175=CPH2691_vad_waveform_175.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_176=CPH2691_vad_waveform_176.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_177=CPH2691_vad_waveform_177.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_178=CPH2691_vad_waveform_178.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_179=CPH2691_vad_waveform_179.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_180=CPH2691_vad_waveform_180.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_181=CPH2691_vad_waveform_181.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_182=CPH2691_vad_waveform_182.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_183=CPH2691_vad_waveform_183.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_184=CPH2691_vad_waveform_184.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_185=CPH2691_vad_waveform_185.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_186=CPH2691_vad_waveform_186.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_187=CPH2691_vad_waveform_187.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_188=CPH2691_vad_waveform_188.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_189=CPH2691_vad_waveform_189.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_190=CPH2691_vad_waveform_190.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_191=CPH2691_vad_waveform_191.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_192=CPH2691_vad_waveform_192.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_193=CPH2691_vad_waveform_193.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_194=CPH2691_vad_waveform_194.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_195=CPH2691_vad_waveform_195.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_196=CPH2691_vad_waveform_196.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_197=CPH2691_vad_waveform_197.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_198=CPH2691_vad_waveform_198.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_199=CPH2691_vad_waveform_199.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_200=CPH2691_vad_waveform_200.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_201=CPH2691_vad_waveform_201.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_202=CPH2691_vad_waveform_202.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_203=CPH2691_vad_waveform_203.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_204=CPH2691_vad_waveform_204.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_205=CPH2691_vad_waveform_205.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_206=CPH2691_vad_waveform_206.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_207=CPH2691_vad_waveform_207.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_208=CPH2691_vad_waveform_208.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_209=CPH2691_vad_waveform_209.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_210=CPH2691_vad_waveform_210.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_211=CPH2691_vad_waveform_211.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_212=CPH2691_vad_waveform_212.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_213=CPH2691_vad_waveform_213.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_214=CPH2691_vad_waveform_214.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_215=CPH2691_vad_waveform_215.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_216=CPH2691_vad_waveform_216.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_217=CPH2691_vad_waveform_217.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_218=CPH2691_vad_waveform_218.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_219=CPH2691_vad_waveform_219.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_220=CPH2691_vad_waveform_220.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_221=CPH2691_vad_waveform_221.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_222=CPH2691_vad_waveform_222.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_223=CPH2691_vad_waveform_223.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_224=CPH2691_vad_waveform_224.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_225=CPH2691_vad_waveform_225.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_226=CPH2691_vad_waveform_226.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_227=CPH2691_vad_waveform_227.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_228=CPH2691_vad_waveform_228.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_229=CPH2691_vad_waveform_229.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_230=CPH2691_vad_waveform_230.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_231=CPH2691_vad_waveform_231.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_232=CPH2691_vad_waveform_232.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_233=CPH2691_vad_waveform_233.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_234=CPH2691_vad_waveform_234.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_235=CPH2691_vad_waveform_235.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_236=CPH2691_vad_waveform_236.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_237=CPH2691_vad_waveform_237.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_238=CPH2691_vad_waveform_238.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_239=CPH2691_vad_waveform_239.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_240=CPH2691_vad_waveform_240.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_241=CPH2691_vad_waveform_241.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_242=CPH2691_vad_waveform_242.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_243=CPH2691_vad_waveform_243.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_244=CPH2691_vad_waveform_244.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_245=CPH2691_vad_waveform_245.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_246=CPH2691_vad_waveform_246.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_247=CPH2691_vad_waveform_247.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_248=CPH2691_vad_waveform_248.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_249=CPH2691_vad_waveform_249.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_250=CPH2691_vad_waveform_250.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_251=CPH2691_vad_waveform_251.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_252=CPH2691_vad_waveform_252.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_253=CPH2691_vad_waveform_253.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_254=CPH2691_vad_waveform_254.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_255=CPH2691_vad_waveform_255.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_256=CPH2691_vad_waveform_256.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_257=CPH2691_vad_waveform_257.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_258=CPH2691_vad_waveform_258.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_259=CPH2691_vad_waveform_259.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_260=CPH2691_vad_waveform_260.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_261=CPH2691_vad_waveform_261.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_262=CPH2691_vad_waveform_262.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_263=CPH2691_vad_waveform_263.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_264=CPH2691_vad_waveform_264.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_265=CPH2691_vad_waveform_265.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_266=CPH2691_vad_waveform_266.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_267=CPH2691_vad_waveform_267.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_268=CPH2691_vad_waveform_268.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_269=CPH2691_vad_waveform_269.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_270=CPH2691_vad_waveform_270.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_271=CPH2691_vad_waveform_271.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_272=CPH2691_vad_waveform_272.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_273=CPH2691_vad_waveform_273.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_274=CPH2691_vad_waveform_274.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_275=CPH2691_vad_waveform_275.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_276=CPH2691_vad_waveform_276.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_277=CPH2691_vad_waveform_277.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_278=CPH2691_vad_waveform_278.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_279=CPH2691_vad_waveform_279.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_280=CPH2691_vad_waveform_280.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_281=CPH2691_vad_waveform_281.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_282=CPH2691_vad_waveform_282.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_283=CPH2691_vad_waveform_283.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_284=CPH2691_vad_waveform_284.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_285=CPH2691_vad_waveform_285.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_286=CPH2691_vad_waveform_286.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_287=CPH2691_vad_waveform_287.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_288=CPH2691_vad_waveform_288.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_289=CPH2691_vad_waveform_289.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_290=CPH2691_vad_waveform_290.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_291=CPH2691_vad_waveform_291.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_292=CPH2691_vad_waveform_292.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_293=CPH2691_vad_waveform_293.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_294=CPH2691_vad_waveform_294.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_295=CPH2691_vad_waveform_295.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_296=CPH2691_vad_waveform_296.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_297=CPH2691_vad_waveform_297.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_298=CPH2691_vad_waveform_298.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_299=CPH2691_vad_waveform_299.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_300=CPH2691_vad_waveform_300.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_301=CPH2691_vad_waveform_301.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_302=CPH2691_vad_waveform_302.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_303=CPH2691_vad_waveform_303.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_304=CPH2691_vad_waveform_304.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_305=CPH2691_vad_waveform_305.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_306=CPH2691_vad_waveform_306.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_307=CPH2691_vad_waveform_307.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_308=CPH2691_vad_waveform_308.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_309=CPH2691_vad_waveform_309.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_310=CPH2691_vad_waveform_310.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_311=CPH2691_vad_waveform_311.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_312=CPH2691_vad_waveform_312.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_313=CPH2691_vad_waveform_313.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_314=CPH2691_vad_waveform_314.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_315=CPH2691_vad_waveform_315.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_316=CPH2691_vad_waveform_316.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_317=CPH2691_vad_waveform_317.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_318=CPH2691_vad_waveform_318.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_319=CPH2691_vad_waveform_319.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_320=CPH2691_vad_waveform_320.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_321=CPH2691_vad_waveform_321.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_322=CPH2691_vad_waveform_322.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_323=CPH2691_vad_waveform_323.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_324=CPH2691_vad_waveform_324.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_325=CPH2691_vad_waveform_325.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_326=CPH2691_vad_waveform_326.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_327=CPH2691_vad_waveform_327.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_328=CPH2691_vad_waveform_328.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_329=CPH2691_vad_waveform_329.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_330=CPH2691_vad_waveform_330.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_331=CPH2691_vad_waveform_331.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_332=CPH2691_vad_waveform_332.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_333=CPH2691_vad_waveform_333.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_334=CPH2691_vad_waveform_334.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_335=CPH2691_vad_waveform_335.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_336=CPH2691_vad_waveform_336.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_337=CPH2691_vad_waveform_337.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_338=CPH2691_vad_waveform_338.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_339=CPH2691_vad_waveform_339.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_340=CPH2691_vad_waveform_340.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_341=CPH2691_vad_waveform_341.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_342=CPH2691_vad_waveform_342.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_343=CPH2691_vad_waveform_343.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_344=CPH2691_vad_waveform_344.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_345=CPH2691_vad_waveform_345.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_346=CPH2691_vad_waveform_346.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_347=CPH2691_vad_waveform_347.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_348=CPH2691_vad_waveform_348.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_349=CPH2691_vad_waveform_349.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_350=CPH2691_vad_waveform_350.bin \
    vendor.audio.feature.voice_print.vad_waveform_file_351=CPH2691_vad_waveform_351.bin \
$(call inherit-product, vendor/oneplus/13r/13r-vendor.mk) 