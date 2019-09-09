Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A376AAD8D7
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 14:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbfIIMVB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 08:21:01 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48220 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfIIMVB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 08:21:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E3C548EE180;
        Mon,  9 Sep 2019 05:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031660;
        bh=r41ZFEeb3wTFWT+nMDmscNBFNCnnf1fZbKOUj4EQuo8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pDG0clCQ1uQUkktiIU1ENqM1iivrFXut/1JiRoVYbJ9lq9Oh7xKzA6mSvs69/RX+8
         rJxiU8qZjYJhrwgyez9yi3/cDIsaqIkkGgaubddiK2MGsONXutsfmlx46GaGpexjvZ
         0BfcHwinWzhGb4TXUY3OjkWk5yVlYFXKRB2yrmOI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DgzFD6R5R4NO; Mon,  9 Sep 2019 05:21:00 -0700 (PDT)
Received: from [192.168.6.117] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 72ABC8EE105;
        Mon,  9 Sep 2019 05:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031660;
        bh=r41ZFEeb3wTFWT+nMDmscNBFNCnnf1fZbKOUj4EQuo8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pDG0clCQ1uQUkktiIU1ENqM1iivrFXut/1JiRoVYbJ9lq9Oh7xKzA6mSvs69/RX+8
         rJxiU8qZjYJhrwgyez9yi3/cDIsaqIkkGgaubddiK2MGsONXutsfmlx46GaGpexjvZ
         0BfcHwinWzhGb4TXUY3OjkWk5yVlYFXKRB2yrmOI=
Message-ID: <1568031657.6613.34.camel@HansenPartnership.com>
Subject: [PATCH v6 05/12] tpm2-sessions: Add full HMAC and encrypt/decrypt
 session handling
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Sep 2019 13:20:57 +0100
In-Reply-To: <1568031408.6613.29.camel@HansenPartnership.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This code adds true session based HMAC authentication plus parameter
decryption and response encryption using AES.

The basic design of this code is to segregate all the nasty crypto,
hash and hmac code into tpm2-sessions.c and export a usable API.

The API first of all starts off by gaining a session with

tpm2_start_auth_session()

Which initiates a session with the TPM and allocates an opaque
tpm2_auth structure to handle the session parameters.  Then the use is
simply:

* tpm_buf_append_name() in place of the tpm_buf_append_u32 for the
  handles

* tpm_buf_append_hmac_session() where tpm2_append_auth() would go

* tpm_buf_fill_hmac_session() called after the entire command buffer
  is finished but before tpm_transmit_cmd() is called which computes
  the correct HMAC and places it in the command at the correct
  location.

Finally, after tpm_transmit_cmd() is called,
tpm_buf_check_hmac_response() is called to check that the returned
HMAC matched and collect the new state for the next use of the
session, if any.

The features of the session is controlled by the session attributes
set in tpm_buf_append_hmac_session().  If TPM2_SA_CONTINUE_SESSION is
not specified, the session will be flushed and the tpm2_auth structure
freed in tpm_buf_check_hmac_response(); otherwise the session may be
used again.  Parameter encryption is specified by or'ing the flag
TPM2_SA_DECRYPT and response encryption by or'ing the flag
TPM2_SA_ENCRYPT.  the various encryptions will be taken care of by
tpm_buf_fill_hmac_session() and tpm_buf_check_hmac_response()
respectively.

To get all of this to work securely, the Kernel now needs a primary
key to encrypt the session salt to, so we derive an EC key from the
NULL seed and save its context in the tpm_chip structure.  The context
is loaded on demand into an available volatile handle when
tpm_start_auth_session() is called, but is flushed before that
function exits to conserve handles.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # crypto API parts

---

v2: Added docbook and improved response check API
v3: Add readpublic, fix hmac length, add API for close on error
    allow for the hmac session not being first in the sessions
v4: Make NULL seed template exactly match the SRK ECC template.
    Also check the NULL primary key name is what getpublic returns
    to prevent spoofing.  Also parametrise the name size for reuse
v5: Move to sync_skcipher API
v6: eliminate kernel space and use context save for null seed and
    make feature conditional on CONFIG_TPM_BUS_SECURITY
---
 drivers/char/tpm/Kconfig         |   11 +
 drivers/char/tpm/Makefile        |    1 +
 drivers/char/tpm/tpm-buf.c       |    1 +
 drivers/char/tpm/tpm.h           |   20 +-
 drivers/char/tpm/tpm2-cmd.c      |   22 +-
 drivers/char/tpm/tpm2-sessions.c | 1203 ++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-sessions.h |  137 +++++
 include/linux/tpm.h              |   29 +
 8 files changed, 1411 insertions(+), 13 deletions(-)
 create mode 100644 drivers/char/tpm/tpm2-sessions.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.h

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 88a3c06fc153..96b09adfc163 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -9,6 +9,9 @@ menuconfig TCG_TPM
 	imply SECURITYFS
 	select CRYPTO
 	select CRYPTO_HASH_INFO
+	select CRYPTO_ECDH
+	select CRYPTO_AES
+	select CRYPTO_CFB
 	---help---
 	  If you have a TPM security chip in your system, which
 	  implements the Trusted Computing Group's specification,
@@ -27,6 +30,14 @@ menuconfig TCG_TPM
 
 if TCG_TPM
 
+config TPM_BUS_SECURITY
+       bool "Use secure transactions on the TPM bus"
+       default y
+       ---help---
+         Setting this causes us to deploy a tamper resistent scheme
+	 for communicating with the TPM to prevent or detect bus snooping
+	 attacks like TPM Genie.  Saying Y here adds some encryption overhead
+	 to all kernel to TPM transactions.
 config HW_RANDOM_TPM
 	bool "TPM HW Random Number Generator support"
 	depends on TCG_TPM && HW_RANDOM && !(TCG_TPM=y && HW_RANDOM=m)
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 78bd025b808a..8f9e58317048 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -17,6 +17,7 @@ tpm-y += eventlog/tpm1.o
 tpm-y += eventlog/tpm2.o
 tpm-y += tpm-buf.o
 
+tpm-$(CONFIG_TPM_BUS_SECURITY) += tpm2-sessions.o
 tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
 tpm-$(CONFIG_EFI) += eventlog/efi.o
 tpm-$(CONFIG_OF) += eventlog/of.o
diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 553adb84b0ac..f56350123a08 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -31,6 +31,7 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 	head->tag = cpu_to_be16(tag);
 	head->length = cpu_to_be32(sizeof(*head));
 	head->ordinal = cpu_to_be32(ordinal);
