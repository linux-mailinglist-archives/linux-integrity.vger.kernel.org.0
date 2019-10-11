Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55F4D4A63
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Oct 2019 00:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfJKWeD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Oct 2019 18:34:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbfJKWeC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Oct 2019 18:34:02 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 014F37BDD1
        for <linux-integrity@vger.kernel.org>; Fri, 11 Oct 2019 22:34:02 +0000 (UTC)
Received: by mail-io1-f72.google.com with SMTP id f5so16548258iob.17
        for <linux-integrity@vger.kernel.org>; Fri, 11 Oct 2019 15:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=GOa8Wn369aP3tTxyeGMq5MYrPQV8dGhafIMFQ/ohKFY=;
        b=OHqDI8SJuIB2nxRduDG9KctkRVCvrafITb4EDXRCW9Z31fMh8bO0RvaMg/QVTTRC7g
         7KpQIzTPwN7KGwv/md5HhdBdpV5HUDH8x0elLFAFXyPo9E7EAOlm9cL/SQL2gjOUCEGa
         hSb2QZjE1In/FHBrpqFxKkBMugCrgOPAASABYOaf6UYucBbdJGteJH771ABa+/BEGDtx
         ef4zRLnzpIrvmykBYe7Uz0TzfW2UXaWEP4zb6B8r1PtuTGOlIqOXQoxtk81y7BbQEu2M
         wAvsd94udOG9gMfRXEhwMav7zue8Od2AD8YuzT1bpkOISch3YtbEkZd3egeve+w9ghqf
         2kVw==
X-Gm-Message-State: APjAAAVybquZv/aI3qdTRlNPimLfJ4BKK1XVWihziySgPXN2ES0GpVnk
        LJ3atyAN+0ZZOjyeDNNKziptnmCncp6DYeMmJ9vKcIJTtQjYqLY3uSgd2kzhqvqw34lnD5ULsej
        dkT+W1AdiRshiRq1OYuSfl0nVBWXf
X-Received: by 2002:a02:a1c8:: with SMTP id o8mr21340353jah.90.1570833241079;
        Fri, 11 Oct 2019 15:34:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQbTC1Q/Io7yft+5w5AljtsOk5eLhczyHcjJHZylX7b5wKfZTlpYrCgz4Fp4UZO+930KJQeQ==
X-Received: by 2002:a02:a1c8:: with SMTP id o8mr21340281jah.90.1570833240553;
        Fri, 11 Oct 2019 15:34:00 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g4sm12067032iof.56.2019.10.11.15.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 15:33:59 -0700 (PDT)
Date:   Fri, 11 Oct 2019 15:33:57 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        peterhuewe@gmx.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, daniel.thompson@linaro.org
Subject: Re: [Patch v7 1/4] tpm: Move tpm_buf code to include/linux/
Message-ID: <20191011223357.ny6lvvn6ksytb2wc@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Sumit Garg <sumit.garg@linaro.org>,
        jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        peterhuewe@gmx.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org
References: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
 <1570425935-7435-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1570425935-7435-2-git-send-email-sumit.garg@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Oct 07 19, Sumit Garg wrote:
