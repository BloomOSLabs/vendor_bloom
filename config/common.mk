# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= BloomOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
ifdef WITH_ADB_INSECURE
# Forcebly disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/bloom/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/bloom/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/bloom/prebuilt/common/bin/50-lineage.sh:system/addon.d/50-lineage.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/bloom/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/bloom/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/bloom/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/bloom/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Lineage-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/bloom/config/permissions/lineage-sysconfig.xml:system/etc/sysconfig/lineage-sysconfig.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/bloom/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/bloom/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/bloom/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Copy all Lineage-specific init rc files
$(foreach f,$(wildcard vendor/bloom/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/bloom/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is Bloom!
PRODUCT_COPY_FILES += \
    vendor/bloom/config/permissions/org.lineageos.android.xml:system/etc/permissions/org.lineageos.android.xml \
    vendor/bloom/config/permissions/privapp-permissions-lineage.xml:system/etc/permissions/privapp-permissions-lineage.xml \
    vendor/bloom/config/permissions/privapp-permissions-cm-legacy.xml:system/etc/permissions/privapp-permissions-cm-legacy.xml

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/bloom/config/permissions/lineage-hiddenapi-package-whitelist.xml:system/etc/permissions/lineage-hiddenapi-package-whitelist.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/bloom/config/permissions/lineage-power-whitelist.xml:system/etc/sysconfig/lineage-power-whitelist.xml

# Temporary: Set BLOOM_BUILD to LINEAGE_BUILD until BLOOM_BUILD actually exists
BLOOM_BUILD := $(LINEAGE_BUILD)

# Include AOSP audio files
include vendor/bloom/config/aosp_audio.mk

# Include Lineage audio files
include vendor/bloom/config/lineage_audio.mk

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
# Lineage SDK
include vendor/bloom/config/lineage_sdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/bloom/config/twrp.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# Required Lineage packages
PRODUCT_PACKAGES += \
    LineageParts \
    Development \
    Profiles

# Optional packages
PRODUCT_PACKAGES += \
    Terminal

# Custom Lineage packages
PRODUCT_PACKAGES += \
    LineageSettingsProvider \
    LineageSetupWizard \
    Updater

# Extra tools in Lineage
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    micro_bench \
    procmem \
    procrank \
    strace

# Conditionally build in su
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/bloom/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/bloom/overlay/common

PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE := 0

ifeq ($(TARGET_VENDOR_SHOW_MAINTENANCE_VERSION),true)
    BLOOM_VERSION_MAINTENANCE := $(PRODUCT_VERSION_MAINTENANCE)
else
    BLOOM_VERSION_MAINTENANCE := 0
endif

# Temporary: Set LINEAGE_VERSION_MAINTENANCE after BLOOM_VERSION_MAINTENANCE is set
LINEAGE_VERSION_MAINTENANCE := $(BLOOM_VERSION_MAINTENANCE)

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
    BLOOM_BUILDTYPE :=
endif

ifdef BLOOM_BUILDTYPE
    ifneq ($(BLOOM_BUILDTYPE), SNAPSHOT)
        ifdef BLOOM_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            BLOOM_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from BLOOM_EXTRAVERSION
            BLOOM_EXTRAVERSION := $(shell echo $(BLOOM_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to BLOOM_EXTRAVERSION
            BLOOM_EXTRAVERSION := -$(BLOOM_EXTRAVERSION)
        endif
    else
        ifndef BLOOM_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            BLOOM_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from BLOOM_EXTRAVERSION
            BLOOM_EXTRAVERSION := $(shell echo $(BLOOM_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to BLOOM_EXTRAVERSION
            BLOOM_EXTRAVERSION := -$(BLOOM_EXTRAVERSION)
        endif
    endif
else
    # If BLOOM_BUILDTYPE is not defined, set to UNOFFICIAL
    BLOOM_BUILDTYPE := UNOFFICIAL
    BLOOM_EXTRAVERSION :=
endif

ifeq ($(BLOOM_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        BLOOM_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

ifeq ($(BLOOM_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        BLOOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(BLOOM_BUILD)
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            ifeq ($(BLOOM_VERSION_MAINTENANCE),0)
                BLOOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(BLOOM_BUILD)
            else
                BLOOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(BLOOM_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(BLOOM_BUILD)
            endif
        else
            BLOOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(BLOOM_BUILD)
        endif
    endif
else
    ifeq ($(BLOOM_VERSION_MAINTENANCE),0)
        ifeq ($(LINEAGE_VERSION_APPEND_TIME_OF_DAY),true)
            BLOOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d_%H%M%S)-$(BLOOM_BUILDTYPE)$(BLOOM_EXTRAVERSION)-$(BLOOM_BUILD)
        else
            BLOOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(BLOOM_BUILDTYPE)$(BLOOM_EXTRAVERSION)-$(BLOOM_BUILD)
        endif
    else
        ifeq ($(LINEAGE_VERSION_APPEND_TIME_OF_DAY),true)
            BLOOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(BLOOM_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d_%H%M%S)-$(BLOOM_BUILDTYPE)$(BLOOM_EXTRAVERSION)-$(BLOOM_BUILD)
        else
            BLOOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(BLOOM_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(BLOOM_BUILDTYPE)$(BLOOM_EXTRAVERSION)-$(BLOOM_BUILD)
        endif
    endif
endif

# Temporary: Set LINEAGE_BUILDTYPE after BLOOM_BUILDTYPE is set
LINEAGE_BUILDTYPE := $(BLOOM_BUILDTYPE)

# Temporary: Set LINEAGE_VERSION after BLOOM_VERSION is set
LINEAGE_VERSION := $(BLOOM_VERSION)

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/lineage/build/target/product/security/lineage

-include vendor/lineage-priv/keys/keys.mk

BLOOM_DISPLAY_VERSION := $(BLOOM_VERSION)

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
    ifneq ($(BLOOM_BUILDTYPE), UNOFFICIAL)
        ifndef TARGET_VENDOR_RELEASE_BUILD_ID
            ifneq ($(BLOOM_EXTRAVERSION),)
                # Remove leading dash from BLOOM_EXTRAVERSION
                BLOOM_EXTRAVERSION := $(shell echo $(BLOOM_EXTRAVERSION) | sed 's/-//')
                TARGET_VENDOR_RELEASE_BUILD_ID := $(BLOOM_EXTRAVERSION)
            else
                TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
            endif
        else
            TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
        endif
        ifeq ($(BLOOM_VERSION_MAINTENANCE),0)
            BLOOM_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(BLOOM_BUILD)
        else
            BLOOM_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(BLOOM_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(BLOOM_BUILD)
        endif
    endif
endif
endif

# Temporary: Set LINEAGE_DISPLAY_VERSION after BLOOM_DISPLAY_VERSION is set
LINEAGE_DISPLAY_VERSION := $(BLOOM_DISPLAY_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/bloom/config/partner_gms.mk