+	buf->handles = 0;
 }
 EXPORT_SYMBOL_GPL(tpm_buf_reset);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 85a7302ddfeb..ebead8e4c3fe 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -80,6 +80,7 @@ enum tpm2_timeouts {
 enum tpm2_structures {
 	TPM2_ST_NO_SESSIONS	= 0x8001,
 	TPM2_ST_SESSIONS	= 0x8002,
+	TPM2_ST_CREATION	= 0x8021,
 };
 
 /* Indicates from what layer of the software stack the error comes from */
@@ -116,6 +117,8 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_READ_PUBLIC		= 0x0173,
+	TPM2_CC_START_AUTH_SESS		= 0x0176,
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
 	TPM2_CC_GET_CAPABILITY	        = 0x017A,
 	TPM2_CC_GET_RANDOM	        = 0x017B,
@@ -128,6 +131,7 @@ enum tpm2_command_codes {
 };
 
 enum tpm2_permanent_handles {
+	TPM2_RH_NULL		= 0x40000007,
 	TPM2_RS_PW		= 0x40000009,
 };
 
@@ -286,7 +290,8 @@ enum tpm_buf_flags {
 
 struct tpm_buf {
 	struct page *data_page;
-	unsigned int flags;
+	u8 flags;
+	u8 handles;
 	u8 *data;
 };
 
@@ -306,6 +311,9 @@ u8 tpm_get_inc_u8(const u8 **ptr);
 u16 tpm_get_inc_u16(const u8 **ptr);
 u32 tpm_get_inc_u32(const u8 **ptr);
 
+/* opaque structure, holds auth session parameters like the session key */
+struct tpm2_auth;
+
 extern struct class *tpm_class;
 extern struct class *tpmrm_class;
 extern dev_t tpm_devt;
@@ -408,4 +416,14 @@ int tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
 int tpm_dev_common_init(void);
 void tpm_dev_common_exit(void);
+
+#ifdef CONFIG_TPM_BUS_SECURITY
+int tpm2_sessions_init(struct tpm_chip *chip);
+#else
+static inline int tpm2_sessions_init(struct tpm_chip *chip)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ba9acae83bff..d120b0a260eb 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -12,17 +12,10 @@
  */
 
 #include "tpm.h"
+#include "tpm2-sessions.h"
 #include <crypto/hash_info.h>
 #include <keys/trusted-type.h>
 
-enum tpm2_object_attributes {
-	TPM2_OA_USER_WITH_AUTH		= BIT(6),
-};
-
-enum tpm2_session_attributes {
-	TPM2_SA_CONTINUE_SESSION	= BIT(0),
-};
-
 struct tpm2_hash {
 	unsigned int crypto_id;
 	unsigned int tpm_id;
@@ -388,10 +381,10 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
  * @hmac: the session HMAC or password, may be NULL if not used
  * @hmac_len: the session HMAC or password length, maybe 0 if not used
  */
-static void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
-				 const u8 *nonce, u16 nonce_len,
-				 u8 attributes,
-				 const u8 *hmac, u16 hmac_len)
+void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
+			  const u8 *nonce, u16 nonce_len,
+			  u8 attributes,
+			  const u8 *hmac, u16 hmac_len)
 {
 	tpm_buf_append_u32(buf, 9 + nonce_len + hmac_len);
 	tpm_buf_append_u32(buf, session_handle);
@@ -1042,6 +1035,11 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 
 	rc = tpm2_get_cc_attrs_tbl(chip);
 
+	if (rc)
+		goto out;
+
+	rc = tpm2_sessions_init(chip);
+
 out:
 	if (rc > 0)
 		rc = -ENODEV;
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
new file mode 100644
index 000000000000..7307f061e5df
--- /dev/null
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -0,0 +1,1203 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2018 James.Bottomley@HansenPartnership.com
+ *
+ * Cryptographic helper routines for handling TPM2 sessions for
+ * authorization HMAC and request response encryption.
+ *
+ * The idea is to ensure that every TPM command is HMAC protected by a
+ * session, meaning in-flight tampering would be detected and in
+ * addition all sensitive inputs and responses should be encrypted.
+ *
+ * The basic way this works is to use a TPM feature called salted
+ * sessions where a random secret used in session construction is
+ * encrypted to the public part of a known TPM key.  The problem is we
+ * have no known keys, so initially a primary Elliptic Curve key is
+ * derived from the NULL seed (we use EC because most TPMs generate
+ * these keys much faster than RSA ones).  The curve used is NIST_P256
+ * because that's now mandated to be present in 'TCG TPM v2.0
+ * Provisioning Guidance'
+ *
+ * Threat problems: the initial TPM2_CreatePrimary is not (and cannot
+ * be) session protected, so a clever Man in the Middle could return a
+ * public key they control to this command and from there intercept
+ * and decode all subsequent session based transactions.  The kernel
+ * cannot mitigate this threat but, after boot, userspace can get
+ * proof this has not happened by asking the TPM to certify the NULL
+ * key.  This certification would chain back to the TPM Endorsement
+ * Certificate and prove the NULL seed primary had not been tampered
+ * with and thus all sessions must have been cryptographically secure.
+ * To assist with this, the initial NULL seed public key name is made
+ * available in a sysfs file.
+ *
+ * Use of these functions:
+ *
+ * The design is all the crypto, hash and hmac gunk is confined in this
+ * file and never needs to be seen even by the kernel internal user.  To
+ * the user there's an init function tpm2_sessions_init() that needs to
+ * be called once per TPM which generates the NULL seed primary key.
+ *
+ * Then there are six usage functions:
+ *
+ * tpm2_start_auth_session() which allocates the opaque auth structure
+ *	and gets a session from the TPM.  This must be called before
+ *	any of the following functions.  The session is protected by a
+ *	session_key which is derived from a random salt value
+ *	encrypted to the NULL seed.
+ * tpm2_end_auth_session() kills the session and frees the resources.
+ *	Under normal operation this function is done by
+ *	tpm_buf_check_hmac_response(), so this is only to be used on
+ *	error legs where the latter is not executed.
+ * tpm_buf_append_name() to add a handle to the buffer.  This must be
+ *	used in place of the usual tpm_buf_append_u32() for adding
+ *	handles because handles have to be processed specially when
+ *	calculating the HMAC.  In particular, for NV, volatile and
+ *	permanent objects you now need to provide the name.
+ * tpm_buf_append_hmac_session() which appends the hmac session to the
+ *	buf in the same way tpm_buf_append_auth does().
+ * tpm_buf_fill_hmac_session() This calculates the correct hash and
+ *	places it in the buffer.  It must be called after the complete
+ *	command buffer is finalized so it can fill in the correct HMAC
+ *	based on the parameters.
+ * tpm_buf_check_hmac_response() which checks the session response in
+ *	the buffer and calculates what it should be.  If there's a
+ *	mismatch it will log a warning and return an error.  If
+ *	tpm_buf_append_hmac_session() did not specify
+ *	TPM_SA_CONTINUE_SESSION then the session will be closed (if it
+ *	hasn't been consumed) and the auth structure freed.
+ */
+
+#include "tpm.h"
+#include "tpm2-sessions.h"
+
+#include <linux/random.h>
+#include <linux/scatterlist.h>
+
+#include <asm/unaligned.h>
+
+#include <crypto/aes.h>
+#include <crypto/kpp.h>
+#include <crypto/ecdh.h>
+#include <crypto/hash.h>
+#include <crypto/hmac.h>
+#include <crypto/skcipher.h>
+
+/* if you change to AES256, you only need change this */
+#define AES_KEYBYTES	AES_KEYSIZE_128
+
+#define AES_KEYBITS	(AES_KEYBYTES*8)
+#define AUTH_MAX_NAMES	3
+
+/*
+ * This is the structure that carries all the auth information (like
+ * session handle, nonces, session key and auth) from use to use it is
+ * designed to be opaque to anything outside.
+ */
+struct tpm2_auth {
+	u32 handle;
+	/*
+	 * This has two meanings: before tpm_buf_fill_hmac_session()
+	 * it marks the offset in the buffer of the start of the
+	 * sessions (i.e. after all the handles).  Once the buffer has
+	 * been filled it markes the session number of our auth
+	 * session so we can find it again in the response buffer.
+	 *
+	 * The two cases are distinguished because the first offset
+	 * must always be greater than TPM_HEADER_SIZE and the second
+	 * must be less than or equal to 5.
+	 */
+	u32 session;
+	/*
+	 * the size here is variable and set by the size of our_nonce
+	 * which must be between 16 and the name hash length. we set
+	 * the maximum sha256 size for the greatest protection
+	 */
+	u8 our_nonce[SHA256_DIGEST_SIZE];
+	u8 tpm_nonce[SHA256_DIGEST_SIZE];
+	/*
+	 * the salt is only used across the session command/response
+	 * after that it can be used as a scratch area
+	 */
+	union {
+		u8 salt[EC_PT_SZ];
+		/* scratch for key + IV */
+		u8 scratch[AES_KEYBYTES + AES_BLOCK_SIZE];
+	};
+	/*
+	 * the session key and passphrase are the same size as the
+	 * name digest (sha256 again).  The session key is constant
+	 * for the use of the session and the passphrase can change
+	 * with every invocation.
+	 *
+	 * Note: these fields must be adjacent and in this order
+	 * because several HMAC/KDF schemes use the combination of the
+	 * session_key and passphrase.
+	 */
+	u8 session_key[SHA256_DIGEST_SIZE];
+	u8 passphrase[SHA256_DIGEST_SIZE];
+	int passphraselen;
+	/* saved session attributes */
+	u8 attrs;
+	__be32 ordinal;
+	struct crypto_sync_skcipher *aes;
+	struct tpm_chip *chip;
+	/* 3 names of handles: name_h is handle, name is name of handle */
+	u32 name_h[AUTH_MAX_NAMES];
+	u8 name[AUTH_MAX_NAMES][2 + SHA256_DIGEST_SIZE];
+};
+
+/*
+ * this is our static crypto shash.  This is possible because the hash
+ * is multi-threaded and all the state stored in the desc
+ */
+static struct crypto_shash *sha256_hash;
+
+/*
+ * It turns out the crypto hmac(sha256) is hard for us to consume
+ * because it assumes a fixed key and the TPM seems to change the key
+ * on every operation, so we weld the hmac init and final functions in
+ * here to give it the same usage characteristics as a regular hash
+ */
+static void hmac_init(struct shash_desc *desc, u8 *key, int keylen)
+{
+	u8 pad[SHA256_BLOCK_SIZE];
+	int i;
+
+	desc->tfm = sha256_hash;
+	crypto_shash_init(desc);
+	for (i = 0; i < sizeof(pad); i++) {
+		if (i < keylen)
+			pad[i] = key[i];
+		else
+			pad[i] = 0;
+		pad[i] ^= HMAC_IPAD_VALUE;
+	}
+	crypto_shash_update(desc, pad, sizeof(pad));
+}
+
+static void hmac_final(struct shash_desc *desc, u8 *key, int keylen, u8 *out)
+{
+	u8 pad[SHA256_BLOCK_SIZE];
+	int i;
+
+	for (i = 0; i < sizeof(pad); i++) {
+		if (i < keylen)
+			pad[i] = key[i];
+		else
+			pad[i] = 0;
+		pad[i] ^= HMAC_OPAD_VALUE;
+	}
+
+	/* collect the final hash;  use out as temporary storage */
+	crypto_shash_final(desc, out);
+
+	/* reuse the desc */
+	crypto_shash_init(desc);
+	crypto_shash_update(desc, pad, sizeof(pad));
+	crypto_shash_update(desc, out, SHA256_DIGEST_SIZE);
+	crypto_shash_final(desc, out);
+}
+
+/*
+ * assume hash sha256 and nonces u, v of size SHA256_DIGEST_SIZE but
+ * otherwise standard KDFa.  Note output is in bytes not bits.
+ */
+static void KDFa(u8 *key, int keylen, const char *label, u8 *u,
+		 u8 *v, int bytes, u8 *out)
+{
+	u32 counter;
+	const __be32 bits = cpu_to_be32(bytes * 8);
+
+	for (counter = 1; bytes > 0; bytes -= SHA256_DIGEST_SIZE, counter++,
+		     out += SHA256_DIGEST_SIZE) {
+		SHASH_DESC_ON_STACK(desc, sha256_hash);
+		__be32 c = cpu_to_be32(counter);
+
+		hmac_init(desc, key, keylen);
+		crypto_shash_update(desc, (u8 *)&c, sizeof(c));
+		crypto_shash_update(desc, label, strlen(label)+1);
+		crypto_shash_update(desc, u, SHA256_DIGEST_SIZE);
+		crypto_shash_update(desc, v, SHA256_DIGEST_SIZE);
+		crypto_shash_update(desc, (u8 *)&bits, sizeof(bits));
+		hmac_final(desc, key, keylen, out);
+	}
+}
+
+/*
+ * Somewhat of a bastardization of the real KDFe.  We're assuming
+ * we're working with known point sizes for the input parameters and
+ * the hash algorithm is fixed at sha256.  Because we know that the
+ * point size is 32 bytes like the hash size, there's no need to loop
+ * in this KDF.
+ */
+static void KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
+		 u8 *keyout)
+{
+	SHASH_DESC_ON_STACK(desc, sha256_hash);
+	/*
+	 * this should be an iterative counter, but because we know
+	 *  we're only taking 32 bytes for the point using a sha256
+	 *  hash which is also 32 bytes, there's only one loop
+	 */
+	__be32 c = cpu_to_be32(1);
+
+	desc->tfm = sha256_hash;
+
+	crypto_shash_init(desc);
+	/* counter (BE) */
+	crypto_shash_update(desc, (u8 *)&c, sizeof(c));
+	/* secret value */
+	crypto_shash_update(desc, z, EC_PT_SZ);
+	/* string including trailing zero */
+	crypto_shash_update(desc, str, strlen(str)+1);
+	crypto_shash_update(desc, pt_u, EC_PT_SZ);
+	crypto_shash_update(desc, pt_v, EC_PT_SZ);
+	crypto_shash_final(desc, keyout);
+}
+
+static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
+				struct tpm2_auth *auth)
+{
+	struct crypto_kpp *kpp;
+	struct kpp_request *req;
+	struct scatterlist s[2], d[1];
+	struct ecdh p = {0};
+	u8 encoded_key[EC_PT_SZ], *x, *y;
+	unsigned int buf_len;
+	u8 *secret;
+
+	secret = kmalloc(EC_PT_SZ, GFP_KERNEL);
+	if (!secret)
+		return;
+
+	p.curve_id = ECC_CURVE_NIST_P256;
+
+	/* secret is two sized points */
+	tpm_buf_append_u16(buf, (EC_PT_SZ + 2)*2);
+	/*
+	 * we cheat here and append uninitialized data to form
+	 * the points.  All we care about is getting the two
+	 * co-ordinate pointers, which will be used to overwrite
+	 * the uninitialized data
+	 */
+	tpm_buf_append_u16(buf, EC_PT_SZ);
+	x = &buf->data[tpm_buf_length(buf)];
+	tpm_buf_append(buf, encoded_key, EC_PT_SZ);
+	tpm_buf_append_u16(buf, EC_PT_SZ);
+	y = &buf->data[tpm_buf_length(buf)];
+	tpm_buf_append(buf, encoded_key, EC_PT_SZ);
+	sg_init_table(s, 2);
+	sg_set_buf(&s[0], x, EC_PT_SZ);
+	sg_set_buf(&s[1], y, EC_PT_SZ);
+
+	kpp = crypto_alloc_kpp("ecdh", CRYPTO_ALG_INTERNAL, 0);
+	if (IS_ERR(kpp)) {
+		dev_err(&chip->dev, "crypto ecdh allocation failed\n");
+		return;
+	}
+
+	buf_len = crypto_ecdh_key_len(&p);
+	if (sizeof(encoded_key) < buf_len) {
+		dev_err(&chip->dev, "salt buffer too small needs %d\n",
+			buf_len);
+		goto out;
+	}
+	crypto_ecdh_encode_key(encoded_key, buf_len, &p);
+	/* this generates a random private key */
+	crypto_kpp_set_secret(kpp, encoded_key, buf_len);
+
+	/* salt is now the public point of this private key */
+	req = kpp_request_alloc(kpp, GFP_KERNEL);
+	if (!req)
+		goto out;
+	kpp_request_set_input(req, NULL, 0);
+	kpp_request_set_output(req, s, EC_PT_SZ*2);
+	crypto_kpp_generate_public_key(req);
+	/*
+	 * we're not done: now we have to compute the shared secret
+	 * which is our private key multiplied by the tpm_key public
+	 * point, we actually only take the x point and discard the y
+	 * point and feed it through KDFe to get the final secret salt
+	 */
+	sg_set_buf(&s[0], chip->ec_point_x, EC_PT_SZ);
+	sg_set_buf(&s[1], chip->ec_point_y, EC_PT_SZ);
+	kpp_request_set_input(req, s, EC_PT_SZ*2);
+	sg_init_one(d, secret, EC_PT_SZ);
+	kpp_request_set_output(req, d, EC_PT_SZ);
+	crypto_kpp_compute_shared_secret(req);
+	kpp_request_free(req);
+
+	/* pass the shared secret through KDFe for salt */
+	KDFe(secret, "SECRET", x, chip->ec_point_x, auth->salt);
+ out:
+	crypto_free_kpp(kpp);
+}
+
+/**
+ * tpm_buf_append_hmac_session() append a TPM session element
+ * @buf: The buffer to be appended
+ * @auth: the auth structure allocated by tpm2_start_auth_session()
+ * @attributes: The session attributes
+ * @passphrase: The session authority (NULL if none)
+ * @passphraselen: The length of the session authority (0 if none)
+ *
+ * This fills in a session structure in the TPM command buffer, except
+ * for the HMAC which cannot be computed until the command buffer is
+ * complete.  The type of session is controlled by the @attributes,
+ * the main ones of which are TPM2_SA_CONTINUE_SESSION which means the
+ * session won't terminate after tpm_buf_check_hmac_response(),
+ * TPM2_SA_DECRYPT which means this buffers first parameter should be
+ * encrypted with a session key and TPM2_SA_ENCRYPT, which means the
+ * response buffer's first parameter needs to be decrypted (confusing,
+ * but the defines are written from the point of view of the TPM).
+ *
+ * Any session appended by this command must be finalized by calling
+ * tpm_buf_fill_hmac_session() otherwise the HMAC will be incorrect
+ * and the TPM will reject the command.
+ *
+ * As with most tpm_buf operations, success is assumed because failure
+ * will be caused by an incorrect programming model and indicated by a
+ * kernel message.
+ */
+void tpm_buf_append_hmac_session(struct tpm_buf *buf, struct tpm2_auth *auth,
+				 u8 attributes, u8 *passphrase,
+				 int passphraselen)
+{
+	u8 nonce[SHA256_DIGEST_SIZE];
+	u32 len;
+
+	/*
+	 * The Architecture Guide requires us to strip trailing zeros
+	 * before computing the HMAC
+	 */
+	while (passphrase && passphraselen > 0
+	       && passphrase[passphraselen - 1] == '\0')
+		passphraselen--;
+
+	auth->attrs = attributes;
+	auth->passphraselen = passphraselen;
+	if (passphraselen)
+		memcpy(auth->passphrase, passphrase, passphraselen);
+
+	if (auth->session != tpm_buf_length(buf)) {
+		/* we're not the first session */
+		len = get_unaligned_be32(&buf->data[auth->session]);
+		if (4 + len + auth->session != tpm_buf_length(buf)) {
+			WARN(1, "session length mismatch, cannot append");
+			return;
+		}
+
+		/* add our new session */
+		len += 9 + 2 * SHA256_DIGEST_SIZE;
+		put_unaligned_be32(len, &buf->data[auth->session]);
+	} else {
+		tpm_buf_append_u32(buf, 9 + 2 * SHA256_DIGEST_SIZE);
+	}
+
+	/* random number for our nonce */
+	get_random_bytes(nonce, sizeof(nonce));
+	memcpy(auth->our_nonce, nonce, sizeof(nonce));
+	tpm_buf_append_u32(buf, auth->handle);
+	/* our new nonce */
+	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
+	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
+	tpm_buf_append_u8(buf, auth->attrs);
+	/* and put a placeholder for the hmac */
+	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
+	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
+}
+EXPORT_SYMBOL(tpm_buf_append_hmac_session);
+
+/**
+ * tpm_buf_fill_hmac_session() - finalize the session HMAC
+ * @buf: The buffer to be appended
+ * @auth: the auth structure allocated by tpm2_start_auth_session()
+ *
+ * This command must not be called until all of the parameters have
+ * been appended to @buf otherwise the computed HMAC will be
+ * incorrect.
+ *
+ * This function computes and fills in the session HMAC using the
+ * session key and, if TPM2_SA_DECRYPT was specified, computes the
+ * encryption key and encrypts the first parameter of the command
+ * buffer with it.
+ *
+ * As with most tpm_buf operations, success is assumed because failure
+ * will be caused by an incorrect programming model and indicated by a
+ * kernel message.
+ */
+void tpm_buf_fill_hmac_session(struct tpm_buf *buf, struct tpm2_auth *auth)
+{
+	u32 cc, handles, val;
+	struct tpm_chip *chip = auth->chip;
+	int i;
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	const u8 *s, *p;
+	u8 *hmac = NULL;
+	u32 attrs;
+	u8 cphash[SHA256_DIGEST_SIZE];
+	SHASH_DESC_ON_STACK(desc, sha256_hash);
+
+	/* save the command code in BE format */
+	auth->ordinal = head->ordinal;
+
+	desc->tfm = sha256_hash;
+
+	cc = be32_to_cpu(head->ordinal);
+
+	i = tpm2_find_cc(chip, cc);
+	if (i < 0) {
+		dev_err(&chip->dev, "Command 0x%x not found in TPM\n", cc);
+		return;
+	}
+	attrs = chip->cc_attrs_tbl[i];
+
+	handles = (attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0);
+
+	s = &buf->data[TPM_HEADER_SIZE];
+	/*
+	 * just check the names, it's easy to make mistakes.  This
+	 * would happen if someone added a handle via
+	 * tpm_buf_append_u32() instead of tpm_buf_append_name()
+	 */
+	for (i = 0; i < handles; i++) {
+		u32 handle = tpm_get_inc_u32(&s);
+
+		if (auth->name_h[i] != handle) {
+			dev_err(&chip->dev, "TPM: handle %d wrong for name\n",
+				  i);
+			return;
+		}
+	}
+	/* point s to the start of the sessions */
+	val = tpm_get_inc_u32(&s);
+	/* point p to the start of the parameters */
+	p = s + val;
+	for (i = 1; s < p; i++) {
+		u32 handle = tpm_get_inc_u32(&s);
+		u16 len;
+		u8 a;
+
+		/* nonce (already in auth) */
+		len = tpm_get_inc_u16(&s);
+		s += len;
+
+		a = *s++;
+
+		len = tpm_get_inc_u16(&s);
+		if (handle == auth->handle && auth->attrs == a) {
+			hmac = (u8 *)s;
+			/*
+			 * save our session number so we know which
+			 * session in the response belongs to us
+			 */
+			auth->session = i;
+		}
+
+		s += len;
+	}
+	if (s != p) {
+		dev_err(&chip->dev, "TPM session length is incorrect\n");
+		return;
+	}
+	if (!hmac) {
+		dev_err(&chip->dev, "TPM could not find HMAC session\n");
+		return;
+	}
+
+	/* encrypt before HMAC */
+	if (auth->attrs & TPM2_SA_DECRYPT) {
+		struct scatterlist sg[1];
+		u16 len;
+		SYNC_SKCIPHER_REQUEST_ON_STACK(req, auth->aes);
+		DECLARE_CRYPTO_WAIT(wait);
+
+		skcipher_request_set_sync_tfm(req, auth->aes);
+		skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
+					      crypto_req_done, &wait);
+
+		/* need key and IV */
+		KDFa(auth->session_key, SHA256_DIGEST_SIZE
+		     + auth->passphraselen, "CFB", auth->our_nonce,
+		     auth->tpm_nonce, AES_KEYBYTES + AES_BLOCK_SIZE,
+		     auth->scratch);
+		crypto_sync_skcipher_setkey(auth->aes, auth->scratch, AES_KEYBYTES);
+		len = tpm_get_inc_u16(&p);
+		sg_init_one(sg, p, len);
+		skcipher_request_set_crypt(req, sg, sg, len,
+					   auth->scratch + AES_KEYBYTES);
+		crypto_wait_req(crypto_skcipher_encrypt(req), &wait);
+		/* reset p to beginning of parameters for HMAC */
+		p -= 2;
+	}
+
+	crypto_shash_init(desc);
+	/* ordinal is already BE */
+	crypto_shash_update(desc, (u8 *)&head->ordinal, sizeof(head->ordinal));
+	/* add the handle names */
+	for (i = 0; i < handles; i++) {
+		u8 mso = auth->name_h[i] >> 24;
+
+		if (mso == 0x81 || mso == 0x80 || mso == 0x01) {
+			crypto_shash_update(desc, auth->name[i],
+					    SHA256_DIGEST_SIZE + 2);
+		} else {
+			__be32 h = cpu_to_be32(auth->name_h[i]);
+
+			crypto_shash_update(desc, (u8 *)&h, 4);
+		}
+	}
+	if (buf->data - s != tpm_buf_length(buf))
+		crypto_shash_update(desc, s, buf->data
+				    + tpm_buf_length(buf) - s);
+	crypto_shash_final(desc, cphash);
+
+	/* now calculate the hmac */
+	hmac_init(desc, auth->session_key, sizeof(auth->session_key)
+		  + auth->passphraselen);
+	crypto_shash_update(desc, cphash, sizeof(cphash));
+	crypto_shash_update(desc, auth->our_nonce, sizeof(auth->our_nonce));
+	crypto_shash_update(desc, auth->tpm_nonce, sizeof(auth->tpm_nonce));
+	crypto_shash_update(desc, &auth->attrs, 1);
+	hmac_final(desc, auth->session_key, sizeof(auth->session_key)
+		   + auth->passphraselen, hmac);
+}
+EXPORT_SYMBOL(tpm_buf_fill_hmac_session);
+
+static int parse_read_public(char *name, const u8 *data)
+{
+	struct tpm_header *head = (struct tpm_header *)data;
+	u32 tot_len = be32_to_cpu(head->length);
+	u32 val;
+
+	data += TPM_HEADER_SIZE;
+	/* we're starting after the header so adjust the length */
+	tot_len -= TPM_HEADER_SIZE;
+
+	/* skip public */
+	val = tpm_get_inc_u16(&data);
+	if (val > tot_len)
+		return -EINVAL;
+	data += val;
+	/* name */
+	val = tpm_get_inc_u16(&data);
+	if (val != SHA256_DIGEST_SIZE + 2)
+		return -EINVAL;
+	memcpy(name, data, SHA256_DIGEST_SIZE + 2);
+	/* forget the rest */
+	return 0;
+}
+
+static int tpm2_readpublic(struct tpm_chip *chip, u32 handle, char *name)
+{
+	struct tpm_buf buf;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, handle);
+	rc = tpm_transmit_cmd(chip, &buf, 0, "read public");
+	if (rc == TPM2_RC_SUCCESS)
+		rc = parse_read_public(name, buf.data);
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
+/**
+ * tpm_buf_append_name() - add a handle area to the buffer
+ * @buf: The buffer to be appended
+ * @auth: the auth structure allocated by tpm2_start_auth_session()
+ * @handle: The handle to be appended
+ * @name: The name of the handle (may be NULL)
+ *
+ * In order to compute session HMACs, we need to know the names of the
+ * objects pointed to by the handles.  For most objects, this is simly
+ * the actual 4 byte handle or an empty buf (in these cases @name
+ * should be NULL) but for volatile objects, permanent objects and NV
+ * areas, the name is defined as the hash (according to the name
+ * algorithm which should be set to sha256) of the public area to
+ * which the two byte algorithm id has been appended.  For these
+ * objects, the @name pointer should point to this.  If a name is
+ * required but @name is NULL, then TPM2_ReadPublic() will be called
+ * on the handle to obtain the name.
+ *
+ * As with most tpm_buf operations, success is assumed because failure
+ * will be caused by an incorrect programming model and indicated by a
+ * kernel message.
+ */
+void tpm_buf_append_name(struct tpm_buf *buf, struct tpm2_auth *auth,
+			 u32 handle, u8 *name)
+{
+	int slot;
+	u8 mso = handle >> 24;
+
+	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE)/4;
+	if (slot >= AUTH_MAX_NAMES) {
+		dev_err(&auth->chip->dev, "TPM: too many handles\n");
+		return;
+	}
+	WARN(auth->session != tpm_buf_length(buf),
+	     "name added in wrong place\n");
+	tpm_buf_append_u32(buf, handle);
+	auth->session += 4;
+
+	if (mso == 0x81 || mso == 0x80 || mso == 0x01) {
+		if (!name)
+			tpm2_readpublic(auth->chip, handle, auth->name[slot]);
+	} else {
+		if (name)
+			dev_err(&auth->chip->dev, "TPM: Handle does not require name but one is specified\n");
+	}
+
+	auth->name_h[slot] = handle;
+	if (name)
+		memcpy(auth->name[slot], name, SHA256_DIGEST_SIZE + 2);
+}
+EXPORT_SYMBOL(tpm_buf_append_name);
+
+/**
+ * tpm_buf_check_hmac_response() - check the TPM return HMAC for correctness
+ * @buf: the original command buffer (which now contains the response)
+ * @auth: the auth structure allocated by tpm2_start_auth_session()
+ * @rc: the return code from tpm_transmit_cmd
+ *
+ * If @rc is non zero, @buf may not contain an actual return, so @rc
+ * is passed through as the return and the session cleaned up and
+ * de-allocated if required (this is required if
+ * TPM2_SA_CONTINUE_SESSION was not specified as a session flag).
+ *
+ * If @rc is zero, the response HMAC is computed against the returned
+ * @buf and matched to the TPM one in the session area.  If there is a
+ * mismatch, an error is logged and -EINVAL returned.
+ *
+ * The reason for this is that the command issue and HMAC check
+ * sequence should look like:
+ *
+ *	rc = tpm_transmit_cmd(...);
+ *	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
+ *	if (rc)
+ *		...
+ *
+ * Which is easily layered into the current contrl flow.
+ *
+ * Returns: 0 on success or an error.
+ */
+int tpm_buf_check_hmac_response(struct tpm_buf *buf, struct tpm2_auth *auth,
+				int rc)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	struct tpm_chip *chip = auth->chip;
+	const u8 *s, *p;
+	u8 rphash[SHA256_DIGEST_SIZE];
+	u32 attrs;
+	SHASH_DESC_ON_STACK(desc, sha256_hash);
+	u16 tag = be16_to_cpu(head->tag);
+	u32 cc = be32_to_cpu(auth->ordinal);
+	int parm_len, len, i, handles;
+
+	if (auth->session >= TPM_HEADER_SIZE) {
+		WARN(1, "tpm session not filled correctly\n");
+		goto out;
+	}
+
+	if (rc != 0)
+		/* pass non success rc through and close the session */
+		goto out;
+
+	rc = -EINVAL;
+	if (tag != TPM2_ST_SESSIONS) {
+		dev_err(&chip->dev, "TPM: HMAC response check has no sessions tag\n");
+		goto out;
+	}
+
+	i = tpm2_find_cc(chip, cc);
+	if (i < 0)
+		goto out;
+	attrs = chip->cc_attrs_tbl[i];
+	handles = (attrs >> TPM2_CC_ATTR_RHANDLE) & 1;
+
+	/* point to area beyond handles */
+	s = &buf->data[TPM_HEADER_SIZE + handles * 4];
+	parm_len = tpm_get_inc_u32(&s);
+	p = s;
+	s += parm_len;
+	/* skip over any sessions before ours */
+	for (i = 0; i < auth->session - 1; i++) {
+		len = tpm_get_inc_u16(&s);
+		s += len + 1;
+		len = tpm_get_inc_u16(&s);
+		s += len;
+	}
+	/* TPM nonce */
+	len = tpm_get_inc_u16(&s);
+	if (s - buf->data + len > tpm_buf_length(buf))
+		goto out;
+	if (len != SHA256_DIGEST_SIZE)
+		goto out;
+	memcpy(auth->tpm_nonce, s, len);
+	s += len;
+	attrs = *s++;
+	len = tpm_get_inc_u16(&s);
+	if (s - buf->data + len != tpm_buf_length(buf))
+		goto out;
+	if (len != SHA256_DIGEST_SIZE)
+		goto out;
+	/*
+	 * s points to the HMAC. now calculate comparison, beginning
+	 * with rphash
+	 */
+	desc->tfm = sha256_hash;
+	crypto_shash_init(desc);
+	/* yes, I know this is now zero, but it's what the standard says */
+	crypto_shash_update(desc, (u8 *)&head->return_code,
+			    sizeof(head->return_code));
+	/* ordinal is already BE */
+	crypto_shash_update(desc, (u8 *)&auth->ordinal, sizeof(auth->ordinal));
+	crypto_shash_update(desc, p, parm_len);
+	crypto_shash_final(desc, rphash);
+
+	/* now calculate the hmac */
+	hmac_init(desc, auth->session_key, sizeof(auth->session_key)
+		  + auth->passphraselen);
+	crypto_shash_update(desc, rphash, sizeof(rphash));
+	crypto_shash_update(desc, auth->tpm_nonce, sizeof(auth->tpm_nonce));
+	crypto_shash_update(desc, auth->our_nonce, sizeof(auth->our_nonce));
+	crypto_shash_update(desc, &auth->attrs, 1);
+	/* we're done with the rphash, so put our idea of the hmac there */
+	hmac_final(desc, auth->session_key, sizeof(auth->session_key)
+		   + auth->passphraselen, rphash);
+	if (memcmp(rphash, s, SHA256_DIGEST_SIZE) == 0) {
+		rc = 0;
+	} else {
+		dev_err(&auth->chip->dev, "TPM: HMAC check failed\n");
+		goto out;
+	}
+
+	/* now do response decryption */
+	if (auth->attrs & TPM2_SA_ENCRYPT) {
+		struct scatterlist sg[1];
+		SYNC_SKCIPHER_REQUEST_ON_STACK(req, auth->aes);
+		DECLARE_CRYPTO_WAIT(wait);
+
+		skcipher_request_set_sync_tfm(req, auth->aes);
+		skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
+					      crypto_req_done, &wait);
+
+		/* need key and IV */
+		KDFa(auth->session_key, SHA256_DIGEST_SIZE
+		     + auth->passphraselen, "CFB", auth->tpm_nonce,
+		     auth->our_nonce, AES_KEYBYTES + AES_BLOCK_SIZE,
+		     auth->scratch);
+		crypto_sync_skcipher_setkey(auth->aes, auth->scratch, AES_KEYBYTES);
+		len = tpm_get_inc_u16(&p);
+		sg_init_one(sg, p, len);
+		skcipher_request_set_crypt(req, sg, sg, len,
+					   auth->scratch + AES_KEYBYTES);
+		crypto_wait_req(crypto_skcipher_decrypt(req), &wait);
+	}
+
+ out:
+	if ((auth->attrs & TPM2_SA_CONTINUE_SESSION) == 0) {
+		/* manually close the session if it wasn't consumed */
+		if (rc)
+			tpm2_flush_context(chip, auth->handle);
+		crypto_free_sync_skcipher(auth->aes);
+		kfree(auth);
+	} else {
+		/* reset for next use  */
+		auth->session = TPM_HEADER_SIZE;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(tpm_buf_check_hmac_response);
+
+/**
+ * tpm2_end_auth_session - kill the allocated auth session
+ * @auth: the auth structure allocated by tpm2_start_auth_session()
+ *
+ * ends the session started by tpm2_start_auth_session and frees all
+ * the resources.  Under normal conditions,
+ * tpm_buf_check_hmac_response() will correctly end the session if
+ * required, so this function is only for use in error legs that will
+ * bypass the normal invocation of tpm_buf_check_hmac_respons().
+ */
+void tpm2_end_auth_session(struct tpm2_auth *auth)
+{
+	tpm2_flush_context(auth->chip, auth->handle);
+	crypto_free_sync_skcipher(auth->aes);
+	kfree(auth);
+}
+EXPORT_SYMBOL(tpm2_end_auth_session);
+
+static int parse_start_auth_session(struct tpm2_auth *auth, const u8 *data)
+{
+	struct tpm_header *head = (struct tpm_header *)data;
+	u32 tot_len = be32_to_cpu(head->length);
+	u32 val;
+
+	data += TPM_HEADER_SIZE;
+	/* we're starting after the header so adjust the length */
+	tot_len -= TPM_HEADER_SIZE;
+
+	/* should have handle plus nonce */
+	if (tot_len != 4 + 2 + sizeof(auth->tpm_nonce))
+		return -EINVAL;
+
+	auth->handle = tpm_get_inc_u32(&data);
+	val = tpm_get_inc_u16(&data);
+	if (val != sizeof(auth->tpm_nonce))
+		return -EINVAL;
+	memcpy(auth->tpm_nonce, data, sizeof(auth->tpm_nonce));
+	/* now compute the session key from the nonces */
+	KDFa(auth->salt, sizeof(auth->salt), "ATH", auth->tpm_nonce,
+	     auth->our_nonce, sizeof(auth->session_key), auth->session_key);
+
+	return 0;
+}
+
+/**
+ * tpm2_start_auth_session - create a HMAC authentication session with the TPM
+ * @chip: the TPM chip structure to create the session with
+ * @authp: A pointer to an opaque tpm2_auth structure to be allocated
+ *
+ * This function loads the NULL seed from its saved context and starts
+ * an authentication session on the null seed, allocates a tpm2_auth
+ * structure to contain all the session details necessary for
+ * performing the HMAC, encrypt and decrypt operations, fills it in
+ * and returns.  The NULL seed is flushed before this function returns.
+ *
+ * Return: zero on success or actual error encountered.  If return is
+ * zero, @authp will be allocated.
+ */
+int tpm2_start_auth_session(struct tpm_chip *chip, struct tpm2_auth **authp)
+{
+	struct tpm_buf buf;
+	struct tpm2_auth *auth;
+	int rc;
+	unsigned int offset = 0; /* dummy offset for null seed context */
+	u32 nullkey;
+
+	auth = kmalloc(sizeof(**authp), GFP_KERNEL);
+	if (!auth)
+		return -ENOMEM;
+
+	rc = tpm2_load_context(chip, chip->tpmkeycontext, &offset,
+			       &nullkey);
+	if (rc)
+		return rc;
+
+	auth->chip = chip;
+	auth->session = TPM_HEADER_SIZE;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH_SESS);
+	if (rc)
+		goto out;
+
+	/* salt key handle */
+	tpm_buf_append_u32(&buf, nullkey);
+	/* bind key handle */
+	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
+	/* nonce caller */
+	get_random_bytes(auth->our_nonce, sizeof(auth->our_nonce));
+	tpm_buf_append_u16(&buf, sizeof(auth->our_nonce));
+	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
+
+	/* append encrypted salt and squirrel away unencrypted in auth */
+	tpm_buf_append_salt(&buf, chip, auth);
+	/* session type (HMAC, audit or policy) */
+	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
+
+	/* symmetric encryption parameters */
+	/* symmetric algorithm */
+	tpm_buf_append_u16(&buf, TPM_ALG_AES);
+	/* bits for symmetric algorithm */
+	tpm_buf_append_u16(&buf, AES_KEYBITS);
+	/* symmetric algorithm mode (must be CFB) */
+	tpm_buf_append_u16(&buf, TPM_ALG_CFB);
+	/* hash algorithm for session */
+	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
+
+	rc = tpm_transmit_cmd(chip, &buf, 0, "start auth session");
+	tpm2_flush_context(chip, nullkey);
+
+	if (rc == TPM2_RC_SUCCESS)
+		rc = parse_start_auth_session(auth, buf.data);
+
+	tpm_buf_destroy(&buf);
+
+	if (rc)
+		goto out;
+
+	auth->aes = crypto_alloc_sync_skcipher("cfb(aes)", 0, 0);
+	if (IS_ERR(auth->aes)) {
+		rc = PTR_ERR(auth->aes);
+		dev_err(&chip->dev, "TPM: error getting cfb(aes): %d\n", rc);
+	}
+ out:
+	if (rc)
+		kfree(auth);
+	else
+		*authp = auth;
+
+	return rc;
+}
+EXPORT_SYMBOL(tpm2_start_auth_session);
+
+static int parse_create_primary(struct tpm_chip *chip, u8 *data, u32 *nullkey)
+{
+	struct tpm_header *head = (struct tpm_header *)data;
+	u16 len;
+	u32 tot_len = be32_to_cpu(head->length);
+	u32 val, parm_len;
+	const u8 *resp, *tmp;
+	SHASH_DESC_ON_STACK(desc, sha256_hash);
+
+	data += TPM_HEADER_SIZE;
+	/* we're starting after the header so adjust the length */
+	tot_len -= TPM_HEADER_SIZE;
+
+	resp = data;
+	*nullkey = tpm_get_inc_u32(&resp);
+	parm_len = tpm_get_inc_u32(&resp);
+	if (parm_len + 8 > tot_len)
+		return -EINVAL;
+	len = tpm_get_inc_u16(&resp);
+	tmp = resp;
+	/* now we have the public area, compute the name of the object */
+	desc->tfm = sha256_hash;
+	put_unaligned_be16(TPM_ALG_SHA256, chip->tpmkeyname);
+	crypto_shash_init(desc);
+	crypto_shash_update(desc, resp, len);
+	crypto_shash_final(desc, chip->tpmkeyname + 2);
+	/* validate the public key */
+	val = tpm_get_inc_u16(&tmp);
+	/* key type (must be what we asked for) */
+	if (val != TPM_ALG_ECC)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* name algorithm */
+	if (val != TPM_ALG_SHA256)
+		return -EINVAL;
+	val = tpm_get_inc_u32(&tmp);
+	/* object properties */
+	if (val != (TPM2_OA_NO_DA |
+		    TPM2_OA_FIXED_TPM |
+		    TPM2_OA_FIXED_PARENT |
+		    TPM2_OA_SENSITIVE_DATA_ORIGIN |
+		    TPM2_OA_USER_WITH_AUTH |
+		    TPM2_OA_DECRYPT |
+		    TPM2_OA_RESTRICTED))
+		return -EINVAL;
+	/* auth policy (empty) */
+	val = tpm_get_inc_u16(&tmp);
+	if (val != 0)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* symmetric key parameters */
+	if (val != TPM_ALG_AES)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* symmetric key length */
+	if (val != AES_KEYBITS)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* symmetric encryption scheme */
+	if (val != TPM_ALG_CFB)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* signing scheme */
+	if (val != TPM_ALG_NULL)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* ECC Curve */
+	if (val != TPM2_ECC_NIST_P256)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* KDF Scheme */
+	if (val != TPM_ALG_NULL)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* x point */
+	if (val != 32)
+		return -EINVAL;
+	memcpy(chip->ec_point_x, tmp, val);
+	tmp += val;
+	val = tpm_get_inc_u16(&tmp);
+	if (val != 32)
+		return -EINVAL;
+	memcpy(chip->ec_point_y, tmp, val);
+	tmp += val;
+	resp += len;
+	/* should have exactly consumed the tpm2b public structure */
+	if (tmp != resp)
+		return -EINVAL;
+	if (resp - data > parm_len)
+		return -EINVAL;
+	/* creation data (skip) */
+	len = tpm_get_inc_u16(&resp);
+	resp += len;
+	if (resp - data > parm_len)
+		return -EINVAL;
+	/* creation digest (must be sha256) */
+	len = tpm_get_inc_u16(&resp);
+	resp += len;
+	if (len != SHA256_DIGEST_SIZE || resp - data > parm_len)
+		return -EINVAL;
+	/* TPMT_TK_CREATION follows */
+	/* tag, must be TPM_ST_CREATION (0x8021) */
+	val = tpm_get_inc_u16(&resp);
+	if (val != TPM2_ST_CREATION || resp - data > parm_len)
+		return -EINVAL;
+	/* hierarchy (must be NULL) */
+	val = tpm_get_inc_u32(&resp);
+	if (val != TPM2_RH_NULL || resp - data > parm_len)
+		return -EINVAL;
+	/* the ticket digest HMAC (might not be sha256) */
+	len = tpm_get_inc_u16(&resp);
+	resp += len;
+	if (resp - data > parm_len)
+		return -EINVAL;
+	/*
+	 * finally we have the name, which is a sha256 digest plus a 2
+	 * byte algorithm type
+	 */
+	len = tpm_get_inc_u16(&resp);
+	if (resp + len - data != parm_len + 8)
+		return -EINVAL;
+	if (len != SHA256_DIGEST_SIZE + 2)
+		return -EINVAL;
+
+	if (memcmp(chip->tpmkeyname, resp, SHA256_DIGEST_SIZE + 2) != 0) {
+		printk("TPM NULL Seed name comparison failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy, u32 *handle)
+{
+	int rc;
+	struct tpm_buf buf;
+	struct tpm_buf template;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE_PRIMARY);
+	if (rc)
+		return rc;
+
+	rc = tpm_buf_init_2b(&template);
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		return rc;
+	}
+
+	/*
+	 * create the template.  Note: in order for userspace to
+	 * verify the security of the system, it will have to create
+	 * and certify this NULL primary, meaning all the template
+	 * parameters will have to be identical, so conform exactly to
+	 * the TCG TPM v2.0 Provisioning Guidance for the SRK ECC
+	 * key
+	 */
+
+	/* key type */
+	tpm_buf_append_u16(&template, TPM_ALG_ECC);
+	/* name algorithm */
+	tpm_buf_append_u16(&template, TPM_ALG_SHA256);
+	/* object properties */
+	tpm_buf_append_u32(&template, TPM2_OA_NO_DA |
+			   TPM2_OA_FIXED_TPM |
+			   TPM2_OA_FIXED_PARENT |
+			   TPM2_OA_SENSITIVE_DATA_ORIGIN |
+			   TPM2_OA_USER_WITH_AUTH |
+			   TPM2_OA_DECRYPT |
+			   TPM2_OA_RESTRICTED);
+	/* sauth policy (empty) */
+	tpm_buf_append_u16(&template, 0);
+
+	/* BEGIN parameters: key specific; for ECC*/
+	/* symmetric algorithm */
+	tpm_buf_append_u16(&template, TPM_ALG_AES);
+	/* bits for symmetric algorithm */
+	tpm_buf_append_u16(&template, 128);
+	/* algorithm mode (must be CFB) */
+	tpm_buf_append_u16(&template, TPM_ALG_CFB);
+	/* scheme (NULL means any scheme) */
+	tpm_buf_append_u16(&template, TPM_ALG_NULL);
+	/* ECC Curve ID */
+	tpm_buf_append_u16(&template, TPM2_ECC_NIST_P256);
+	/* KDF Scheme */
+	tpm_buf_append_u16(&template, TPM_ALG_NULL);
+	/* unique: key specific; for ECC it is two points */
+	tpm_buf_append_u16(&template, 0);
+	tpm_buf_append_u16(&template, 0);
+	/* END parameters */
+
+	/* primary handle */
+	tpm_buf_append_u32(&buf, hierarchy);
+	/* simple authorization for empty auth */
+	tpm2_buf_append_auth(&buf, TPM2_RS_PW, NULL, 0, 0, NULL, 0);
+	/* sensitive create size is 4 for two empty buffers */
+	tpm_buf_append_u16(&buf, 4);
+	/* sensitive create auth data (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* sensitive create sensitive data (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* the public template */
+	tpm_buf_append_2b(&buf, &template);
+	tpm_buf_destroy(&template);
+	/* outside info (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* creation PCR (none) */
+	tpm_buf_append_u32(&buf, 0);
+
+	rc = tpm_transmit_cmd(chip, &buf, 0,
+			      "attempting to create NULL primary");
+
+	if (rc == TPM2_RC_SUCCESS)
+		rc = parse_create_primary(chip, buf.data, handle);
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
+int tpm2_create_null_primary(struct tpm_chip *chip) {
+	u32 nullkey;
+	int rc;
+
+	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &nullkey);
+
+	if (rc == TPM2_RC_SUCCESS) {
+		unsigned int offset = 0; /* dummy offset for tpmkeycontext */
+
+		rc = tpm2_save_context(chip, nullkey, chip->tpmkeycontext,
+				       sizeof(chip->tpmkeycontext), &offset);
+		tpm2_flush_context(chip, nullkey);
+	}
+
+	return rc;
+}
+
+int tpm2_sessions_init(struct tpm_chip *chip)
+{
+	int rc;
+
+	sha256_hash = crypto_alloc_shash("sha256", 0, 0);
+	if (!sha256_hash) {
+		dev_err(&chip->dev, "TPM: failed to allocate hash\n");
+		return -ENOMEM;
+	}
+
+	rc = tpm2_create_null_primary(chip);
+	if (rc)
+		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
+	return rc;
+}
+EXPORT_SYMBOL(tpm2_sessions_init);
diff --git a/drivers/char/tpm/tpm2-sessions.h b/drivers/char/tpm/tpm2-sessions.h
new file mode 100644
index 000000000000..ec245731edaf
--- /dev/null
+++ b/drivers/char/tpm/tpm2-sessions.h
@@ -0,0 +1,137 @@
+/*
+ * Defines for TPM2 authentications
+ */
+
+#ifndef _TPM2_SESSIONS_H
+#define _TPM2_SESSIONS_H
+
+#include "tpm.h"
+
+enum tpm2_object_attributes {
+	TPM2_OA_FIXED_TPM		= BIT(1),
+	TPM2_OA_ST_CLEAR		= BIT(2),
+	TPM2_OA_FIXED_PARENT		= BIT(4),
+	TPM2_OA_SENSITIVE_DATA_ORIGIN	= BIT(5),
+	TPM2_OA_USER_WITH_AUTH		= BIT(6),
+	TPM2_OA_ADMIN_WITH_POLICY	= BIT(7),
+	TPM2_OA_NO_DA			= BIT(10),
+	TPM2_OA_ENCRYPTED_DUPLICATION	= BIT(11),
+	TPM2_OA_RESTRICTED		= BIT(16),
+	TPM2_OA_DECRYPT			= BIT(17),
+	TPM2_OA_SIGN			= BIT(18),
+};
+
+enum tpm2_session_attributes {
+	TPM2_SA_CONTINUE_SESSION	= BIT(0),
+	TPM2_SA_AUDIT_EXCLUSIVE		= BIT(1),
+	TPM2_SA_AUDIT_RESET		= BIT(3),
+	TPM2_SA_DECRYPT			= BIT(5),
+	TPM2_SA_ENCRYPT			= BIT(6),
+	TPM2_SA_AUDIT			= BIT(7),
+};
+
+enum tpm2_session_types {
+	TPM2_SE_HMAC	= 0x00,
+	TPM2_SE_POLICY	= 0x01,
+	TPM2_SE_TRIAL	= 0x02,
+};
+
+struct tpm2_auth;
+
+void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
+			  const u8 *nonce, u16 nonce_len,
+			  u8 attributes,
+			  const u8 *hmac, u16 hmac_len);
+
+#ifdef CONFIG_TPM_BUS_SECURITY
+
+int tpm2_start_auth_session(struct tpm_chip *chip, struct tpm2_auth **authp);
+void tpm_buf_append_name(struct tpm_buf *buf, struct tpm2_auth *auth,
+			 u32 handle, u8 *name);
+void tpm_buf_append_hmac_session(struct tpm_buf *buf, struct tpm2_auth *auth,
+				 u8 attributes, u8 *passphrase,
+				 int passphraselen);
+static inline void tpm_buf_append_hmac_session_opt(struct tpm_buf *buf,
+						   struct tpm2_auth *auth,
+						   u8 attributes,
+						   u8 *passphrase,
+						   int passphraselen)
+{
+	tpm_buf_append_hmac_session(buf, auth, attributes, passphrase,
+				    passphraselen);
+}
+void tpm_buf_fill_hmac_session(struct tpm_buf *buf, struct tpm2_auth *auth);
+int tpm_buf_check_hmac_response(struct tpm_buf *buf, struct tpm2_auth *auth,
+				int rc);
+void tpm2_end_auth_session(struct tpm2_auth *auth);
+#else
+#include <asm/unaligned.h>
+
+static inline int tpm2_start_auth_session(struct tpm_chip *chip,
+					  struct tpm2_auth **authp)
+{
+	return 0;
+}
+static inline void tpm2_end_auth_session(struct tpm2_auth *auth)
+{
+}
+static inline void tpm_buf_append_name(struct tpm_buf *buf,
+				       struct tpm2_auth *auth,
+				       u32 handle, u8 *name)
+{
+	tpm_buf_append_u32(buf, handle);
+	/* count the number of handles in the upper bits of flags */
+	buf->handles++;
+}
+static inline void tpm_buf_append_hmac_session(struct tpm_buf *buf,
+					       struct tpm2_auth *auth,
+					       u8 attributes, u8 *passphrase,
+					       int passphraselen)
+{
+	/* offset tells us where the sessions area begins */
+	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+	u32 len = 9 + passphraselen;
+	if (tpm_buf_length(buf) != offset) {
+		/* not the first session so update the existing length */
+		len += get_unaligned_be32(&buf->data[offset]);
+		put_unaligned_be32(len, &buf->data[offset]);
+	} else {
+		tpm_buf_append_u32(buf, len);
+	}
+	/* auth handle */
+	tpm_buf_append_u32(buf, TPM2_RS_PW);
+	/* nonce */
+	tpm_buf_append_u16(buf, 0);
+	/* attributes */
+	tpm_buf_append_u8(buf, 0);
+	/* passphrase */
+	tpm_buf_append_u16(buf, passphraselen);
+	tpm_buf_append(buf, passphrase, passphraselen);
+}
+static inline void tpm_buf_append_hmac_session_opt(struct tpm_buf *buf,
+						   struct tpm2_auth *auth,
+						   u8 attributes,
+						   u8 *passphrase,
+						   int passphraselen)
+{
+	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+	struct tpm_header *head = (struct tpm_header *) buf->data;
+
+	/* if the only sessions are optional, the command tag
+	 * must change to TPM2_ST_NO_SESSIONS */
+	if (tpm_buf_length(buf) == offset)
+		head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+}
+static inline void tpm_buf_fill_hmac_session(struct tpm_buf *buf,
+					     struct tpm2_auth *auth)
+{
+}
+static inline int tpm_buf_check_hmac_response(struct tpm_buf *buf,
+					      struct tpm2_auth *auth,
+					      int rc)
+{
+	return rc;
+}
+#endif	/* CONFIG_TPM_BUS_SECURITY */
+
+#endif
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 53c0ea9ec9df..949e7fb725a8 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -33,14 +33,23 @@ struct trusted_key_options;
 enum tpm_algorithms {
 	TPM_ALG_ERROR		= 0x0000,
 	TPM_ALG_SHA1		= 0x0004,
+	TPM_ALG_AES		= 0x0006,
 	TPM_ALG_KEYEDHASH	= 0x0008,
 	TPM_ALG_SHA256		= 0x000B,
 	TPM_ALG_SHA384		= 0x000C,
 	TPM_ALG_SHA512		= 0x000D,
 	TPM_ALG_NULL		= 0x0010,
 	TPM_ALG_SM3_256		= 0x0012,
+	TPM_ALG_ECC		= 0x0023,
+	TPM_ALG_CFB		= 0x0043,
 };
 