>Move tpm_buf code to common include/linux/tpm.h header so that it can
>be reused via other subsystems like trusted keys etc.
>
>Also rename trusted keys and asymmetric keys usage of TPM 1.x buffer
>implementation to tpm1_buf to avoid any compilation errors.
>
>Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>---
> crypto/asymmetric_keys/asym_tpm.c |  12 +--
> drivers/char/tpm/tpm.h            | 215 --------------------------------------
> include/keys/trusted.h            |  12 +--
> include/linux/tpm.h               | 215 ++++++++++++++++++++++++++++++++++++++
> security/keys/trusted.c           |  12 +--
> 5 files changed, 233 insertions(+), 233 deletions(-)
>
>diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
>index 76d2ce3..b88968d 100644
>--- a/crypto/asymmetric_keys/asym_tpm.c
>+++ b/crypto/asymmetric_keys/asym_tpm.c
>@@ -31,7 +31,7 @@
> /*
>  * Load a TPM key from the blob provided by userspace
>  */
>-static int tpm_loadkey2(struct tpm_buf *tb,
>+static int tpm_loadkey2(struct tpm1_buf *tb,
> 			uint32_t keyhandle, unsigned char *keyauth,
> 			const unsigned char *keyblob, int keybloblen,
> 			uint32_t *newhandle)
>@@ -99,7 +99,7 @@ static int tpm_loadkey2(struct tpm_buf *tb,
> /*
>  * Execute the FlushSpecific TPM command
>  */
>-static int tpm_flushspecific(struct tpm_buf *tb, uint32_t handle)
>+static int tpm_flushspecific(struct tpm1_buf *tb, uint32_t handle)
> {
> 	INIT_BUF(tb);
> 	store16(tb, TPM_TAG_RQU_COMMAND);
>@@ -115,7 +115,7 @@ static int tpm_flushspecific(struct tpm_buf *tb, uint32_t handle)
>  * Decrypt a blob provided by userspace using a specific key handle.
>  * The handle is a well known handle or previously loaded by e.g. LoadKey2
>  */
>-static int tpm_unbind(struct tpm_buf *tb,
>+static int tpm_unbind(struct tpm1_buf *tb,
> 			uint32_t keyhandle, unsigned char *keyauth,
> 			const unsigned char *blob, uint32_t bloblen,
> 			void *out, uint32_t outlen)
>@@ -201,7 +201,7 @@ static int tpm_unbind(struct tpm_buf *tb,
>  * up to key_length_in_bytes - 11 and not be limited to size 20 like the
>  * TPM_SS_RSASSAPKCS1v15_SHA1 signature scheme.
>  */
>-static int tpm_sign(struct tpm_buf *tb,
>+static int tpm_sign(struct tpm1_buf *tb,
> 		    uint32_t keyhandle, unsigned char *keyauth,
> 		    const unsigned char *blob, uint32_t bloblen,
> 		    void *out, uint32_t outlen)
>@@ -519,7 +519,7 @@ static int tpm_key_decrypt(struct tpm_key *tk,
> 			   struct kernel_pkey_params *params,
> 			   const void *in, void *out)
> {
>-	struct tpm_buf *tb;
>+	struct tpm1_buf *tb;
> 	uint32_t keyhandle;
> 	uint8_t srkauth[SHA1_DIGEST_SIZE];
> 	uint8_t keyauth[SHA1_DIGEST_SIZE];
>@@ -643,7 +643,7 @@ static int tpm_key_sign(struct tpm_key *tk,
> 			struct kernel_pkey_params *params,
> 			const void *in, void *out)
> {
>-	struct tpm_buf *tb;
>+	struct tpm1_buf *tb;
> 	uint32_t keyhandle;
> 	uint8_t srkauth[SHA1_DIGEST_SIZE];
> 	uint8_t keyauth[SHA1_DIGEST_SIZE];
>diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>index 80bca88..b174cf4 100644
>--- a/drivers/char/tpm/tpm.h
>+++ b/drivers/char/tpm/tpm.h
>@@ -25,7 +25,6 @@
> #include <linux/platform_device.h>
> #include <linux/io.h>
> #include <linux/tpm.h>
>-#include <linux/highmem.h>
> #include <linux/tpm_eventlog.h>
>
> #ifdef CONFIG_X86
>@@ -58,124 +57,6 @@ enum tpm_addr {
> #define TPM_ERR_DISABLED        0x7
> #define TPM_ERR_INVALID_POSTINIT 38
>
>-#define TPM_HEADER_SIZE		10
>-
>-enum tpm2_const {
>-	TPM2_PLATFORM_PCR       =     24,
>-	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
>-};
>-
>-enum tpm2_timeouts {
>-	TPM2_TIMEOUT_A          =    750,
>-	TPM2_TIMEOUT_B          =   2000,
>-	TPM2_TIMEOUT_C          =    200,
>-	TPM2_TIMEOUT_D          =     30,
>-	TPM2_DURATION_SHORT     =     20,
>-	TPM2_DURATION_MEDIUM    =    750,
>-	TPM2_DURATION_LONG      =   2000,
>-	TPM2_DURATION_LONG_LONG = 300000,
>-	TPM2_DURATION_DEFAULT   = 120000,
>-};
>-
>-enum tpm2_structures {
>-	TPM2_ST_NO_SESSIONS	= 0x8001,
>-	TPM2_ST_SESSIONS	= 0x8002,
>-};
>-
>-/* Indicates from what layer of the software stack the error comes from */
>-#define TSS2_RC_LAYER_SHIFT	 16
>-#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
>-
>-enum tpm2_return_codes {
>-	TPM2_RC_SUCCESS		= 0x0000,
>-	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
>-	TPM2_RC_HANDLE		= 0x008B,
>-	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
>-	TPM2_RC_FAILURE		= 0x0101,
>-	TPM2_RC_DISABLED	= 0x0120,
>-	TPM2_RC_COMMAND_CODE    = 0x0143,
>-	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
>-	TPM2_RC_REFERENCE_H0	= 0x0910,
>-	TPM2_RC_RETRY		= 0x0922,
>-};
>-
>-enum tpm2_command_codes {
>-	TPM2_CC_FIRST		        = 0x011F,
>-	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
>-	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
>-	TPM2_CC_CREATE_PRIMARY          = 0x0131,
>-	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
>-	TPM2_CC_SELF_TEST	        = 0x0143,
>-	TPM2_CC_STARTUP		        = 0x0144,
>-	TPM2_CC_SHUTDOWN	        = 0x0145,
>-	TPM2_CC_NV_READ                 = 0x014E,
>-	TPM2_CC_CREATE		        = 0x0153,
>-	TPM2_CC_LOAD		        = 0x0157,
>-	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
>-	TPM2_CC_UNSEAL		        = 0x015E,
>-	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
>-	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
>-	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
>-	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
>-	TPM2_CC_GET_CAPABILITY	        = 0x017A,
>-	TPM2_CC_GET_RANDOM	        = 0x017B,
>-	TPM2_CC_PCR_READ	        = 0x017E,
>-	TPM2_CC_PCR_EXTEND	        = 0x0182,
>-	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
>-	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
>-	TPM2_CC_CREATE_LOADED           = 0x0191,
>-	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
>-};
>-
>-enum tpm2_permanent_handles {
>-	TPM2_RS_PW		= 0x40000009,
>-};
>-
>-enum tpm2_capabilities {
>-	TPM2_CAP_HANDLES	= 1,
>-	TPM2_CAP_COMMANDS	= 2,
>-	TPM2_CAP_PCRS		= 5,
>-	TPM2_CAP_TPM_PROPERTIES = 6,
>-};
>-
>-enum tpm2_properties {
>-	TPM_PT_TOTAL_COMMANDS	= 0x0129,
>-};
>-
>-enum tpm2_startup_types {
>-	TPM2_SU_CLEAR	= 0x0000,
>-	TPM2_SU_STATE	= 0x0001,
>-};
>-
>-enum tpm2_cc_attrs {
>-	TPM2_CC_ATTR_CHANDLES	= 25,
>-	TPM2_CC_ATTR_RHANDLE	= 28,
>-};
>-
>-#define TPM_VID_INTEL    0x8086
>-#define TPM_VID_WINBOND  0x1050
>-#define TPM_VID_STM      0x104A
>-
>-enum tpm_chip_flags {
>-	TPM_CHIP_FLAG_TPM2		= BIT(1),
>-	TPM_CHIP_FLAG_IRQ		= BIT(2),
>-	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
>-	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
>-	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
>-	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
>-};
>-
>-#define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
>-
>-struct tpm_header {
>-	__be16 tag;
>-	__be32 length;
>-	union {
>-		__be32 ordinal;
>-		__be32 return_code;
>-	};
>-} __packed;
>-
> #define TPM_TAG_RQU_COMMAND 193
>
> struct	stclear_flags_t {
>@@ -272,102 +153,6 @@ enum tpm_sub_capabilities {
>  * compiler warnings about stack frame size. */
> #define TPM_MAX_RNG_DATA	128
>
>-/* A string buffer type for constructing TPM commands. This is based on the
>- * ideas of string buffer code in security/keys/trusted.h but is heap based
>- * in order to keep the stack usage minimal.
>- */
>-
>-enum tpm_buf_flags {
>-	TPM_BUF_OVERFLOW	= BIT(0),
>-};
>-
>-struct tpm_buf {
>-	struct page *data_page;
>-	unsigned int flags;
>-	u8 *data;
>-};
>-
>-static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>-{
>-	struct tpm_header *head = (struct tpm_header *)buf->data;
>-
>-	head->tag = cpu_to_be16(tag);
>-	head->length = cpu_to_be32(sizeof(*head));
>-	head->ordinal = cpu_to_be32(ordinal);
>-}
>-
>-static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>-{
>-	buf->data_page = alloc_page(GFP_HIGHUSER);
>-	if (!buf->data_page)
>-		return -ENOMEM;
>-
>-	buf->flags = 0;
>-	buf->data = kmap(buf->data_page);
>-	tpm_buf_reset(buf, tag, ordinal);
>-	return 0;
>-}
>-
>-static inline void tpm_buf_destroy(struct tpm_buf *buf)
>-{
>-	kunmap(buf->data_page);
>-	__free_page(buf->data_page);
>-}
>-
>-static inline u32 tpm_buf_length(struct tpm_buf *buf)
>-{
>-	struct tpm_header *head = (struct tpm_header *)buf->data;
>-
>-	return be32_to_cpu(head->length);
>-}
>-
>-static inline u16 tpm_buf_tag(struct tpm_buf *buf)
>-{
>-	struct tpm_header *head = (struct tpm_header *)buf->data;
>-
>-	return be16_to_cpu(head->tag);
>-}
>-
>-static inline void tpm_buf_append(struct tpm_buf *buf,
>-				  const unsigned char *new_data,
>-				  unsigned int new_len)
>-{
>-	struct tpm_header *head = (struct tpm_header *)buf->data;
>-	u32 len = tpm_buf_length(buf);
>-
>-	/* Return silently if overflow has already happened. */
>-	if (buf->flags & TPM_BUF_OVERFLOW)
>-		return;
>-
>-	if ((len + new_len) > PAGE_SIZE) {
>-		WARN(1, "tpm_buf: overflow\n");
>-		buf->flags |= TPM_BUF_OVERFLOW;
>-		return;
>-	}
>-
>-	memcpy(&buf->data[len], new_data, new_len);
>-	head->length = cpu_to_be32(len + new_len);
>-}
>-
>-static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
>-{
>-	tpm_buf_append(buf, &value, 1);
>-}
>-
>-static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
>-{
>-	__be16 value2 = cpu_to_be16(value);
>-
>-	tpm_buf_append(buf, (u8 *) &value2, 2);
>-}
>-
>-static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
>-{
>-	__be32 value2 = cpu_to_be32(value);
>-
>-	tpm_buf_append(buf, (u8 *) &value2, 4);
>-}
>-
> extern struct class *tpm_class;
> extern struct class *tpmrm_class;
> extern dev_t tpm_devt;
>diff --git a/include/keys/trusted.h b/include/keys/trusted.h
>index 0071298..841ae11 100644
>--- a/include/keys/trusted.h
>+++ b/include/keys/trusted.h
>@@ -17,7 +17,7 @@
> #define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
> #define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
>
>-struct tpm_buf {
>+struct tpm1_buf {
> 	int len;
> 	unsigned char data[MAX_BUF_SIZE];
> };
>@@ -46,7 +46,7 @@ int TSS_checkhmac1(unsigned char *buffer,
> 			  unsigned int keylen, ...);
>
> int trusted_tpm_send(unsigned char *cmd, size_t buflen);
>-int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
>+int oiap(struct tpm1_buf *tb, uint32_t *handle, unsigned char *nonce);
>
> #define TPM_DEBUG 0
>
>@@ -110,24 +110,24 @@ static inline void dump_tpm_buf(unsigned char *buf)
> }
> #endif
>
>-static inline void store8(struct tpm_buf *buf, const unsigned char value)
>+static inline void store8(struct tpm1_buf *buf, const unsigned char value)
> {
> 	buf->data[buf->len++] = value;
> }
>
>-static inline void store16(struct tpm_buf *buf, const uint16_t value)
>+static inline void store16(struct tpm1_buf *buf, const uint16_t value)
> {
> 	*(uint16_t *) & buf->data[buf->len] = htons(value);
> 	buf->len += sizeof value;
> }
>
>-static inline void store32(struct tpm_buf *buf, const uint32_t value)
>+static inline void store32(struct tpm1_buf *buf, const uint32_t value)
> {
> 	*(uint32_t *) & buf->data[buf->len] = htonl(value);
> 	buf->len += sizeof value;
> }
>
>-static inline void storebytes(struct tpm_buf *buf, const unsigned char *in,
>+static inline void storebytes(struct tpm1_buf *buf, const unsigned char *in,
> 			      const int len)
> {
> 	memcpy(buf->data + buf->len, in, len);
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index bb1d1ac..19c68f8 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -21,6 +21,7 @@
> #include <linux/acpi.h>
> #include <linux/cdev.h>
> #include <linux/fs.h>
>+#include <linux/highmem.h>
> #include <crypto/hash_info.h>
>
> #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
>@@ -163,6 +164,220 @@ struct tpm_chip {
> 	int locality;
> };
>
>+#define TPM_HEADER_SIZE		10
>+
>+enum tpm2_const {
>+	TPM2_PLATFORM_PCR       =     24,
>+	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
>+};
>+
>+enum tpm2_timeouts {
>+	TPM2_TIMEOUT_A          =    750,
>+	TPM2_TIMEOUT_B          =   2000,
>+	TPM2_TIMEOUT_C          =    200,
>+	TPM2_TIMEOUT_D          =     30,
>+	TPM2_DURATION_SHORT     =     20,
>+	TPM2_DURATION_MEDIUM    =    750,
>+	TPM2_DURATION_LONG      =   2000,
>+	TPM2_DURATION_LONG_LONG = 300000,
>+	TPM2_DURATION_DEFAULT   = 120000,
>+};
>+
>+enum tpm2_structures {
>+	TPM2_ST_NO_SESSIONS	= 0x8001,
>+	TPM2_ST_SESSIONS	= 0x8002,
>+};
>+
>+/* Indicates from what layer of the software stack the error comes from */
>+#define TSS2_RC_LAYER_SHIFT	 16
>+#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
>+
>+enum tpm2_return_codes {
>+	TPM2_RC_SUCCESS		= 0x0000,
>+	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
>+	TPM2_RC_HANDLE		= 0x008B,
>+	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
>+	TPM2_RC_FAILURE		= 0x0101,
>+	TPM2_RC_DISABLED	= 0x0120,
>+	TPM2_RC_COMMAND_CODE    = 0x0143,
>+	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
>+	TPM2_RC_REFERENCE_H0	= 0x0910,
>+	TPM2_RC_RETRY		= 0x0922,
>+};
>+
>+enum tpm2_command_codes {
>+	TPM2_CC_FIRST		        = 0x011F,
>+	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
>+	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
>+	TPM2_CC_CREATE_PRIMARY          = 0x0131,
>+	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
>+	TPM2_CC_SELF_TEST	        = 0x0143,
>+	TPM2_CC_STARTUP		        = 0x0144,
>+	TPM2_CC_SHUTDOWN	        = 0x0145,
>+	TPM2_CC_NV_READ                 = 0x014E,
>+	TPM2_CC_CREATE		        = 0x0153,
>+	TPM2_CC_LOAD		        = 0x0157,
>+	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
>+	TPM2_CC_UNSEAL		        = 0x015E,
>+	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
>+	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
>+	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
>+	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
>+	TPM2_CC_GET_CAPABILITY	        = 0x017A,
>+	TPM2_CC_GET_RANDOM	        = 0x017B,
>+	TPM2_CC_PCR_READ	        = 0x017E,
>+	TPM2_CC_PCR_EXTEND	        = 0x0182,
>+	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
>+	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
>+	TPM2_CC_CREATE_LOADED           = 0x0191,
>+	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
>+};
>+
>+enum tpm2_permanent_handles {
>+	TPM2_RS_PW		= 0x40000009,
>+};
>+
>+enum tpm2_capabilities {
>+	TPM2_CAP_HANDLES	= 1,
>+	TPM2_CAP_COMMANDS	= 2,
>+	TPM2_CAP_PCRS		= 5,
>+	TPM2_CAP_TPM_PROPERTIES = 6,
>+};
>+
>+enum tpm2_properties {
>+	TPM_PT_TOTAL_COMMANDS	= 0x0129,
>+};
>+
>+enum tpm2_startup_types {
>+	TPM2_SU_CLEAR	= 0x0000,
>+	TPM2_SU_STATE	= 0x0001,
>+};
>+
>+enum tpm2_cc_attrs {
>+	TPM2_CC_ATTR_CHANDLES	= 25,
>+	TPM2_CC_ATTR_RHANDLE	= 28,
>+};
>+
>+#define TPM_VID_INTEL    0x8086
>+#define TPM_VID_WINBOND  0x1050
>+#define TPM_VID_STM      0x104A
>+
>+enum tpm_chip_flags {
>+	TPM_CHIP_FLAG_TPM2		= BIT(1),
>+	TPM_CHIP_FLAG_IRQ		= BIT(2),
>+	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
>+	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
>+	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
>+	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
>+};
>+
>+#define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
>+
>+struct tpm_header {
>+	__be16 tag;
>+	__be32 length;
>+	union {
>+		__be32 ordinal;
>+		__be32 return_code;
>+	};
>+} __packed;
>+
>+/* A string buffer type for constructing TPM commands. This is based on the
>+ * ideas of string buffer code in security/keys/trusted.h but is heap based
>+ * in order to keep the stack usage minimal.
>+ */
>+
>+enum tpm_buf_flags {
>+	TPM_BUF_OVERFLOW	= BIT(0),
>+};
>+
>+struct tpm_buf {
>+	struct page *data_page;
>+	unsigned int flags;
>+	u8 *data;
>+};
>+
>+static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>+{
>+	struct tpm_header *head = (struct tpm_header *)buf->data;
>+
>+	head->tag = cpu_to_be16(tag);
>+	head->length = cpu_to_be32(sizeof(*head));
>+	head->ordinal = cpu_to_be32(ordinal);
>+}
>+
>+static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>+{
>+	buf->data_page = alloc_page(GFP_HIGHUSER);
>+	if (!buf->data_page)
>+		return -ENOMEM;
>+
>+	buf->flags = 0;
>+	buf->data = kmap(buf->data_page);
>+	tpm_buf_reset(buf, tag, ordinal);
>+	return 0;
>+}
>+
>+static inline void tpm_buf_destroy(struct tpm_buf *buf)
>+{
>+	kunmap(buf->data_page);
>+	__free_page(buf->data_page);
>+}
>+
>+static inline u32 tpm_buf_length(struct tpm_buf *buf)
>+{
>+	struct tpm_header *head = (struct tpm_header *)buf->data;
>+
>+	return be32_to_cpu(head->length);
>+}
>+
>+static inline u16 tpm_buf_tag(struct tpm_buf *buf)
>+{
>+	struct tpm_header *head = (struct tpm_header *)buf->data;
>+
>+	return be16_to_cpu(head->tag);
>+}
>+
>+static inline void tpm_buf_append(struct tpm_buf *buf,
>+				  const unsigned char *new_data,
>+				  unsigned int new_len)
>+{
>+	struct tpm_header *head = (struct tpm_header *)buf->data;
>+	u32 len = tpm_buf_length(buf);
>+
>+	/* Return silently if overflow has already happened. */
>+	if (buf->flags & TPM_BUF_OVERFLOW)
>+		return;
>+
>+	if ((len + new_len) > PAGE_SIZE) {
>+		WARN(1, "tpm_buf: overflow\n");
>+		buf->flags |= TPM_BUF_OVERFLOW;
>+		return;
>+	}
>+
>+	memcpy(&buf->data[len], new_data, new_len);
>+	head->length = cpu_to_be32(len + new_len);
>+}
>+
>+static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
>+{
>+	tpm_buf_append(buf, &value, 1);
>+}
>+
>+static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
>+{
>+	__be16 value2 = cpu_to_be16(value);
>+
>+	tpm_buf_append(buf, (u8 *) &value2, 2);
>+}
>+
>+static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
>+{
>+	__be32 value2 = cpu_to_be32(value);
>+
>+	tpm_buf_append(buf, (u8 *) &value2, 4);
>+}
>+
> #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
>
> extern int tpm_is_tpm2(struct tpm_chip *chip);
>diff --git a/security/keys/trusted.c b/security/keys/trusted.c
>index 1fbd778..4cfae208 100644
>--- a/security/keys/trusted.c
>+++ b/security/keys/trusted.c
>@@ -395,7 +395,7 @@ static int pcrlock(const int pcrnum)
> /*
>  * Create an object specific authorisation protocol (OSAP) session
>  */
>-static int osap(struct tpm_buf *tb, struct osapsess *s,
>+static int osap(struct tpm1_buf *tb, struct osapsess *s,
> 		const unsigned char *key, uint16_t type, uint32_t handle)
> {
> 	unsigned char enonce[TPM_NONCE_SIZE];
>@@ -430,7 +430,7 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
> /*
>  * Create an object independent authorisation protocol (oiap) session
>  */
>-int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
>+int oiap(struct tpm1_buf *tb, uint32_t *handle, unsigned char *nonce)
> {
> 	int ret;
>
>@@ -464,7 +464,7 @@ struct tpm_digests {
>  * Have the TPM seal(encrypt) the trusted key, possibly based on
>  * Platform Configuration Registers (PCRs). AUTH1 for sealing key.
>  */
>-static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
>+static int tpm_seal(struct tpm1_buf *tb, uint16_t keytype,
> 		    uint32_t keyhandle, const unsigned char *keyauth,
> 		    const unsigned char *data, uint32_t datalen,
> 		    unsigned char *blob, uint32_t *bloblen,
>@@ -579,7 +579,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
> /*
>  * use the AUTH2_COMMAND form of unseal, to authorize both key and blob
>  */
>-static int tpm_unseal(struct tpm_buf *tb,
>+static int tpm_unseal(struct tpm1_buf *tb,
> 		      uint32_t keyhandle, const unsigned char *keyauth,
> 		      const unsigned char *blob, int bloblen,
> 		      const unsigned char *blobauth,
>@@ -670,7 +670,7 @@ static int tpm_unseal(struct tpm_buf *tb,
> static int key_seal(struct trusted_key_payload *p,
> 		    struct trusted_key_options *o)
> {
>-	struct tpm_buf *tb;
>+	struct tpm1_buf *tb;
> 	int ret;
>
> 	tb = kzalloc(sizeof *tb, GFP_KERNEL);
>@@ -696,7 +696,7 @@ static int key_seal(struct trusted_key_payload *p,
> static int key_unseal(struct trusted_key_payload *p,
> 		      struct trusted_key_options *o)
> {
>-	struct tpm_buf *tb;
>+	struct tpm1_buf *tb;
> 	int ret;
>
> 	tb = kzalloc(sizeof *tb, GFP_KERNEL);
>-- 
>2.7.4
>

I reviewed version on tpmdd/master. Will have to massage it again
once James' v2 patch is merged, but that is trivial.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
