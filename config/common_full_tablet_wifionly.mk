# Inherit full common Bloom stuff
$(call inherit-product, vendor/bloom/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    androidx.window.extensions \
    LatinIME

# Include Bloom LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/bloom/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/bloom/overlay/dictionaries
