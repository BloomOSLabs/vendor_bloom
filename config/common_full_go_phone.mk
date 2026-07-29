# Set Bloom specific identifier for Android Go enabled products
PRODUCT_TYPE := go

# Inherit full common Bloom stuff
$(call inherit-product, vendor/bloom/config/common_full_phone.mk)