+enum tpm2_curves {
+	TPM2_ECC_NONE		= 0x0000,
+	TPM2_ECC_NIST_P256	= 0x0003,
+};
+
+
 struct tpm_digest {
 	u16 alg_id;
 	u8 digest[TPM_MAX_DIGEST_SIZE];
@@ -105,6 +114,20 @@ struct tpm_chip_seqops {
 	const struct seq_operations *seqops;
 };
 
+/* fixed define for the curve we use which is NIST_P256 */
+#define EC_PT_SZ	32
+
+/*
+ * fixed define for the size of a name.  This is actually HASHALG size
+ * plus 2, so 32 for SHA256
+ */
+#define TPM2_NAME_SIZE	34
+
+/*
+ * The maximum size for an object context
+ */
+#define TPM2_MAX_CONTEXT_SIZE 2048
+
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
@@ -159,6 +182,12 @@ struct tpm_chip {
 
 	/* active locality */
 	int locality;
+
+	/* details for communication security via sessions */
+	u8 tpmkeycontext[TPM2_MAX_CONTEXT_SIZE]; /* context for NULL seed */
+	u8 tpmkeyname[TPM2_NAME_SIZE];		 /* name of NULL seed */
+	u8 ec_point_x[EC_PT_SZ];
+	u8 ec_point_y[EC_PT_SZ];
 };
 
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
-- 
2.16.4

