Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11568CDB5C
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2019 07:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfJGF0z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Oct 2019 01:26:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37810 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfJGF0y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Oct 2019 01:26:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so7887126pfo.4
        for <linux-integrity@vger.kernel.org>; Sun, 06 Oct 2019 22:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i19oWzb0w1Tb6Qla2BM5oZcl/ntHvfGsHnGN/4VPpzQ=;
        b=OlJdNtzRElxgxNNJa/h9r9P4OQ6N5ht2d3/Ttf+Bb0AFig2StqPirQ+Yu7ZDr+4i5Y
         TQVR68Tpdj/LB/2JZ5z0KZzA9YhIqSJ91PdcYANKrljtPx1QyPziO/oohmzj6wYBNk/0
         p7x3QbGg/BIhSRH7v1tluFv+KkOiErVS0+xznOBwfkW84cQxmewTi/h7RBoEexJIuXrL
         0JQyyRsNiRmjQsVmLO+CYvZCmYOrx+HZ4RCQwepAIOkwMQVeMiRHFADm2nmjL9RFiShn
         oYMwquEv9GE1b8pYGYIFZIBzc6KlnGzM+TVYMcESXyec1RcV0YL5pUbisWvA0UHcMSA5
         vT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i19oWzb0w1Tb6Qla2BM5oZcl/ntHvfGsHnGN/4VPpzQ=;
        b=h/Os5DOGYyti6Svlgdp/2oUtCTCGo0A1Dy4vf4B15wLMH9iUzEWB5bN0n9mZJfZ9iJ
         HKxHdH9ZXO7+rbHZNTcFaQ0LIkcSlmoEJFi2DTeYJcLfmmW4mvZ5MqkVIKCZRG6EA6Yh
         B1IEx3xjj2X3Nl3QuP3SF31Si0JnfvHA43trZI4fqN+kuuDKA5C4s/0fauucVoBwFizI
         R36+AiHBdCuVkeIO1KzUXHJi2lbT416ZTU9EVUQ4ge0IJWdQBM5ihBrVEmLExy9/d15S
         d+fvPuhPHCW++stYFQvTGXdn97dg7eXUOOz/fOC/5iNxIwHVMq22rOurNXcopkmyHY3k
         O2dg==
X-Gm-Message-State: APjAAAUNRj/jL2pAq8hBxrfCuuJuDXFCmAnGdYWmqXd7IiT37V11sjEI
        R1dI7jCPF7JIUvjc/P6GRkWTPQ==
X-Google-Smtp-Source: APXvYqwHwmsApvGslEQKVb6mTaYvza4AFtCjZtCK+gND60vaf1aO6loCQcMTsTqqrpfeslltQEoK0A==
X-Received: by 2002:a63:1451:: with SMTP id 17mr3649276pgu.453.1570426012383;
        Sun, 06 Oct 2019 22:26:52 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.194])
        by smtp.gmail.com with ESMTPSA id x9sm15895448pje.27.2019.10.06.22.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Oct 2019 22:26:51 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        peterhuewe@gmx.de
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        jsnitsel@redhat.com, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v7 1/4] tpm: Move tpm_buf code to include/linux/
Date:   Mon,  7 Oct 2019 10:55:32 +0530
Message-Id: <1570425935-7435-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
References: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move tpm_buf code to common include/linux/tpm.h header so that it can
be reused via other subsystems like trusted keys etc.

Also rename trusted keys and asymmetric keys usage of TPM 1.x buffer
implementation to tpm1_buf to avoid any compilation errors.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 crypto/asymmetric_keys/asym_tpm.c |  12 +--
 drivers/char/tpm/tpm.h            | 215 --------------------------------------
 include/keys/trusted.h            |  12 +--
 include/linux/tpm.h               | 215 ++++++++++++++++++++++++++++++++++++++
 security/keys/trusted.c           |  12 +--
 5 files changed, 233 insertions(+), 233 deletions(-)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 76d2ce3..b88968d 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -31,7 +31,7 @@
 /*
  * Load a TPM key from the blob provided by userspace
  */
