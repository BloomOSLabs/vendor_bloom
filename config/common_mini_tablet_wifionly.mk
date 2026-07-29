# Inherit mini common Bloom stuff
$(call inherit-product, vendor/bloom/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    androidx.window.extensions \
    LatinIME
