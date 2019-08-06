Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 812F5832DF
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2019 15:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbfHFNir (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Aug 2019 09:38:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42566 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731883AbfHFNir (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Aug 2019 09:38:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so41614691pgb.9
        for <linux-integrity@vger.kernel.org>; Tue, 06 Aug 2019 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zKTvfj2ELrKJ93b9VBL1WxsDHmFYEAwj0nrmMvpHwKo=;
        b=J+txHFkAGa6Yx79IZhq4+RYU88rxOuTLOZGVNYxNute/2gpSDQEyYeSfMemqt/Ncwm
         OMKmgN84d0hC8SM4q7gfb4QC9hi9zmCElJJwXW02tPviQ4G+EqhUJeS9Ad8Wbrip6TNm
         mlv2D9bFAnxUc6uMv1RQAJDcQXwChcnRw2jUDmC18RKQrXE0ydcAqUnt82LYzHPwKHJ3
         ScHQBUA2KAJz4PPAiA9N78jJG5CqfQS7y3HLsaYjpCo60JB7tQhotuNyiW9FR5lM9XXF
         V6DzZ3iB3EQA6fFBwLAudnRGbC2Hj/BFbioKKv5/43m26RwF6XAoM6/DdMYnYOkYAv1b
         QEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zKTvfj2ELrKJ93b9VBL1WxsDHmFYEAwj0nrmMvpHwKo=;
        b=eVLmhZQypH1TSx04GOckEcfRQisMMFZbfXbKf1WH0OhRerg3XD5KbsdE1QpSGEbNlJ
         gCWkmGw4dDY7O7rR0Ab1LmyNPr5UFPFc2PrIHmLzc66DIACw/CKcCEUvnLQeFm74NwvB
         SUsFfI1xWUH+DExtqqrwAzPjx0iJuuesfKS5lR8kWDajjUellAe6k90rKXqgh7siBPOm
         kxee9wC7vPi+JuSwAAK5+uh7kDgyAFh38kW2ubT9U+y+bkl/iDYfxGQFAvJSR4onGSal
         YPt37PNJNkN02YYvnmrEE77h4x/lnI7/dKmiDOQJhBA2ql7xFdISHSua1JMr9IHEUKSc
         0ooA==
X-Gm-Message-State: APjAAAU1n1Gonf5RuRTAiteDNFkhw7cuDPFzjOVHMXl1K5CLEZkoWN6h
        HapLaNymWsa6VHEvIRJrOj4ZGg==
X-Google-Smtp-Source: APXvYqx9DbWogKRHk3qAgZ5Ve4AGujgE9VYwMkGCTMG2mEMT5rVTTc2zbpIsXTv7qZaFGGycBpxIkA==
X-Received: by 2002:a17:90a:8a91:: with SMTP id x17mr3292160pjn.95.1565098725464;
        Tue, 06 Aug 2019 06:38:45 -0700 (PDT)
Received: from localhost.localdomain ([45.114.72.197])
        by smtp.gmail.com with ESMTPSA id l4sm89183984pff.50.2019.08.06.06.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 06:38:44 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
Date:   Tue,  6 Aug 2019 19:07:19 +0530
Message-Id: <1565098640-12536-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move TPM2 trusted keys code to trusted keys subsystem.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/char/tpm/tpm-interface.c          |  56 -----
 drivers/char/tpm/tpm.h                    | 224 ------------------
 drivers/char/tpm/tpm2-cmd.c               | 307 ------------------------
 include/keys/trusted_tpm.h                |  23 +-
 include/linux/tpm.h                       | 264 +++++++++++++++++++--
 security/keys/trusted-keys/Makefile       |   3 +-
 security/keys/trusted-keys/trusted-tpm.c  |  16 +-
 security/keys/trusted-keys/trusted-tpm2.c | 378 ++++++++++++++++++++++++++++++
 8 files changed, 652 insertions(+), 619 deletions(-)
 create mode 100644 security/keys/trusted-keys/trusted-tpm2.c

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1b4f95c..208e5ba 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -454,62 +454,6 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 }
 EXPORT_SYMBOL_GPL(tpm_get_random);
 
-/**
- * tpm_seal_trusted() - seal a trusted key payload
- * @chip:	a &struct tpm_chip instance, %NULL for the default chip
- * @options:	authentication values and other options
- * @payload:	the key data in clear and encrypted form
- *
- * Note: only TPM 2.0 chip are supported. TPM 1.x implementation is located in
- * the keyring subsystem.
- *
- * Return: same as with tpm_transmit_cmd()
- */
-int tpm_seal_trusted(struct tpm_chip *chip, struct trusted_key_payload *payload,
-		     struct trusted_key_options *options)
-{
-	int rc;
-
-	chip = tpm_find_get_ops(chip);
-	if (!chip || !(chip->flags & TPM_CHIP_FLAG_TPM2))
-		return -ENODEV;
-
-	rc = tpm2_seal_trusted(chip, payload, options);
-
-	tpm_put_ops(chip);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(tpm_seal_trusted);
-
-/**
- * tpm_unseal_trusted() - unseal a trusted key
- * @chip:	a &struct tpm_chip instance, %NULL for the default chip
- * @options:	authentication values and other options
- * @payload:	the key data in clear and encrypted form
- *
- * Note: only TPM 2.0 chip are supported. TPM 1.x implementation is located in
- * the keyring subsystem.
- *
- * Return: same as with tpm_transmit_cmd()
- */
-int tpm_unseal_trusted(struct tpm_chip *chip,
-		       struct trusted_key_payload *payload,
-		       struct trusted_key_options *options)
-{
-	int rc;
-
-	chip = tpm_find_get_ops(chip);
-	if (!chip || !(chip->flags & TPM_CHIP_FLAG_TPM2))
-		return -ENODEV;
-
-	rc = tpm2_unseal_trusted(chip, payload, options);
-
-	tpm_put_ops(chip);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(tpm_unseal_trusted);
-
 static int __init tpm_init(void)
 {
 	int rc;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index e503ffc..0705d44 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -25,7 +25,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/tpm.h>
-#include <linux/highmem.h>
 #include <linux/tpm_eventlog.h>
 
 #ifdef CONFIG_X86
@@ -58,123 +57,12 @@ enum tpm_addr {
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
 #define TPM_VID_INTEL    0x8086
 #define TPM_VID_WINBOND  0x1050
 #define TPM_VID_STM      0x104A
 
-enum tpm_chip_flags {
-	TPM_CHIP_FLAG_TPM2		= BIT(1),
-	TPM_CHIP_FLAG_IRQ		= BIT(2),
-	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
-	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
-	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
-};
-
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
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
@@ -274,102 +162,6 @@ enum tpm_sub_capabilities {
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
@@ -378,8 +170,6 @@ extern const struct file_operations tpmrm_fops;
 extern struct idr dev_nums_idr;
 
 ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz);
-ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
-			 size_t min_rsp_body_length, const char *desc);
 int tpm_get_timeouts(struct tpm_chip *);
 int tpm_auto_startup(struct tpm_chip *chip);
 
@@ -406,9 +196,7 @@ static inline void tpm_msleep(unsigned int delay_msec)
 
 int tpm_chip_start(struct tpm_chip *chip);
 void tpm_chip_stop(struct tpm_chip *chip);
-struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
 __must_check int tpm_try_get_ops(struct tpm_chip *chip);
-void tpm_put_ops(struct tpm_chip *chip);
 
 struct tpm_chip *tpm_chip_alloc(struct device *dev,
 				const struct tpm_class_ops *ops);
@@ -428,24 +216,12 @@ static inline void tpm_add_ppi(struct tpm_chip *chip)
 }
 #endif
 
-static inline u32 tpm2_rc_value(u32 rc)
-{
-	return (rc & BIT(7)) ? rc & 0xff : rc;
-}
-
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
-void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
-int tpm2_seal_trusted(struct tpm_chip *chip,
-		      struct trusted_key_payload *payload,
-		      struct trusted_key_options *options);
-int tpm2_unseal_trusted(struct tpm_chip *chip,
-			struct trusted_key_payload *payload,
-			struct trusted_key_options *options);
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index d103545..0a319e1 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -13,20 +13,6 @@
 
 #include "tpm.h"
 #include <crypto/hash_info.h>
-#include <keys/trusted-type.h>
-
-enum tpm2_object_attributes {
-	TPM2_OA_USER_WITH_AUTH		= BIT(6),
-};
-
-enum tpm2_session_attributes {
-	TPM2_SA_CONTINUE_SESSION	= BIT(0),
-};
-
-struct tpm2_hash {
-	unsigned int crypto_id;
-	unsigned int tpm_id;
-};
 
 static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
@@ -377,299 +363,6 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 	tpm_buf_destroy(&buf);
 }
 
-/**
- * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
- *
- * @buf: an allocated tpm_buf instance
- * @session_handle: session handle
- * @nonce: the session nonce, may be NULL if not used
- * @nonce_len: the session nonce length, may be 0 if not used
- * @attributes: the session attributes
- * @hmac: the session HMAC or password, may be NULL if not used
- * @hmac_len: the session HMAC or password length, maybe 0 if not used
- */
-static void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
-				 const u8 *nonce, u16 nonce_len,
-				 u8 attributes,
-				 const u8 *hmac, u16 hmac_len)
-{
-	tpm_buf_append_u32(buf, 9 + nonce_len + hmac_len);
-	tpm_buf_append_u32(buf, session_handle);
-	tpm_buf_append_u16(buf, nonce_len);
-
-	if (nonce && nonce_len)
-		tpm_buf_append(buf, nonce, nonce_len);
-
-	tpm_buf_append_u8(buf, attributes);
-	tpm_buf_append_u16(buf, hmac_len);
-
-	if (hmac && hmac_len)
-		tpm_buf_append(buf, hmac, hmac_len);
-}
-
-/**
- * tpm2_seal_trusted() - seal the payload of a trusted key
- *
- * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
- *
- * Return: < 0 on error and 0 on success.
- */
-int tpm2_seal_trusted(struct tpm_chip *chip,
-		      struct trusted_key_payload *payload,
-		      struct trusted_key_options *options)
-{
-	unsigned int blob_len;
-	struct tpm_buf buf;
-	u32 hash;
-	int i;
-	int rc;
-
-	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
-		if (options->hash == tpm2_hash_map[i].crypto_id) {
-			hash = tpm2_hash_map[i].tpm_id;
-			break;
-		}
-	}
-
-	if (i == ARRAY_SIZE(tpm2_hash_map))
-		return -EINVAL;
-
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
-	if (rc)
-		return rc;
-
-	tpm_buf_append_u32(&buf, options->keyhandle);
-	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     0 /* session_attributes */,
-			     options->keyauth /* hmac */,
-			     TPM_DIGEST_SIZE);
-
-	/* sensitive */
-	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len + 1);
-
-	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
-	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
-	tpm_buf_append_u16(&buf, payload->key_len + 1);
-	tpm_buf_append(&buf, payload->key, payload->key_len);
-	tpm_buf_append_u8(&buf, payload->migratable);
-
-	/* public */
-	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
-	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
-	tpm_buf_append_u16(&buf, hash);
-
-	/* policy */
-	if (options->policydigest_len) {
-		tpm_buf_append_u32(&buf, 0);
-		tpm_buf_append_u16(&buf, options->policydigest_len);
-		tpm_buf_append(&buf, options->policydigest,
-			       options->policydigest_len);
-	} else {
-		tpm_buf_append_u32(&buf, TPM2_OA_USER_WITH_AUTH);
-		tpm_buf_append_u16(&buf, 0);
-	}
-
-	/* public parameters */
-	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
-	tpm_buf_append_u16(&buf, 0);
-
-	/* outside info */
-	tpm_buf_append_u16(&buf, 0);
-
-	/* creation PCR */
-	tpm_buf_append_u32(&buf, 0);
-
-	if (buf.flags & TPM_BUF_OVERFLOW) {
-		rc = -E2BIG;
-		goto out;
-	}
-
-	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
-	if (rc)
-		goto out;
-
-	blob_len = be32_to_cpup((__be32 *) &buf.data[TPM_HEADER_SIZE]);
-	if (blob_len > MAX_BLOB_SIZE) {
-		rc = -E2BIG;
-		goto out;
-	}
-	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
-		rc = -EFAULT;
-		goto out;
-	}
-
-	memcpy(payload->blob, &buf.data[TPM_HEADER_SIZE + 4], blob_len);
-	payload->blob_len = blob_len;
-
-out:
-	tpm_buf_destroy(&buf);
-
-	if (rc > 0) {
-		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
-			rc = -EINVAL;
-		else
-			rc = -EPERM;
-	}
-
-	return rc;
-}
-
-/**
- * tpm2_load_cmd() - execute a TPM2_Load command
- *
- * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
- * @blob_handle: returned blob handle
- *
- * Return: 0 on success.
- *        -E2BIG on wrong payload size.
- *        -EPERM on tpm error status.
- *        < 0 error from tpm_transmit_cmd.
- */
-static int tpm2_load_cmd(struct tpm_chip *chip,
-			 struct trusted_key_payload *payload,
-			 struct trusted_key_options *options,
-			 u32 *blob_handle)
-{
-	struct tpm_buf buf;
-	unsigned int private_len;
-	unsigned int public_len;
-	unsigned int blob_len;
-	int rc;
-
-	private_len = be16_to_cpup((__be16 *) &payload->blob[0]);
-	if (private_len > (payload->blob_len - 2))
-		return -E2BIG;
-
-	public_len = be16_to_cpup((__be16 *) &payload->blob[2 + private_len]);
-	blob_len = private_len + public_len + 4;
-	if (blob_len > payload->blob_len)
-		return -E2BIG;
-
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
-	if (rc)
-		return rc;
-
-	tpm_buf_append_u32(&buf, options->keyhandle);
-	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     0 /* session_attributes */,
-			     options->keyauth /* hmac */,
-			     TPM_DIGEST_SIZE);
-
-	tpm_buf_append(&buf, payload->blob, blob_len);
-
-	if (buf.flags & TPM_BUF_OVERFLOW) {
-		rc = -E2BIG;
-		goto out;
-	}
-
-	rc = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
-	if (!rc)
-		*blob_handle = be32_to_cpup(
-			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
-
-out:
-	tpm_buf_destroy(&buf);
-
-	if (rc > 0)
-		rc = -EPERM;
-
-	return rc;
-}
-
-/**
- * tpm2_unseal_cmd() - execute a TPM2_Unload command
- *
- * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
- * @blob_handle: blob handle
- *
- * Return: 0 on success
- *         -EPERM on tpm error status
- *         < 0 error from tpm_transmit_cmd
- */
-static int tpm2_unseal_cmd(struct tpm_chip *chip,
-			   struct trusted_key_payload *payload,
-			   struct trusted_key_options *options,
-			   u32 blob_handle)
-{
-	struct tpm_buf buf;
-	u16 data_len;
-	u8 *data;
-	int rc;
-
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
-	if (rc)
-		return rc;
-
-	tpm_buf_append_u32(&buf, blob_handle);
-	tpm2_buf_append_auth(&buf,
-			     options->policyhandle ?
-			     options->policyhandle : TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     TPM2_SA_CONTINUE_SESSION,
-			     options->blobauth /* hmac */,
-			     TPM_DIGEST_SIZE);
-
-	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
-	if (rc > 0)
-		rc = -EPERM;
-
-	if (!rc) {
-		data_len = be16_to_cpup(
-			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
-		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
-			rc = -EFAULT;
-			goto out;
-		}
-
-		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 6 + data_len) {
-			rc = -EFAULT;
-			goto out;
-		}
-		data = &buf.data[TPM_HEADER_SIZE + 6];
-
-		memcpy(payload->key, data, data_len - 1);
-		payload->key_len = data_len - 1;
-		payload->migratable = data[data_len - 1];
-	}
-
-out:
-	tpm_buf_destroy(&buf);
-	return rc;
-}
-
-/**
- * tpm2_unseal_trusted() - unseal the payload of a trusted key
- *
- * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
- *
- * Return: Same as with tpm_transmit_cmd.
- */
-int tpm2_unseal_trusted(struct tpm_chip *chip,
-			struct trusted_key_payload *payload,
-			struct trusted_key_options *options)
-{
-	u32 blob_handle;
-	int rc;
-
-	rc = tpm2_load_cmd(chip, payload, options, &blob_handle);
-	if (rc)
-		return rc;
-
-	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
-	tpm2_flush_context(chip, blob_handle);
-	return rc;
-}
-
 struct tpm2_get_cap_out {
 	u8 more_data;
 	__be32 subcap_id;
diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index 7d7b108..77a2b5c 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -17,7 +17,7 @@
 #define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
 #define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
 
-struct tpm_buf {
+struct tpm1_buf {
 	int len;
 	unsigned char data[MAX_BUF_SIZE];
 };
@@ -46,7 +46,14 @@ int TSS_checkhmac1(unsigned char *buffer,
 			  unsigned int keylen, ...);
 
 int trusted_tpm_send(unsigned char *cmd, size_t buflen);
-int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
+int oiap(struct tpm1_buf *tb, uint32_t *handle, unsigned char *nonce);
+
+int tpm_seal_trusted(struct tpm_chip *chip,
+		     struct trusted_key_payload *payload,
+		     struct trusted_key_options *options);
+int tpm_unseal_trusted(struct tpm_chip *chip,
+		       struct trusted_key_payload *payload,
+		       struct trusted_key_options *options);
 
 #define TPM_DEBUG 0
 
@@ -84,7 +91,7 @@ static inline void dump_sess(struct osapsess *s)
 		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
 }
 
-static inline void dump_tpm_buf(unsigned char *buf)
+static inline void dump_tpm1_buf(unsigned char *buf)
 {
 	int len;
 
@@ -105,29 +112,29 @@ static inline void dump_sess(struct osapsess *s)
 {
 }
 
-static inline void dump_tpm_buf(unsigned char *buf)
+static inline void dump_tpm1_buf(unsigned char *buf)
 {
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
index 53c0ea9..5c43b41 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -21,6 +21,7 @@
 #include <linux/acpi.h>
 #include <linux/cdev.h>
 #include <linux/fs.h>
+#include <linux/highmem.h>
 #include <crypto/hash_info.h>
 
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
@@ -161,6 +162,231 @@ struct tpm_chip {
 	int locality;
 };
 
+#define TPM_HEADER_SIZE		10
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
+enum tpm_chip_flags {
+	TPM_CHIP_FLAG_TPM2		= BIT(1),
+	TPM_CHIP_FLAG_IRQ		= BIT(2),
+	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
+	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
+	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
+};
+
+enum tpm2_object_attributes {
+	TPM2_OA_USER_WITH_AUTH		= BIT(6),
+};
+
+enum tpm2_session_attributes {
+	TPM2_SA_CONTINUE_SESSION	= BIT(0),
+};
+
+struct tpm2_hash {
+	unsigned int crypto_id;
+	unsigned int tpm_id;
+};
+
+/* A string buffer type for constructing TPM commands. This is based on the
+ * ideas of string buffer code in security/keys/trusted_tpm.h but is heap based
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
+static inline u32 tpm2_rc_value(u32 rc)
+{
+	return (rc & BIT(7)) ? rc & 0xff : rc;
+}
+
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
 extern int tpm_is_tpm2(struct tpm_chip *chip);
@@ -170,13 +396,12 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
-extern int tpm_seal_trusted(struct tpm_chip *chip,
-			    struct trusted_key_payload *payload,
-			    struct trusted_key_options *options);
-extern int tpm_unseal_trusted(struct tpm_chip *chip,
-			      struct trusted_key_payload *payload,
-			      struct trusted_key_options *options);
 extern struct tpm_chip *tpm_default_chip(void);
+extern struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
+extern void tpm_put_ops(struct tpm_chip *chip);
+extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
+				size_t min_rsp_body_length, const char *desc);
+extern void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
@@ -204,21 +429,30 @@ static inline int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max)
 	return -ENODEV;
 }
 
-static inline int tpm_seal_trusted(struct tpm_chip *chip,
-				   struct trusted_key_payload *payload,
-				   struct trusted_key_options *options)
+static inline struct tpm_chip *tpm_default_chip(void)
 {
-	return -ENODEV;
+	return NULL;
 }
-static inline int tpm_unseal_trusted(struct tpm_chip *chip,
-				     struct trusted_key_payload *payload,
-				     struct trusted_key_options *options)
+
+static inline struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
+{
+	return NULL;
+}
+
+static inline void tpm_put_ops(struct tpm_chip *chip)
+{
+}
+
+static inline ssize_t tpm_transmit_cmd(struct tpm_chip *chip,
+				       struct tpm_buf *buf,
+				       size_t min_rsp_body_length,
+				       const char *desc)
 {
 	return -ENODEV;
 }
-static inline struct tpm_chip *tpm_default_chip(void)
+
+static inline void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 {
-	return NULL;
 }
 #endif
 #endif
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index ad34d17..590a694 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -3,4 +3,5 @@
 # Makefile for trusted keys
 #
 
-obj-$(CONFIG_TRUSTED_KEYS) += trusted-tpm.o
+obj-$(CONFIG_TRUSTED_KEYS) += trusted-tpm.o \
+			trusted-tpm2.o
diff --git a/security/keys/trusted-keys/trusted-tpm.c b/security/keys/trusted-keys/trusted-tpm.c
index b7e53a3..d09893b 100644
--- a/security/keys/trusted-keys/trusted-tpm.c
+++ b/security/keys/trusted-keys/trusted-tpm.c
@@ -368,9 +368,9 @@ int trusted_tpm_send(unsigned char *cmd, size_t buflen)
 	if (!chip)
 		return -ENODEV;
 
-	dump_tpm_buf(cmd);
+	dump_tpm1_buf(cmd);
 	rc = tpm_send(chip, cmd, buflen);
-	dump_tpm_buf(cmd);
+	dump_tpm1_buf(cmd);
 	if (rc > 0)
 		/* Can't return positive return codes values to keyctl */
 		rc = -EPERM;
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
diff --git a/security/keys/trusted-keys/trusted-tpm2.c b/security/keys/trusted-keys/trusted-tpm2.c
new file mode 100644
index 0000000..98892ed7
--- /dev/null
+++ b/security/keys/trusted-keys/trusted-tpm2.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2004 IBM Corporation
+ * Copyright (C) 2014 Intel Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Dave Safford <safford@watson.ibm.com>
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Maintained by: <tpmdd-devel@lists.sourceforge.net>
+ *
+ * Trusted Keys code for TCG/TCPA TPM2 (trusted platform module).
+ */
+
+#include <linux/string.h>
+#include <linux/err.h>
+#include <linux/tpm.h>
+#include <linux/tpm_command.h>
+
+#include <keys/trusted-type.h>
+#include <keys/trusted_tpm.h>
+
+static struct tpm2_hash tpm2_hash_map[] = {
+	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
+	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
+	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
+	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
+	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
+};
+
+/**
+ * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
+ *
+ * @buf: an allocated tpm_buf instance
+ * @session_handle: session handle
+ * @nonce: the session nonce, may be NULL if not used
+ * @nonce_len: the session nonce length, may be 0 if not used
+ * @attributes: the session attributes
+ * @hmac: the session HMAC or password, may be NULL if not used
+ * @hmac_len: the session HMAC or password length, maybe 0 if not used
+ */
+static void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
+				 const u8 *nonce, u16 nonce_len,
+				 u8 attributes,
+				 const u8 *hmac, u16 hmac_len)
+{
+	tpm_buf_append_u32(buf, 9 + nonce_len + hmac_len);
+	tpm_buf_append_u32(buf, session_handle);
+	tpm_buf_append_u16(buf, nonce_len);
+
+	if (nonce && nonce_len)
+		tpm_buf_append(buf, nonce, nonce_len);
+
+	tpm_buf_append_u8(buf, attributes);
+	tpm_buf_append_u16(buf, hmac_len);
+
+	if (hmac && hmac_len)
+		tpm_buf_append(buf, hmac, hmac_len);
+}
+
+/**
+ * tpm2_seal_trusted() - seal the payload of a trusted key
+ *
+ * @chip: TPM chip to use
+ * @payload: the key data in clear and encrypted form
+ * @options: authentication values and other options
+ *
+ * Return: < 0 on error and 0 on success.
+ */
+int tpm2_seal_trusted(struct tpm_chip *chip,
+		      struct trusted_key_payload *payload,
+		      struct trusted_key_options *options)
+{
+	unsigned int blob_len;
+	struct tpm_buf buf;
+	u32 hash;
+	int i;
+	int rc;
+
+	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
+		if (options->hash == tpm2_hash_map[i].crypto_id) {
+			hash = tpm2_hash_map[i].tpm_id;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(tpm2_hash_map))
+		return -EINVAL;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, options->keyhandle);
+	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
+			     NULL /* nonce */, 0,
+			     0 /* session_attributes */,
+			     options->keyauth /* hmac */,
+			     TPM_DIGEST_SIZE);
+
+	/* sensitive */
+	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len + 1);
+
+	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
+	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
+	tpm_buf_append_u16(&buf, payload->key_len + 1);
+	tpm_buf_append(&buf, payload->key, payload->key_len);
+	tpm_buf_append_u8(&buf, payload->migratable);
+
+	/* public */
+	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
+	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
+	tpm_buf_append_u16(&buf, hash);
+
+	/* policy */
+	if (options->policydigest_len) {
+		tpm_buf_append_u32(&buf, 0);
+		tpm_buf_append_u16(&buf, options->policydigest_len);
+		tpm_buf_append(&buf, options->policydigest,
+			       options->policydigest_len);
+	} else {
+		tpm_buf_append_u32(&buf, TPM2_OA_USER_WITH_AUTH);
+		tpm_buf_append_u16(&buf, 0);
+	}
+
+	/* public parameters */
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
+	tpm_buf_append_u16(&buf, 0);
+
+	/* outside info */
+	tpm_buf_append_u16(&buf, 0);
+
+	/* creation PCR */
+	tpm_buf_append_u32(&buf, 0);
+
+	if (buf.flags & TPM_BUF_OVERFLOW) {
+		rc = -E2BIG;
+		goto out;
+	}
+
+	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
+	if (rc)
+		goto out;
+
+	blob_len = be32_to_cpup((__be32 *) &buf.data[TPM_HEADER_SIZE]);
+	if (blob_len > MAX_BLOB_SIZE) {
+		rc = -E2BIG;
+		goto out;
+	}
+	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	memcpy(payload->blob, &buf.data[TPM_HEADER_SIZE + 4], blob_len);
+	payload->blob_len = blob_len;
+
+out:
+	tpm_buf_destroy(&buf);
+
+	if (rc > 0) {
+		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
+			rc = -EINVAL;
+		else
+			rc = -EPERM;
+	}
+
+	return rc;
+}
+
+/**
+ * tpm_seal_trusted() - seal a trusted key payload
+ * @chip:	a &struct tpm_chip instance, %NULL for the default chip
+ * @options:	authentication values and other options
+ * @payload:	the key data in clear and encrypted form
+ *
+ * Note: only TPM 2.0 chip are supported. TPM 1.x implementation is located in
+ * the keyring subsystem.
+ *
+ * Return: same as with tpm_transmit_cmd()
+ */
+int tpm_seal_trusted(struct tpm_chip *chip, struct trusted_key_payload *payload,
+		     struct trusted_key_options *options)
+{
+	int rc;
+
+	chip = tpm_find_get_ops(chip);
+	if (!chip || !(chip->flags & TPM_CHIP_FLAG_TPM2))
+		return -ENODEV;
+
+	rc = tpm2_seal_trusted(chip, payload, options);
+
+	tpm_put_ops(chip);
+	return rc;
+}
+
+/**
+ * tpm2_load_cmd() - execute a TPM2_Load command
+ *
+ * @chip: TPM chip to use
+ * @payload: the key data in clear and encrypted form
+ * @options: authentication values and other options
+ * @blob_handle: returned blob handle
+ *
+ * Return: 0 on success.
+ *        -E2BIG on wrong payload size.
+ *        -EPERM on tpm error status.
+ *        < 0 error from tpm_transmit_cmd.
+ */
+static int tpm2_load_cmd(struct tpm_chip *chip,
+			 struct trusted_key_payload *payload,
+			 struct trusted_key_options *options,
+			 u32 *blob_handle)
+{
+	struct tpm_buf buf;
+	unsigned int private_len;
+	unsigned int public_len;
+	unsigned int blob_len;
+	int rc;
+
+	private_len = be16_to_cpup((__be16 *) &payload->blob[0]);
+	if (private_len > (payload->blob_len - 2))
+		return -E2BIG;
+
+	public_len = be16_to_cpup((__be16 *) &payload->blob[2 + private_len]);
+	blob_len = private_len + public_len + 4;
+	if (blob_len > payload->blob_len)
+		return -E2BIG;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, options->keyhandle);
+	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
+			     NULL /* nonce */, 0,
+			     0 /* session_attributes */,
+			     options->keyauth /* hmac */,
+			     TPM_DIGEST_SIZE);
+
+	tpm_buf_append(&buf, payload->blob, blob_len);
+
+	if (buf.flags & TPM_BUF_OVERFLOW) {
+		rc = -E2BIG;
+		goto out;
+	}
+
+	rc = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
+	if (!rc)
+		*blob_handle = be32_to_cpup(
+			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
+
+out:
+	tpm_buf_destroy(&buf);
+
+	if (rc > 0)
+		rc = -EPERM;
+
+	return rc;
+}
+
+/**
+ * tpm2_unseal_cmd() - execute a TPM2_Unload command
+ *
+ * @chip: TPM chip to use
+ * @payload: the key data in clear and encrypted form
+ * @options: authentication values and other options
+ * @blob_handle: blob handle
+ *
+ * Return: 0 on success
+ *         -EPERM on tpm error status
+ *         < 0 error from tpm_transmit_cmd
+ */
+static int tpm2_unseal_cmd(struct tpm_chip *chip,
+			   struct trusted_key_payload *payload,
+			   struct trusted_key_options *options,
+			   u32 blob_handle)
+{
+	struct tpm_buf buf;
+	u16 data_len;
+	u8 *data;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, blob_handle);
+	tpm2_buf_append_auth(&buf,
+			     options->policyhandle ?
+			     options->policyhandle : TPM2_RS_PW,
+			     NULL /* nonce */, 0,
+			     TPM2_SA_CONTINUE_SESSION,
+			     options->blobauth /* hmac */,
+			     TPM_DIGEST_SIZE);
+
+	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
+	if (rc > 0)
+		rc = -EPERM;
+
+	if (!rc) {
+		data_len = be16_to_cpup(
+			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
+		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
+			rc = -EFAULT;
+			goto out;
+		}
+
+		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 6 + data_len) {
+			rc = -EFAULT;
+			goto out;
+		}
+		data = &buf.data[TPM_HEADER_SIZE + 6];
+
+		memcpy(payload->key, data, data_len - 1);
+		payload->key_len = data_len - 1;
+		payload->migratable = data[data_len - 1];
+	}
+
+out:
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
+/**
+ * tpm2_unseal_trusted() - unseal the payload of a trusted key
+ *
+ * @chip: TPM chip to use
+ * @payload: the key data in clear and encrypted form
+ * @options: authentication values and other options
+ *
+ * Return: Same as with tpm_transmit_cmd.
+ */
+int tpm2_unseal_trusted(struct tpm_chip *chip,
+			struct trusted_key_payload *payload,
+			struct trusted_key_options *options)
+{
+	u32 blob_handle;
+	int rc;
+
+	rc = tpm2_load_cmd(chip, payload, options, &blob_handle);
+	if (rc)
+		return rc;
+
+	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
+	tpm2_flush_context(chip, blob_handle);
+	return rc;
+}
+
+/**
+ * tpm_unseal_trusted() - unseal a trusted key
+ * @chip:	a &struct tpm_chip instance, %NULL for the default chip
+ * @options:	authentication values and other options
+ * @payload:	the key data in clear and encrypted form
+ *
+ * Note: only TPM 2.0 chip are supported. TPM 1.x implementation is located in
+ * the keyring subsystem.
+ *
+ * Return: same as with tpm_transmit_cmd()
+ */
+int tpm_unseal_trusted(struct tpm_chip *chip,
+		       struct trusted_key_payload *payload,
+		       struct trusted_key_options *options)
+{
+	int rc;
+
+	chip = tpm_find_get_ops(chip);
+	if (!chip || !(chip->flags & TPM_CHIP_FLAG_TPM2))
+		return -ENODEV;
+
+	rc = tpm2_unseal_trusted(chip, payload, options);
+
+	tpm_put_ops(chip);
+
+	return rc;
+}
-- 
2.7.4

