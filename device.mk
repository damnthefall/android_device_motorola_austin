#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Include GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := default

# Rootdir
PRODUCT_PACKAGES += \
    init.mmi.boot.sh \
    init.oem.hw.sh \
    init.mmi.usb.sh \
    apanic_mtk.sh \
    init.mmi.backup.trustlet.sh \
    init.mmi.block_perm.sh \
    pstore_annotate.sh \
    vendor.mmi.cxp.sh \
    init.mmi.touch.sh \
    hardware_revisions.sh \
    init.oem.fingerprint2.sh \
    init.insmod.sh \
    init.mmi.modules.sh \
    apanic_annotate.sh \
    apanic_copy.sh \
    apanic_save.sh \

PRODUCT_PACKAGES += \
    fstab.enableswap \
    factory_init.connectivity.rc \
    init.mmi.backup.trustlet.rc \
    init.project.rc \
    init.mmi.rc \
    factory_init.rc \
    init.mt6833.rc \
    factory_init.connectivity.common.rc \
    init.mmi.sec.rc \
    init.mt6833.usb.rc \
    factory_init.project.rc \
    multi_init.rc \
    init.mmi.overlay.rc \
    meta_init.modem.rc \
    meta_init.rc \
    init.ago.rc \
    meta_init.connectivity.rc \
    init_connectivity.rc \
    init.mmi.tcmd.rc \
    init.connectivity.common.rc \
    init.connectivity.rc \
    init.modem.rc \
    meta_init.project.rc \
    init.aee.rc \
    meta_init.connectivity.common.rc \
    init.mmi.chipset.rc \
    init.sensor_2_0.rc \
    init.recovery.mt6833.rc \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.enableswap:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.enableswap

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 31

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/motorola/austin/austin-vendor.mk)
