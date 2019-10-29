#
# Copyright 2019 The MoKee Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

LOCAL_PATH := $(call my-dir)

ifneq ($(filter nx529j,$(TARGET_DEVICE)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware_mnt
$(FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware_mnt

DSP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/dsp
$(DSP_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(DSP_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/dsp

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_MOUNT_POINT) $(DSP_MOUNT_POINT)

IMS_LIBS := libimscamera_jni.so libimsmedia_jni.so
IMS_SYMLINKS := $(addprefix $(TARGET_OUT_APPS_PRIVILEGED)/ims/lib/arm64/,$(notdir $(IMS_LIBS)))
$(IMS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "IMS lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/vendor/lib64/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(IMS_SYMLINKS)

RFS_MSM_ADSP_SYMLINKS := $(TARGET_OUT)/rfs/msm/adsp/
$(RFS_MSM_ADSP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM ADSP folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly
	$(hide) ln -sf /data/tombstones/lpass $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/adsp $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware

RFS_MSM_MPSS_SYMLINKS := $(TARGET_OUT)/rfs/msm/mpss/
$(RFS_MSM_MPSS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM MPSS folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly
	$(hide) ln -sf /data/tombstones/modem $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/mpss $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware

ALL_DEFAULT_INSTALLED_MODULES += $(RFS_MSM_ADSP_SYMLINKS) $(RFS_MSM_MPSS_SYMLINKS)

WCNSS_IMAGES := \
    wcnss.b00 wcnss.b01 wcnss.b02 wcnss.b03 wcnss.b04 wcnss.b05 wcnss.b06 \
    wcnss.b07 wcnss.b08 wcnss.b09 wcnss.b10 wcnss.b11 wcnss.b12 wcnss.mdt \
    wcnssver.cfg

WCNSS_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/firmware/image/,$(notdir $(WCNSS_IMAGES)))
$(WCNSS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/wcnss/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_SYMLINKS)

FINGERID_IMAGES := \
    fingerid.b00 fingerid.b01 fingerid.b02 fingerid.b03 fingerid.mdt
FINGERID_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FINGERID_IMAGES)))
$(FINGERID_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "FINGERID firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(FINGERID_SYMLINKS)
FINGERPR_IMAGES := \
    fingerpr.b00 fingerpr.b01 fingerpr.b02 fingerpr.b03 fingerpr.mdt
FINGERPR_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FINGERPR_IMAGES)))
$(FINGERPR_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "FINGERPR firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(FINGERPR_SYMLINKS)
GOODIXFP_IMAGES := \
    goodixfp.b00 goodixfp.b01 goodixfp.b02 goodixfp.b03 goodixfp.mdt
GOODIXFP_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(GOODIXFP_IMAGES)))
$(GOODIXFP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "GOODIXFP firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(GOODIXFP_SYMLINKS)
SYNAFP_IMAGES := \
    synafp.b00 synafp.b01 synafp.b02 synafp.b03 synafp.mdt
SYNAFP_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(SYNAFP_IMAGES)))
$(SYNAFP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "SYNAFP firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(SYNAFP_SYMLINKS)
FPCTZAPP_IMAGES := \
    fpctzapp.b00 fpctzapp.b01 fpctzapp.b02 fpctzapp.b03 fpctzapp.mdt
FPCTZAPP_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FPCTZAPP_IMAGES)))
$(FPCTZAPP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "FPCTZAPP firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	@$(hide) ln -sf /firmware/image/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(FPCTZAPP_SYMLINKS)

WCNSS_CFG_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/prima/WCNSS_qcom_cfg.ini
$(WCNSS_CFG_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@mkdir -p $(dir $@)
	$(hide) ln -sf /data/vendor/wifi/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_CFG_SYMLINK)



endif
