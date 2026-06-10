PRODUCT_BRAND := BloomOS
PRODUCT_MANUFACTURER := BloomOS

# Packages
PRODUCT_PACKAGES += \
    BloomPlatformOverlay

# Overlays
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/bloom/overlays

include vendor/bloom/config/version.mk
include vendor/bloom/config/branding.mk
