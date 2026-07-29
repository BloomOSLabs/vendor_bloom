# Temporary: Compatibility layer for existing Lineage components
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.lineage.version=$(BLOOM_VERSION) \
    ro.lineage.releasetype=$(BLOOM_BUILDTYPE) \
    ro.lineage.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.lineagelegal.url=https://bloomoslabs.github.io/legal \
    ro.lineage.display.version=$(BLOOM_DISPLAY_VERSION) \
    ro.lineage.build.version.plat.sdk=$(BLOOM_PLATFORM_SDK_VERSION) \
    ro.lineage.build.version.plat.rev=$(BLOOM_PLATFORM_REV)
