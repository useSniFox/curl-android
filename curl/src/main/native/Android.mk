LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/curl/src/Makefile.inc
LOCAL_MODULE            := curl
LOCAL_SRC_FILES         := $(addprefix curl/src/,$(CURL_CFILES))
LOCAL_SRC_FILES         += $(addprefix curl/src/,$(CURLX_CFILES))
LOCAL_SRC_FILES         += $(LOCAL_PATH)/tinynew.cpp
LOCAL_C_INCLUDES        := $(LOCAL_PATH)/curl/lib
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
    LOCAL_C_INCLUDES    += $(LOCAL_PATH)/config32
else ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
    LOCAL_C_INCLUDES    += $(LOCAL_PATH)/config64
else ifeq ($(TARGET_ARCH_ABI),x86)
    LOCAL_C_INCLUDES    += $(LOCAL_PATH)/config32
else ifeq ($(TARGET_ARCH_ABI),x86_64)
    LOCAL_C_INCLUDES    += $(LOCAL_PATH)/config64
else ifeq ($(TARGET_ARCH_ABI),riscv64)
    LOCAL_C_INCLUDES    += $(LOCAL_PATH)/config64
endif
LOCAL_CFLAGS            := -DHAVE_CONFIG_H
LOCAL_STATIC_LIBRARIES  := curl_static
include $(LOCAL_PATH)/build-executable.mk

include $(CLEAR_VARS)
include $(LOCAL_PATH)/curl/lib/Makefile.inc
LOCAL_MODULE            := curl_static
LOCAL_SRC_FILES         := $(addprefix curl/lib/,$(CSOURCES))
LOCAL_C_INCLUDES        := $(LOCAL_PATH)/curl/include $(LOCAL_PATH)/curl/lib
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
    LOCAL_C_INCLUDES    += $(LOCAL_PATH)/config32
else ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
    LOCAL_C_INCLUDES    += $(LOCAL_PATH)/config64
else ifeq ($(TARGET_ARCH_ABI),x86)
    LOCAL_C_INCLUDES    += $(LOCAL_PATH)/config32
else ifeq ($(TARGET_ARCH_ABI),x86_64)
    LOCAL_C_INCLUDES    += $(LOCAL_PATH)/config64
else ifeq ($(TARGET_ARCH_ABI),riscv64)
    LOCAL_C_INCLUDES    += $(LOCAL_PATH)/config64
endif
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/curl/include
LOCAL_EXPORT_LDLIBS     := -lz
LOCAL_CFLAGS            := -DHAVE_CONFIG_H -DBUILDING_LIBCURL
LOCAL_STATIC_LIBRARIES  := ssl_static nghttp2_static nghttp3_static ngtcp2_static
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/nghttp2/lib/Makefile.am
LOCAL_MODULE            := nghttp2_static
LOCAL_SRC_FILES         := $(addprefix nghttp2/lib/,$(OBJECTS))
LOCAL_C_INCLUDES        := $(LOCAL_PATH)/nghttp2/lib/includes
LOCAL_C_INCLUDES        += $(LOCAL_PATH)/config
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/nghttp2/lib/includes
LOCAL_CFLAGS            := -DHAVE_CONFIG_H
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/ngtcp2/lib/Makefile.am
LOCAL_MODULE            := ngtcp2_static
LOCAL_SRC_FILES         := $(addprefix ngtcp2/lib/,$(OBJECTS))
LOCAL_C_INCLUDES        := $(LOCAL_PATH)/ngtcp2/lib/includes
LOCAL_C_INCLUDES        += $(LOCAL_PATH)/config
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/ngtcp2/lib/includes
LOCAL_CFLAGS            := -DHAVE_CONFIG_H
LOCAL_STATIC_LIBRARIES  := ngtcp2_crypto_static
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/ngtcp2/crypto/boringssl/Makefile.am
LOCAL_MODULE            := ngtcp2_crypto_static
LOCAL_SRC_FILES         += $(addprefix ngtcp2/crypto/boringssl/,$(libngtcp2_crypto_boringssl_a_SOURCES))
LOCAL_C_INCLUDES        := $(LOCAL_PATH)/ngtcp2/lib $(LOCAL_PATH)/ngtcp2/lib/includes
LOCAL_C_INCLUDES        += $(LOCAL_PATH)/ngtcp2/crypto $(LOCAL_PATH)/ngtcp2/crypto/includes
LOCAL_C_INCLUDES        += $(LOCAL_PATH)/config
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/ngtcp2/crypto/includes
LOCAL_CFLAGS            := -DHAVE_CONFIG_H
LOCAL_STATIC_LIBRARIES  := ssl_static
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/nghttp3/lib/Makefile.am
LOCAL_MODULE            := nghttp3_static
LOCAL_SRC_FILES         := $(addprefix nghttp3/lib/,$(OBJECTS))
LOCAL_C_INCLUDES        := $(LOCAL_PATH)/nghttp3/lib/includes
LOCAL_C_INCLUDES        += $(LOCAL_PATH)/config
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/nghttp3/lib/includes
LOCAL_CFLAGS            := -DHAVE_CONFIG_H
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE            := brotli_static
LOCAL_SRC_FILES         := brotli/c/common/constants.c \
                          brotli/c/common/context.c \
                          brotli/c/common/dictionary.c \
                          brotli/c/common/platform.c \
                          brotli/c/common/shared_dictionary.c \
                          brotli/c/common/transform.c \
                          brotli/c/dec/bit_reader.c \
                          brotli/c/dec/decode.c \
                          brotli/c/dec/huffman.c \
                          brotli/c/dec/state.c \
                          brotli/c/enc/backward_references.c \
                          brotli/c/enc/backward_references_hq.c \
                          brotli/c/enc/bit_cost.c \
                          brotli/c/enc/block_splitter.c \
                          brotli/c/enc/brotli_bit_stream.c \
                          brotli/c/enc/cluster.c \
                          brotli/c/enc/compress_fragment.c \
                          brotli/c/enc/compress_fragment_two_pass.c \
                          brotli/c/enc/dictionary_hash.c \
                          brotli/c/enc/encode.c \
                          brotli/c/enc/entropy_encode.c \
                          brotli/c/enc/fast_log.c \
                          brotli/c/enc/histogram.c \
                          brotli/c/enc/literal_cost.c \
                          brotli/c/enc/memory.c \
                          brotli/c/enc/metablock.c \
                          brotli/c/enc/static_dict.c \
                          brotli/c/enc/utf8_util.c
LOCAL_C_INCLUDES        := $(LOCAL_PATH)/brotli/c/include
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/brotli/c/include
LOCAL_CFLAGS            := -DHAVE_CONFIG_H
include $(BUILD_STATIC_LIBRARY)

$(call import-module,prefab/boringssl)
