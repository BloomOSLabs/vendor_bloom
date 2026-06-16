# Inherit common Bloom stuff
$(call inherit-product, vendor/bloom/config/common.mk)

# Inherit Bloom atv device tree
$(call inherit-product, device/bloom/atv/lineage_atv.mk)

# Google source built packages
PRODUCT_PACKAGES += \
    LeanbackIME

# Custom Bloom packages
PRODUCT_PACKAGES += \
    AppDrawer \
    LineageCustomizer

DEVICE_PACKAGE_OVERLAYS += vendor/bloom/overlay/tv
