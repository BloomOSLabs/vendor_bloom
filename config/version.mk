PRODUCT_VERSION_MAJOR = 2
PRODUCT_VERSION_MINOR = 0

ifeq ($(LINEAGE_VERSION_APPEND_TIME_OF_DAY),true)
    BLOOM_BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)
else
    BLOOM_BUILD_DATE := $(shell date -u +%Y%m%d)
endif

# Set BLOOM_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef BLOOM_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "BLOOM_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^BLOOM_||g')
        BLOOM_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(BLOOM_BUILDTYPE)),)
    BLOOM_BUILDTYPE := UNOFFICIAL
    BLOOM_EXTRAVERSION :=
endif

ifeq ($(BLOOM_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        BLOOM_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

BLOOM_VERSION_SUFFIX := $(BLOOM_BUILDTYPE)$(BLOOM_EXTRAVERSION)-$(BLOOM_BUILD)-$(BLOOM_BUILD_DATE)

# Internal version
BLOOM_VERSION := BloomOS-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(BLOOM_VERSION_SUFFIX)

# Display version
BLOOM_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR)-$(BLOOM_VERSION_SUFFIX)

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

# Temporary: Set all LINEAGE_ variables after BLOOM_
LINEAGE_BUILD_DATE := $(BLOOM_BUILD_DATE)
LINEAGE_BUILD_TYPE := $(BLOOM_BUILD_TYPE)
LINEAGE_EXTRAVERSION := $(BLOOM_EXTRAVERSION)
LINEAGE_VERSION_SUFFIX := $(BLOOM_VERSION_SUFFIX)
LINEAGE_VERSION := $(BLOOM_VERSION)
LINEAGE_DISPLAY_VERSION := $(BLOOM_DISPLAY_VERSION)
