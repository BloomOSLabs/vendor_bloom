# Recovery
BOARD_USES_FULL_RECOVERY_IMAGE ?= true

include vendor/bloom/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/bloom/config/BoardConfigQcom.mk
endif

include vendor/bloom/config/BoardConfigSoong.mk

