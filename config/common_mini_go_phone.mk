# Set Bloom specific identifier for Android Go enabled products
PRODUCT_TYPE := go

# Inherit mini common Bloom stuff
$(call inherit-product, vendor/bloom/config/common_mini_phone.mk)
