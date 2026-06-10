# BloomOS default properties.
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.bloom.version=$(BLOOM_VERSION) \
    ro.bloom.display.version=$(BLOOM_DISPLAY_VERSION) \
    ro.bloom.releasetype=$(BLOOM_BUILDTYPE) \
    ro.modversion=$(BLOOM_DISPLAY_VERSION)

# Override source default properties
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.lineage.version=$(BLOOM_DISPLAY_VERSION) \
    ro.lineage.display.version=$(BLOOM_DISPLAY_VERSION)
