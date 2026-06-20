# Additional BloomOS Properties
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.bloom.version=$(BLOOM_VERSION) \
    ro.bloom.releasetype=$(BLOOM_BUILDTYPE) \
    ro.bloom.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(BLOOM_VERSION) \
    ro.bloomlegal.url=https://bloomoslabs.github.io/legal
    
# BloomOS Platform Display Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.bloom.display.version=$(BLOOM_DISPLAY_VERSION)

# BloomOS Platform SDK Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.bloom.build.version.plat.sdk=$(BLOOM_PLATFORM_SDK_VERSION)

# BloomOS Platform Internal Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.bloom.build.version.plat.rev=$(BLOOM_PLATFORM_REV)
