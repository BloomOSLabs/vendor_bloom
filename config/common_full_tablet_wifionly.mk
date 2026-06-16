# Inherit full common Bloom stuff
$(call inherit-product, vendor/bloom/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Bloom LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/bloom/overlay/dictionaries
