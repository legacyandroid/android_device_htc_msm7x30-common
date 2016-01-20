# Copyright (C) 2016 The CyanogenMod Project
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

$(shell mkdir -p $(OUT)/obj/STATIC_LIBRARIES/libcommondefs-rpc_intermediates/)
$(shell touch $(OUT)/obj/STATIC_LIBRARIES/libcommondefs-rpc_intermediates/export_includes)

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

AMSS_VERSION := $(BOARD_VENDOR_QCOM_GPS_LOC_API_AMSS_VERSION)
RPC_INC := inc-$(AMSS_VERSION)

generated_files := \
	gen-$(AMSS_VERSION)/loc_api_clnt.c \
	gen-$(AMSS_VERSION)/loc_api_cb_xdr.c \
	gen-$(AMSS_VERSION)/loc_api_common_xdr.c \
	gen-$(AMSS_VERSION)/loc_api_cb_svc.c \
	gen-$(AMSS_VERSION)/loc_api_xdr.c \
	gen-$(AMSS_VERSION)/loc_api_fixup.c \
	gen-$(AMSS_VERSION)/loc_api_rpc_glue.c \
	src/loc_apicb_appinit.c \
	src/loc_api_sync_call.c

LOCAL_SRC_FILES := $(generated_files)

LOCAL_CFLAGS := -fno-short-enums
LOCAL_CFLAGS += -include $(RPC_INC)/loc_api_common.h
LOCAL_CFLAGS += -DDEBUG
# LOCAL_CFLAGS += -DVERBOSE
LOCAL_CFLAGS += -DADD_XDR_FLOAT -DADD_XDR_BOOL

LOCAL_SHARED_LIBRARIES := librpc
LOCAL_STATIC_LIBRARIES := libcommondefs-rpc

LOCAL_COPY_HEADERS_TO := libloc_api-rpc/inc
LOCAL_COPY_HEADERS := \
	$(RPC_INC)/loc_api_cb.h \
	$(RPC_INC)/loc_api_common.h \
	$(RPC_INC)/loc_api.h \
	$(RPC_INC)/loc_api_fixup.h \
	$(RPC_INC)/loc_apicb_appinit.h \
	inc/debug.h \
	inc/loc_api_rpc_glue.h \
	inc/loc_api_sync_call.h

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/inc \
	$(LOCAL_PATH)/$(RPC_INC) \
	$(TARGET_OUT_HEADERS)/libcommondefs-rpc \
	$(TARGET_OUT_HEADERS)/librpc

LOCAL_MODULE := libloc_api-rpc

include $(BUILD_STATIC_LIBRARY)