-static int tpm_loadkey2(struct tpm_buf *tb,
+static int tpm_loadkey2(struct tpm1_buf *tb,
 			uint32_t keyhandle, unsigned char *keyauth,
 			const unsigned char *keyblob, int keybloblen,
 			uint32_t *newhandle)
@@ -99,7 +99,7 @@ static int tpm_loadkey2(struct tpm_buf *tb,
 /*
  * Execute the FlushSpecific TPM command
  */
-static int tpm_flushspecific(struct tpm_buf *tb, uint32_t handle)
+static int tpm_flushspecific(struct tpm1_buf *tb, uint32_t handle)
 {
 	INIT_BUF(tb);
 	store16(tb, TPM_TAG_RQU_COMMAND);
@@ -115,7 +115,7 @@ static int tpm_flushspecific(struct tpm_buf *tb, uint32_t handle)
  * Decrypt a blob provided by userspace using a specific key handle.
  * The handle is a well known handle or previously loaded by e.g. LoadKey2
  */
-static int tpm_unbind(struct tpm_buf *tb,
+static int tpm_unbind(struct tpm1_buf *tb,
 			uint32_t keyhandle, unsigned char *keyauth,
 			const unsigned char *blob, uint32_t bloblen,
 			void *out, uint32_t outlen)
@@ -201,7 +201,7 @@ static int tpm_unbind(struct tpm_buf *tb,
  * up to key_length_in_bytes - 11 and not be limited to size 20 like the
  * TPM_SS_RSASSAPKCS1v15_SHA1 signature scheme.
  */
-static int tpm_sign(struct tpm_buf *tb,
+static int tpm_sign(struct tpm1_buf *tb,
 		    uint32_t keyhandle, unsigned char *keyauth,
 		    const unsigned char *blob, uint32_t bloblen,
 		    void *out, uint32_t outlen)
@@ -519,7 +519,7 @@ static int tpm_key_decrypt(struct tpm_key *tk,
 			   struct kernel_pkey_params *params,
 			   const void *in, void *out)
 {
-	struct tpm_buf *tb;
+	struct tpm1_buf *tb;
 	uint32_t keyhandle;
 	uint8_t srkauth[SHA1_DIGEST_SIZE];
 	uint8_t keyauth[SHA1_DIGEST_SIZE];
@@ -643,7 +643,7 @@ static int tpm_key_sign(struct tpm_key *tk,
 			struct kernel_pkey_params *params,
 			const void *in, void *out)
 {
-	struct tpm_buf *tb;
+	struct tpm1_buf *tb;
 	uint32_t keyhandle;
 	uint8_t srkauth[SHA1_DIGEST_SIZE];
 	uint8_t keyauth[SHA1_DIGEST_SIZE];
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 80bca88..b174cf4 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -25,7 +25,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/tpm.h>
-#include <linux/highmem.h>
 #include <linux/tpm_eventlog.h>
 
 #ifdef CONFIG_X86
@@ -58,124 +57,6 @@ enum tpm_addr {
 #define TPM_ERR_DISABLED        0x7
 #define TPM_ERR_INVALID_POSTINIT 38
 
-#define TPM_HEADER_SIZE		10
-
-enum tpm2_const {
-	TPM2_PLATFORM_PCR       =     24,
-	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
-};
-
-enum tpm2_timeouts {
-	TPM2_TIMEOUT_A          =    750,
-	TPM2_TIMEOUT_B          =   2000,
-	TPM2_TIMEOUT_C          =    200,
-	TPM2_TIMEOUT_D          =     30,
-	TPM2_DURATION_SHORT     =     20,
-	TPM2_DURATION_MEDIUM    =    750,
-	TPM2_DURATION_LONG      =   2000,
-	TPM2_DURATION_LONG_LONG = 300000,
-	TPM2_DURATION_DEFAULT   = 120000,
-};
-
-enum tpm2_structures {
-	TPM2_ST_NO_SESSIONS	= 0x8001,
-	TPM2_ST_SESSIONS	= 0x8002,
-};
-
-/* Indicates from what layer of the software stack the error comes from */
-#define TSS2_RC_LAYER_SHIFT	 16
-#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
-
-enum tpm2_return_codes {
-	TPM2_RC_SUCCESS		= 0x0000,
-	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
-	TPM2_RC_HANDLE		= 0x008B,
-	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
-	TPM2_RC_FAILURE		= 0x0101,
-	TPM2_RC_DISABLED	= 0x0120,
-	TPM2_RC_COMMAND_CODE    = 0x0143,
-	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
-	TPM2_RC_REFERENCE_H0	= 0x0910,
-	TPM2_RC_RETRY		= 0x0922,
-};
-
-enum tpm2_command_codes {
-	TPM2_CC_FIRST		        = 0x011F,
-	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
-	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
-	TPM2_CC_CREATE_PRIMARY          = 0x0131,
-	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
-	TPM2_CC_SELF_TEST	        = 0x0143,
-	TPM2_CC_STARTUP		        = 0x0144,
-	TPM2_CC_SHUTDOWN	        = 0x0145,
-	TPM2_CC_NV_READ                 = 0x014E,
-	TPM2_CC_CREATE		        = 0x0153,
-	TPM2_CC_LOAD		        = 0x0157,
-	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
-	TPM2_CC_UNSEAL		        = 0x015E,
-	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
-	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
-	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
-	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
-	TPM2_CC_GET_CAPABILITY	        = 0x017A,
-	TPM2_CC_GET_RANDOM	        = 0x017B,
-	TPM2_CC_PCR_READ	        = 0x017E,
-	TPM2_CC_PCR_EXTEND	        = 0x0182,
-	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
-	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
-	TPM2_CC_CREATE_LOADED           = 0x0191,
-	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
-};
-
-enum tpm2_permanent_handles {
-	TPM2_RS_PW		= 0x40000009,
-};
-
-enum tpm2_capabilities {
-	TPM2_CAP_HANDLES	= 1,
-	TPM2_CAP_COMMANDS	= 2,
-	TPM2_CAP_PCRS		= 5,
-	TPM2_CAP_TPM_PROPERTIES = 6,
-};
-
-enum tpm2_properties {
-	TPM_PT_TOTAL_COMMANDS	= 0x0129,
-};
-
-enum tpm2_startup_types {
-	TPM2_SU_CLEAR	= 0x0000,
-	TPM2_SU_STATE	= 0x0001,
-};
-
-enum tpm2_cc_attrs {
-	TPM2_CC_ATTR_CHANDLES	= 25,
-	TPM2_CC_ATTR_RHANDLE	= 28,
-};
-
-#define TPM_VID_INTEL    0x8086
-#define TPM_VID_WINBOND  0x1050
-#define TPM_VID_STM      0x104A
-
-enum tpm_chip_flags {
-	TPM_CHIP_FLAG_TPM2		= BIT(1),
-	TPM_CHIP_FLAG_IRQ		= BIT(2),
-	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
-	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
-	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
-	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
-};
-
-#define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
-
-struct tpm_header {
-	__be16 tag;
-	__be32 length;
-	union {
-		__be32 ordinal;
-		__be32 return_code;
-	};
-} __packed;
-
 #define TPM_TAG_RQU_COMMAND 193
 
 struct	stclear_flags_t {
@@ -272,102 +153,6 @@ enum tpm_sub_capabilities {
  * compiler warnings about stack frame size. */
 #define TPM_MAX_RNG_DATA	128
 
-/* A string buffer type for constructing TPM commands. This is based on the
- * ideas of string buffer code in security/keys/trusted.h but is heap based
- * in order to keep the stack usage minimal.
- */
-
-enum tpm_buf_flags {
-	TPM_BUF_OVERFLOW	= BIT(0),
-};
-
-struct tpm_buf {
-	struct page *data_page;
-	unsigned int flags;
-	u8 *data;
-};
-
-static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	head->tag = cpu_to_be16(tag);
-	head->length = cpu_to_be32(sizeof(*head));
-	head->ordinal = cpu_to_be32(ordinal);
-}
-
-static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
-{
-	buf->data_page = alloc_page(GFP_HIGHUSER);
-	if (!buf->data_page)
-		return -ENOMEM;
-
-	buf->flags = 0;
-	buf->data = kmap(buf->data_page);
-	tpm_buf_reset(buf, tag, ordinal);
-	return 0;
-}
-
-static inline void tpm_buf_destroy(struct tpm_buf *buf)
-{
-	kunmap(buf->data_page);
-	__free_page(buf->data_page);
-}
-
-static inline u32 tpm_buf_length(struct tpm_buf *buf)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	return be32_to_cpu(head->length);
-}
-
-static inline u16 tpm_buf_tag(struct tpm_buf *buf)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	return be16_to_cpu(head->tag);
-}
-
-static inline void tpm_buf_append(struct tpm_buf *buf,
-				  const unsigned char *new_data,
-				  unsigned int new_len)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-	u32 len = tpm_buf_length(buf);
-
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_OVERFLOW)
-		return;
-
-	if ((len + new_len) > PAGE_SIZE) {
-		WARN(1, "tpm_buf: overflow\n");
-		buf->flags |= TPM_BUF_OVERFLOW;
-		return;
-	}
-
-	memcpy(&buf->data[len], new_data, new_len);
-	head->length = cpu_to_be32(len + new_len);
-}
-
-static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
-{
-	tpm_buf_append(buf, &value, 1);
-}
-
-static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
-{
-	__be16 value2 = cpu_to_be16(value);
-
-	tpm_buf_append(buf, (u8 *) &value2, 2);
-}
-
-static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
-{
-	__be32 value2 = cpu_to_be32(value);
-
-	tpm_buf_append(buf, (u8 *) &value2, 4);
-}
-
 extern struct class *tpm_class;
 extern struct class *tpmrm_class;
 extern dev_t tpm_devt;
diff --git a/include/keys/trusted.h b/include/keys/trusted.h
index 0071298..841ae11 100644
--- a/include/keys/trusted.h
+++ b/include/keys/trusted.h
@@ -17,7 +17,7 @@
 #define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
 #define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
 
-struct tpm_buf {
+struct tpm1_buf {
 	int len;
 	unsigned char data[MAX_BUF_SIZE];
 };
@@ -46,7 +46,7 @@ int TSS_checkhmac1(unsigned char *buffer,
 			  unsigned int keylen, ...);
 
 int trusted_tpm_send(unsigned char *cmd, size_t buflen);
-int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
+int oiap(struct tpm1_buf *tb, uint32_t *handle, unsigned char *nonce);
 
 #define TPM_DEBUG 0
 
@@ -110,24 +110,24 @@ static inline void dump_tpm_buf(unsigned char *buf)
 }
 #endif
 
-static inline void store8(struct tpm_buf *buf, const unsigned char value)
+static inline void store8(struct tpm1_buf *buf, const unsigned char value)
 {
 	buf->data[buf->len++] = value;
 }
 
-static inline void store16(struct tpm_buf *buf, const uint16_t value)
+static inline void store16(struct tpm1_buf *buf, const uint16_t value)
 {
 	*(uint16_t *) & buf->data[buf->len] = htons(value);
 	buf->len += sizeof value;
 }
 
-static inline void store32(struct tpm_buf *buf, const uint32_t value)
+static inline void store32(struct tpm1_buf *buf, const uint32_t value)
 {
 	*(uint32_t *) & buf->data[buf->len] = htonl(value);
 	buf->len += sizeof value;
 }
 
-static inline void storebytes(struct tpm_buf *buf, const unsigned char *in,
+static inline void storebytes(struct tpm1_buf *buf, const unsigned char *in,
 			      const int len)
 {
 	memcpy(buf->data + buf->len, in, len);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index bb1d1ac..19c68f8 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -21,6 +21,7 @@
 #include <linux/acpi.h>
 #include <linux/cdev.h>
 #include <linux/fs.h>
+#include <linux/highmem.h>
 #include <crypto/hash_info.h>
 
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
@@ -163,6 +164,220 @@ struct tpm_chip {
 	int locality;
 };
 
+#define TPM_HEADER_SIZE		10
+
+enum tpm2_const {
+	TPM2_PLATFORM_PCR       =     24,
+	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
+};
+
+enum tpm2_timeouts {
+	TPM2_TIMEOUT_A          =    750,
+	TPM2_TIMEOUT_B          =   2000,
+	TPM2_TIMEOUT_C          =    200,
+	TPM2_TIMEOUT_D          =     30,
+	TPM2_DURATION_SHORT     =     20,
+	TPM2_DURATION_MEDIUM    =    750,
+	TPM2_DURATION_LONG      =   2000,
+	TPM2_DURATION_LONG_LONG = 300000,
+	TPM2_DURATION_DEFAULT   = 120000,
+};
+
+enum tpm2_structures {
+	TPM2_ST_NO_SESSIONS	= 0x8001,
+	TPM2_ST_SESSIONS	= 0x8002,
+};
+
+/* Indicates from what layer of the software stack the error comes from */
+#define TSS2_RC_LAYER_SHIFT	 16
+#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
+
+enum tpm2_return_codes {
+	TPM2_RC_SUCCESS		= 0x0000,
+	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
+	TPM2_RC_HANDLE		= 0x008B,
+	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
+	TPM2_RC_FAILURE		= 0x0101,
+	TPM2_RC_DISABLED	= 0x0120,
+	TPM2_RC_COMMAND_CODE    = 0x0143,
+	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
+	TPM2_RC_REFERENCE_H0	= 0x0910,
+	TPM2_RC_RETRY		= 0x0922,
+};
+
+enum tpm2_command_codes {
+	TPM2_CC_FIRST		        = 0x011F,
+	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
+	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
+	TPM2_CC_CREATE_PRIMARY          = 0x0131,
+	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
+	TPM2_CC_SELF_TEST	        = 0x0143,
+	TPM2_CC_STARTUP		        = 0x0144,
+	TPM2_CC_SHUTDOWN	        = 0x0145,
+	TPM2_CC_NV_READ                 = 0x014E,
+	TPM2_CC_CREATE		        = 0x0153,
+	TPM2_CC_LOAD		        = 0x0157,
+	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
+	TPM2_CC_UNSEAL		        = 0x015E,
+	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
+	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
+	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
+	TPM2_CC_GET_CAPABILITY	        = 0x017A,
+	TPM2_CC_GET_RANDOM	        = 0x017B,
+	TPM2_CC_PCR_READ	        = 0x017E,
+	TPM2_CC_PCR_EXTEND	        = 0x0182,
+	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
+	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
+	TPM2_CC_CREATE_LOADED           = 0x0191,
+	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
+};
+
+enum tpm2_permanent_handles {
+	TPM2_RS_PW		= 0x40000009,
+};
+
+enum tpm2_capabilities {
+	TPM2_CAP_HANDLES	= 1,
+	TPM2_CAP_COMMANDS	= 2,
+	TPM2_CAP_PCRS		= 5,
+	TPM2_CAP_TPM_PROPERTIES = 6,
+};
+
+enum tpm2_properties {
+	TPM_PT_TOTAL_COMMANDS	= 0x0129,
+};
+
+enum tpm2_startup_types {
+	TPM2_SU_CLEAR	= 0x0000,
+	TPM2_SU_STATE	= 0x0001,
+};
+
+enum tpm2_cc_attrs {
+	TPM2_CC_ATTR_CHANDLES	= 25,
+	TPM2_CC_ATTR_RHANDLE	= 28,
+};
+
+#define TPM_VID_INTEL    0x8086
+#define TPM_VID_WINBOND  0x1050
+#define TPM_VID_STM      0x104A
+
+enum tpm_chip_flags {
+	TPM_CHIP_FLAG_TPM2		= BIT(1),
+	TPM_CHIP_FLAG_IRQ		= BIT(2),
+	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
+	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
+	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
+	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
+};
+
+#define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
+
+struct tpm_header {
+	__be16 tag;
+	__be32 length;
+	union {
+		__be32 ordinal;
+		__be32 return_code;
+	};
+} __packed;
+
+/* A string buffer type for constructing TPM commands. This is based on the
+ * ideas of string buffer code in security/keys/trusted.h but is heap based
+ * in order to keep the stack usage minimal.
+ */
+
+enum tpm_buf_flags {
+	TPM_BUF_OVERFLOW	= BIT(0),
+};
+
+struct tpm_buf {
+	struct page *data_page;
+	unsigned int flags;
+	u8 *data;
+};
+
+static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+
+	head->tag = cpu_to_be16(tag);
+	head->length = cpu_to_be32(sizeof(*head));
+	head->ordinal = cpu_to_be32(ordinal);
+}
+
+static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
+{
+	buf->data_page = alloc_page(GFP_HIGHUSER);
+	if (!buf->data_page)
+		return -ENOMEM;
+
+	buf->flags = 0;
+	buf->data = kmap(buf->data_page);
+	tpm_buf_reset(buf, tag, ordinal);
+	return 0;
+}
+
+static inline void tpm_buf_destroy(struct tpm_buf *buf)
+{
+	kunmap(buf->data_page);
+	__free_page(buf->data_page);
+}
+
+static inline u32 tpm_buf_length(struct tpm_buf *buf)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+
+	return be32_to_cpu(head->length);
+}
+
+static inline u16 tpm_buf_tag(struct tpm_buf *buf)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+
+	return be16_to_cpu(head->tag);
+}
+
+static inline void tpm_buf_append(struct tpm_buf *buf,
+				  const unsigned char *new_data,
+				  unsigned int new_len)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	u32 len = tpm_buf_length(buf);
+
+	/* Return silently if overflow has already happened. */
+	if (buf->flags & TPM_BUF_OVERFLOW)
+		return;
+
+	if ((len + new_len) > PAGE_SIZE) {
+		WARN(1, "tpm_buf: overflow\n");
+		buf->flags |= TPM_BUF_OVERFLOW;
+		return;
+	}
+
+	memcpy(&buf->data[len], new_data, new_len);
+	head->length = cpu_to_be32(len + new_len);
+}
+
+static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
+{
+	tpm_buf_append(buf, &value, 1);
+}
+
+static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
+{
+	__be16 value2 = cpu_to_be16(value);
+
+	tpm_buf_append(buf, (u8 *) &value2, 2);
+}
+
+static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
+{
+	__be32 value2 = cpu_to_be32(value);
+
+	tpm_buf_append(buf, (u8 *) &value2, 4);
+}
+
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
 extern int tpm_is_tpm2(struct tpm_chip *chip);
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 1fbd778..4cfae208 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -395,7 +395,7 @@ static int pcrlock(const int pcrnum)
 /*
  * Create an object specific authorisation protocol (OSAP) session
  */
-static int osap(struct tpm_buf *tb, struct osapsess *s,
+static int osap(struct tpm1_buf *tb, struct osapsess *s,
 		const unsigned char *key, uint16_t type, uint32_t handle)
 {
 	unsigned char enonce[TPM_NONCE_SIZE];
@@ -430,7 +430,7 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
 /*
  * Create an object independent authorisation protocol (oiap) session
  */
-int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
+int oiap(struct tpm1_buf *tb, uint32_t *handle, unsigned char *nonce)
 {
 	int ret;
 
@@ -464,7 +464,7 @@ struct tpm_digests {
  * Have the TPM seal(encrypt) the trusted key, possibly based on
  * Platform Configuration Registers (PCRs). AUTH1 for sealing key.
  */
-static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
+static int tpm_seal(struct tpm1_buf *tb, uint16_t keytype,
 		    uint32_t keyhandle, const unsigned char *keyauth,
 		    const unsigned char *data, uint32_t datalen,
 		    unsigned char *blob, uint32_t *bloblen,
@@ -579,7 +579,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 /*
  * use the AUTH2_COMMAND form of unseal, to authorize both key and blob
  */
-static int tpm_unseal(struct tpm_buf *tb,
+static int tpm_unseal(struct tpm1_buf *tb,
 		      uint32_t keyhandle, const unsigned char *keyauth,
 		      const unsigned char *blob, int bloblen,
 		      const unsigned char *blobauth,
@@ -670,7 +670,7 @@ static int tpm_unseal(struct tpm_buf *tb,
 static int key_seal(struct trusted_key_payload *p,
 		    struct trusted_key_options *o)
 {
-	struct tpm_buf *tb;
+	struct tpm1_buf *tb;
 	int ret;
 
 	tb = kzalloc(sizeof *tb, GFP_KERNEL);
@@ -696,7 +696,7 @@ static int key_seal(struct trusted_key_payload *p,
 static int key_unseal(struct trusted_key_payload *p,
 		      struct trusted_key_options *o)
 {
-	struct tpm_buf *tb;
+	struct tpm1_buf *tb;
 	int ret;
 
 	tb = kzalloc(sizeof *tb, GFP_KERNEL);
-- 
2.7.4

