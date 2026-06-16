# Inherit common Bloom stuff
$(call inherit-product, vendor/bloom/config/common_mobile.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
