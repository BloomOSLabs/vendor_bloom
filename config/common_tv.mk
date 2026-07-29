# Inherit common Bloom stuff
$(call inherit-product, vendor/bloom/config/common.mk)

# Inherit Lineage atv device tree
$(call inherit-product, device/lineage/atv/lineage_atv.mk)

# Google source built packages
PRODUCT_PACKAGES += \
    LeanbackIME

# Custom Bloom packages
PRODUCT_PACKAGES += \
    LineageCustomizer

DEVICE_PACKAGE_OVERLAYS += vendor/bloom/overlay/tv
