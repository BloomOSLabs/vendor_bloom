# Inherit common Bloom stuff
$(call inherit-product, vendor/bloom/config/common.mk)

# Inherit Bloom car device tree
$(call inherit-product, device/bloom/car/bloom_car.mk)

# Inherit the main AOSP car makefile that turns this into an Automotive build
$(call inherit-product, packages/services/Car/car_product/build/car.mk)
