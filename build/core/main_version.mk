# BloomOS System Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.version=$(BLOOM_VERSION) \
    ro.lineage.releasetype=$(BLOOM_BUILDTYPE) \
    ro.lineage.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(BLOOM_VERSION) \
    ro.lineagelegal.url=https://lineageos.org/legal

# BloomOS Platform Display Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.display.version=$(BLOOM_DISPLAY_VERSION)

# BloomOS Platform SDK Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.sdk=$(BLOOM_PLATFORM_SDK_VERSION)

# BloomOS Platform Internal Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.rev=$(BLOOM_PLATFORM_REV)
