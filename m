Return-Path: <linux-integrity+bounces-240-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED717FAA19
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 20:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B363C2819E3
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 19:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28CD3EA71;
	Mon, 27 Nov 2023 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ugWkZZvy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A5D5F;
	Mon, 27 Nov 2023 11:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701112682;
	bh=pzN5tUo4qi+t7HpnzcHlgs9MOeajsNYw/dwV9uSkdjw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=ugWkZZvyxAqhDO1wwJoTMIVx8C7EktKtz71oKViin68cHW/pfdHyqr54AVRo9mncR
	 q3Ff6fWjtPx0jhs5OSyvDLmShmFjmDgqn/sat2Dh9Z84UfPOuye2zOTOCDD/2/Ddj8
	 VHb9FC0Qi/qdzY+Y1mDtIEuITTTH2i5ZDVAG8w48=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9BFD012867F5;
	Mon, 27 Nov 2023 14:18:02 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id zR6Vg68qYPIJ; Mon, 27 Nov 2023 14:18:02 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C3760128645F;
	Mon, 27 Nov 2023 14:18:01 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v5 12/17] tpm: Add full HMAC and encrypt/decrypt session handling code
Date: Mon, 27 Nov 2023 14:08:49 -0500
Message-Id: <20231127190854.13310-13-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127190854.13310-1-James.Bottomley@HansenPartnership.com>
References: <20231127190854.13310-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add session based HMAC authentication plus parameter decryption and
response encryption using AES. The basic design is to segregate all
the nasty crypto, hash and hmac code into tpm2-sessions.c and export a
usable API.  The API first of all starts off by gaining a session with

tpm2_start_auth_session()

which initiates a session with the TPM and allocates an opaque
tpm2_auth structure to handle the session parameters.  The design is
that session use will be single threaded from start to finish under
the ops lock, so the tpm2_auth structure is stored in struct
tpm2_chip. Then the use is simply:

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

To get all of this to work securely, the Kernel needs a primary key to
encrypt the session salt to, so an EC key from the NULL seed is
derived and its context saved in the tpm_chip structure.  The context
is loaded on demand into an available volatile handle when
tpm_start_auth_session() is called, but is flushed before that
function exits to conserve handles.

Doing the encryption and HMAC adds some overhead both in the TPM
handling and in the host side cryptography needed to set up the
requests and verify the responses.  A config option, TPM_BUS_SECURITY,
is added which eliminates the use of sessions and thus the extra
overhead when set to 'N'.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # crypto API parts

---

v2: fix memory leaks from smatch; adjust for name hash size
v3: make tpm2_make_null_primary static
v4: use crypto library functions
v5: kdoc fix, Kconfig help update, abstract out mso
---
 drivers/char/tpm/Kconfig         |   14 +
 drivers/char/tpm/Makefile        |    1 +
 drivers/char/tpm/tpm-buf.c       |    1 +
 drivers/char/tpm/tpm-chip.c      |    3 +
 drivers/char/tpm/tpm.h           |   10 +
 drivers/char/tpm/tpm2-cmd.c      |    5 +
 drivers/char/tpm/tpm2-sessions.c | 1176 ++++++++++++++++++++++++++++++
 include/linux/tpm.h              |  180 +++++
 8 files changed, 1390 insertions(+)
 create mode 100644 drivers/char/tpm/tpm2-sessions.c

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 927088b2c3d3..b85387742a6a 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -27,6 +27,20 @@ menuconfig TCG_TPM
 
 if TCG_TPM
 
+config TPM_BUS_SECURITY
+	bool "Use encrypted and HMACd transactions on the TPM bus"
+	default y
+	select CRYPTO_ECDH
+	select CRYPTO_LIB_AESCFB
+	select CRYPTO_LIB_SHA256
+	help
+          Setting this causes us to deploy a scheme which uses request
+	  and response HMACs in addition to encryption for
+	  communicating with the TPM to prevent or detect bus snooping
+	  and interposer attacks (see tpm-security.rst).  Saying Y
+	  here adds some encryption overhead to all kernel to TPM
+	  transactions.
+
 config HW_RANDOM_TPM
 	bool "TPM HW Random Number Generator support"
 	depends on TCG_TPM && HW_RANDOM && !(TCG_TPM=y && HW_RANDOM=m)
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index ad3594e383e1..10dc214aa093 100644
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
index bb81180495d1..274130398569 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -44,6 +44,7 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 	head->tag = cpu_to_be16(tag);
 	head->length = cpu_to_be32(sizeof(*head));
 	head->ordinal = cpu_to_be32(ordinal);
+	buf->handles = 0;
 }
 EXPORT_SYMBOL_GPL(tpm_buf_reset);
 
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 42b1062e33cd..82554fe13d0e 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -275,6 +275,9 @@ static void tpm_dev_release(struct device *dev)
 	kfree(chip->work_space.context_buf);
 	kfree(chip->work_space.session_buf);
 	kfree(chip->allocated_banks);
+#ifdef CONFIG_TPM_BUS_SECURITY
+	kfree(chip->auth);
+#endif
 	kfree(chip);
 }
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index cbc9d1e2974d..98a08da5723c 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -321,4 +321,14 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
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
index 93545be190a5..b0e72fb563d9 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -759,6 +759,11 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		rc = 0;
 	}
 
+	if (rc)
+		goto out;
+
+	rc = tpm2_sessions_init(chip);
+
 out:
 	/*
 	 * Infineon TPM in field upgrade mode will return no data for the number
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
new file mode 100644
index 000000000000..53b8e8f5d963
--- /dev/null
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -0,0 +1,1176 @@
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
+	struct crypto_aes_ctx aes_ctx;
+	/* saved session attributes */
+	u8 attrs;
+	__be32 ordinal;
+	/* 3 names of handles: name_h is handle, name is name of handle */
+	u32 name_h[AUTH_MAX_NAMES];
+	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
+};
+
+/*
+ * Name Size based on TPM algorithm (assumes no hash bigger than 255)
+ */
+static u8 name_size(const u8 *name)
+{
+	static u8 size_map[] = {
+		[TPM_ALG_SHA1] = SHA1_DIGEST_SIZE,
+		[TPM_ALG_SHA256] = SHA256_DIGEST_SIZE,
+		[TPM_ALG_SHA384] = SHA384_DIGEST_SIZE,
+		[TPM_ALG_SHA512] = SHA512_DIGEST_SIZE,
+	};
+	u16 alg = get_unaligned_be16(name);
+	return size_map[alg] + 2;
+}
+
+/*
+ * It turns out the crypto hmac(sha256) is hard for us to consume
+ * because it assumes a fixed key and the TPM seems to change the key
+ * on every operation, so we weld the hmac init and final functions in
+ * here to give it the same usage characteristics as a regular hash
+ */
+static void hmac_init(struct sha256_state *sctx, u8 *key, int keylen)
+{
+	u8 pad[SHA256_BLOCK_SIZE];
+	int i;
+
+	sha256_init(sctx);
+	for (i = 0; i < sizeof(pad); i++) {
+		if (i < keylen)
+			pad[i] = key[i];
+		else
+			pad[i] = 0;
+		pad[i] ^= HMAC_IPAD_VALUE;
+	}
+	sha256_update(sctx, pad, sizeof(pad));
+}
+
+static void hmac_final(struct sha256_state *sctx, u8 *key, int keylen, u8 *out)
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
+	sha256_final(sctx, out);
+
+	sha256_init(sctx);
+	sha256_update(sctx, pad, sizeof(pad));
+	sha256_update(sctx, out, SHA256_DIGEST_SIZE);
+	sha256_final(sctx, out);
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
+		struct sha256_state sctx;
+		__be32 c = cpu_to_be32(counter);
+
+		hmac_init(&sctx, key, keylen);
+		sha256_update(&sctx, (u8 *)&c, sizeof(c));
+		sha256_update(&sctx, label, strlen(label)+1);
+		sha256_update(&sctx, u, SHA256_DIGEST_SIZE);
+		sha256_update(&sctx, v, SHA256_DIGEST_SIZE);
+		sha256_update(&sctx, (u8 *)&bits, sizeof(bits));
+		hmac_final(&sctx, key, keylen, out);
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
+	struct sha256_state sctx;
+	/*
+	 * this should be an iterative counter, but because we know
+	 *  we're only taking 32 bytes for the point using a sha256
+	 *  hash which is also 32 bytes, there's only one loop
+	 */
+	__be32 c = cpu_to_be32(1);
+
+	sha256_init(&sctx);
+	/* counter (BE) */
+	sha256_update(&sctx, (u8 *)&c, sizeof(c));
+	/* secret value */
+	sha256_update(&sctx, z, EC_PT_SZ);
+	/* string including trailing zero */
+	sha256_update(&sctx, str, strlen(str)+1);
+	sha256_update(&sctx, pt_u, EC_PT_SZ);
+	sha256_update(&sctx, pt_v, EC_PT_SZ);
+	sha256_final(&sctx, keyout);
+}
+
+static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
+{
+	struct crypto_kpp *kpp;
+	struct kpp_request *req;
+	struct scatterlist s[2], d[1];
+	struct ecdh p = {0};
+	u8 encoded_key[EC_PT_SZ], *x, *y;
+	unsigned int buf_len;
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
+	kpp = crypto_alloc_kpp("ecdh-nist-p256", CRYPTO_ALG_INTERNAL, 0);
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
+	sg_init_one(d, chip->auth->salt, EC_PT_SZ);
+	kpp_request_set_output(req, d, EC_PT_SZ);
+	crypto_kpp_compute_shared_secret(req);
+	kpp_request_free(req);
+
+	/*
+	 * pass the shared secret through KDFe for salt. Note salt
+	 * area is used both for input shared secret and output salt.
+	 * This works because KDFe fully consumes the secret before it
+	 * writes the salt
+	 */
+	KDFe(chip->auth->salt, "SECRET", x, chip->ec_point_x, chip->auth->salt);
+ out:
+	crypto_free_kpp(kpp);
+}
+
+/**
+ * tpm_buf_append_hmac_session() - append a TPM session element
+ * @chip: the TPM chip structure
+ * @buf: The buffer to be appended
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
+void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
+				 u8 attributes, u8 *passphrase,
+				 int passphraselen)
+{
+	u8 nonce[SHA256_DIGEST_SIZE];
+	u32 len;
+	struct tpm2_auth *auth = chip->auth;
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
+ * @chip: the TPM chip structure
+ * @buf: The buffer to be appended
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
+void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
+{
+	u32 cc, handles, val;
+	struct tpm2_auth *auth = chip->auth;
+	int i;
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	off_t offset_s = TPM_HEADER_SIZE, offset_p;
+	u8 *hmac = NULL;
+	u32 attrs;
+	u8 cphash[SHA256_DIGEST_SIZE];
+	struct sha256_state sctx;
+
+	/* save the command code in BE format */
+	auth->ordinal = head->ordinal;
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
+	/*
+	 * just check the names, it's easy to make mistakes.  This
+	 * would happen if someone added a handle via
+	 * tpm_buf_append_u32() instead of tpm_buf_append_name()
+	 */
+	for (i = 0; i < handles; i++) {
+		u32 handle = tpm_buf_read_u32(buf, &offset_s);
+
+		if (auth->name_h[i] != handle) {
+			dev_err(&chip->dev, "TPM: handle %d wrong for name\n",
+				  i);
+			return;
+		}
+	}
+	/* point offset_s to the start of the sessions */
+	val = tpm_buf_read_u32(buf, &offset_s);
+	/* point offset_p to the start of the parameters */
+	offset_p = offset_s + val;
+	for (i = 1; offset_s < offset_p; i++) {
+		u32 handle = tpm_buf_read_u32(buf, &offset_s);
+		u16 len;
+		u8 a;
+
+		/* nonce (already in auth) */
+		len = tpm_buf_read_u16(buf, &offset_s);
+		offset_s += len;
+
+		a = tpm_buf_read_u8(buf, &offset_s);
+
+		len = tpm_buf_read_u16(buf, &offset_s);
+		if (handle == auth->handle && auth->attrs == a) {
+			hmac = &buf->data[offset_s];
+			/*
+			 * save our session number so we know which
+			 * session in the response belongs to us
+			 */
+			auth->session = i;
+		}
+
+		offset_s += len;
+	}
+	if (offset_s != offset_p) {
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
+		u16 len;
+
+		/* need key and IV */
+		KDFa(auth->session_key, SHA256_DIGEST_SIZE
+		     + auth->passphraselen, "CFB", auth->our_nonce,
+		     auth->tpm_nonce, AES_KEYBYTES + AES_BLOCK_SIZE,
+		     auth->scratch);
+
+		len = tpm_buf_read_u16(buf, &offset_p);
+		aes_expandkey(&auth->aes_ctx, auth->scratch, AES_KEYBYTES);
+		aescfb_encrypt(&auth->aes_ctx, &buf->data[offset_p],
+			       &buf->data[offset_p], len,
+			       auth->scratch + AES_KEYBYTES);
+		/* reset p to beginning of parameters for HMAC */
+		offset_p -= 2;
+	}
+
+	sha256_init(&sctx);
+	/* ordinal is already BE */
+	sha256_update(&sctx, (u8 *)&head->ordinal, sizeof(head->ordinal));
+	/* add the handle names */
+	for (i = 0; i < handles; i++) {
+		enum tpm2_mso_type mso = tpm2_handle_mso(auth->name_h[i]);
+
+		if (mso == TPM2_MSO_PERSISTENT ||
+		    mso == TPM2_MSO_VOLATILE ||
+		    mso == TPM2_MSO_NVRAM) {
+			sha256_update(&sctx, auth->name[i],
+				      name_size(auth->name[i]));
+		} else {
+			__be32 h = cpu_to_be32(auth->name_h[i]);
+
+			sha256_update(&sctx, (u8 *)&h, 4);
+		}
+	}
+	if (offset_s != tpm_buf_length(buf))
+		sha256_update(&sctx, &buf->data[offset_s],
+			      tpm_buf_length(buf) - offset_s);
+	sha256_final(&sctx, cphash);
+
+	/* now calculate the hmac */
+	hmac_init(&sctx, auth->session_key, sizeof(auth->session_key)
+		  + auth->passphraselen);
+	sha256_update(&sctx, cphash, sizeof(cphash));
+	sha256_update(&sctx, auth->our_nonce, sizeof(auth->our_nonce));
+	sha256_update(&sctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
+	sha256_update(&sctx, &auth->attrs, 1);
+	hmac_final(&sctx, auth->session_key, sizeof(auth->session_key)
+		   + auth->passphraselen, hmac);
+}
+EXPORT_SYMBOL(tpm_buf_fill_hmac_session);
+
+static int parse_read_public(char *name, struct tpm_buf *buf)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	off_t offset = TPM_HEADER_SIZE;
+	u32 tot_len = be32_to_cpu(head->length);
+	u32 val;
+
+	/* we're starting after the header so adjust the length */
+	tot_len -= TPM_HEADER_SIZE;
+
+	/* skip public */
+	val = tpm_buf_read_u16(buf, &offset);
+	if (val > tot_len)
+		return -EINVAL;
+	offset += val;
+	/* name */
+	val = tpm_buf_read_u16(buf, &offset);
+	if (val != name_size(&buf->data[offset]))
+		return -EINVAL;
+	memcpy(name, &buf->data[offset], val);
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
+		rc = parse_read_public(name, &buf);
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
+/**
+ * tpm_buf_append_name() - add a handle area to the buffer
+ * @chip: the TPM chip structure
+ * @buf: The buffer to be appended
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
+void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
+			 u32 handle, u8 *name)
+{
+	int slot;
+	u8 mso = handle >> 24;
+	struct tpm2_auth *auth = chip->auth;
+
+	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE)/4;
+	if (slot >= AUTH_MAX_NAMES) {
+		dev_err(&chip->dev, "TPM: too many handles\n");
+		return;
+	}
+	WARN(auth->session != tpm_buf_length(buf),
+	     "name added in wrong place\n");
+	tpm_buf_append_u32(buf, handle);
+	auth->session += 4;
+
+	if (mso == 0x81 || mso == 0x80 || mso == 0x01) {
+		if (!name)
+			tpm2_readpublic(chip, handle, auth->name[slot]);
+	} else {
+		if (name)
+			dev_err(&chip->dev, "TPM: Handle does not require name but one is specified\n");
+	}
+
+	auth->name_h[slot] = handle;
+	if (name)
+		memcpy(auth->name[slot], name, name_size(name));
+}
+EXPORT_SYMBOL(tpm_buf_append_name);
+
+/**
+ * tpm_buf_check_hmac_response() - check the TPM return HMAC for correctness
+ * @chip: the TPM chip structure
+ * @buf: the original command buffer (which now contains the response)
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
+int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
+				int rc)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	struct tpm2_auth *auth = chip->auth;
+	off_t offset_s, offset_p;
+	u8 rphash[SHA256_DIGEST_SIZE];
+	u32 attrs;
+	struct sha256_state sctx;
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
+	offset_s = TPM_HEADER_SIZE + handles * 4;
+	parm_len = tpm_buf_read_u32(buf, &offset_s);
+	offset_p = offset_s;
+	offset_s += parm_len;
+	/* skip over any sessions before ours */
+	for (i = 0; i < auth->session - 1; i++) {
+		len = tpm_buf_read_u16(buf, &offset_s);
+		offset_s += len + 1;
+		len = tpm_buf_read_u16(buf, &offset_s);
+		offset_s += len;
+	}
+	/* TPM nonce */
+	len = tpm_buf_read_u16(buf, &offset_s);
+	if (offset_s + len > tpm_buf_length(buf))
+		goto out;
+	if (len != SHA256_DIGEST_SIZE)
+		goto out;
+	memcpy(auth->tpm_nonce, &buf->data[offset_s], len);
+	offset_s += len;
+	attrs = tpm_buf_read_u8(buf, &offset_s);
+	len = tpm_buf_read_u16(buf, &offset_s);
+	if (offset_s + len != tpm_buf_length(buf))
+		goto out;
+	if (len != SHA256_DIGEST_SIZE)
+		goto out;
+	/*
+	 * offset_s points to the HMAC. now calculate comparison, beginning
+	 * with rphash
+	 */
+	sha256_init(&sctx);
+	/* yes, I know this is now zero, but it's what the standard says */
+	sha256_update(&sctx, (u8 *)&head->return_code,
+		      sizeof(head->return_code));
+	/* ordinal is already BE */
+	sha256_update(&sctx, (u8 *)&auth->ordinal, sizeof(auth->ordinal));
+	sha256_update(&sctx, &buf->data[offset_p], parm_len);
+	sha256_final(&sctx, rphash);
+
+	/* now calculate the hmac */
+	hmac_init(&sctx, auth->session_key, sizeof(auth->session_key)
+		  + auth->passphraselen);
+	sha256_update(&sctx, rphash, sizeof(rphash));
+	sha256_update(&sctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
+	sha256_update(&sctx, auth->our_nonce, sizeof(auth->our_nonce));
+	sha256_update(&sctx, &auth->attrs, 1);
+	/* we're done with the rphash, so put our idea of the hmac there */
+	hmac_final(&sctx, auth->session_key, sizeof(auth->session_key)
+		   + auth->passphraselen, rphash);
+	if (memcmp(rphash, &buf->data[offset_s], SHA256_DIGEST_SIZE) == 0) {
+		rc = 0;
+	} else {
+		dev_err(&chip->dev, "TPM: HMAC check failed\n");
+		goto out;
+	}
+
+	/* now do response decryption */
+	if (auth->attrs & TPM2_SA_ENCRYPT) {
+		/* need key and IV */
+		KDFa(auth->session_key, SHA256_DIGEST_SIZE
+		     + auth->passphraselen, "CFB", auth->tpm_nonce,
+		     auth->our_nonce, AES_KEYBYTES + AES_BLOCK_SIZE,
+		     auth->scratch);
+
+		len = tpm_buf_read_u16(buf, &offset_p);
+		aes_expandkey(&auth->aes_ctx, auth->scratch, AES_KEYBYTES);
+		aescfb_decrypt(&auth->aes_ctx, &buf->data[offset_p],
+			       &buf->data[offset_p], len,
+			       auth->scratch + AES_KEYBYTES);
+	}
+
+ out:
+	if ((auth->attrs & TPM2_SA_CONTINUE_SESSION) == 0
+	    && rc)
+		/* manually close the session if it wasn't consumed */
+		tpm2_flush_context(chip, auth->handle);
+
+	/* reset for next use  */
+	auth->session = TPM_HEADER_SIZE;
+
+	return rc;
+}
+EXPORT_SYMBOL(tpm_buf_check_hmac_response);
+
+/**
+ * tpm2_end_auth_session() - kill the allocated auth session
+ * @chip: the TPM chip structure
+ *
+ * ends the session started by tpm2_start_auth_session and frees all
+ * the resources.  Under normal conditions,
+ * tpm_buf_check_hmac_response() will correctly end the session if
+ * required, so this function is only for use in error legs that will
+ * bypass the normal invocation of tpm_buf_check_hmac_respons().
+ */
+void tpm2_end_auth_session(struct tpm_chip *chip)
+{
+	tpm2_flush_context(chip, chip->auth->handle);
+	chip->auth->session = TPM_HEADER_SIZE;
+}
+EXPORT_SYMBOL(tpm2_end_auth_session);
+
+static int parse_start_auth_session(struct tpm2_auth *auth, struct tpm_buf *buf)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	u32 tot_len = be32_to_cpu(head->length);
+	off_t offset = TPM_HEADER_SIZE;
+	u32 val;
+
+	/* we're starting after the header so adjust the length */
+	tot_len -= TPM_HEADER_SIZE;
+
+	/* should have handle plus nonce */
+	if (tot_len != 4 + 2 + sizeof(auth->tpm_nonce))
+		return -EINVAL;
+
+	auth->handle = tpm_buf_read_u32(buf, &offset);
+	val = tpm_buf_read_u16(buf, &offset);
+	if (val != sizeof(auth->tpm_nonce))
+		return -EINVAL;
+	memcpy(auth->tpm_nonce, &buf->data[offset], sizeof(auth->tpm_nonce));
+	/* now compute the session key from the nonces */
+	KDFa(auth->salt, sizeof(auth->salt), "ATH", auth->tpm_nonce,
+	     auth->our_nonce, sizeof(auth->session_key), auth->session_key);
+
+	return 0;
+}
+
+/**
+ * tpm2_start_auth_session() - create a HMAC authentication session with the TPM
+ * @chip: the TPM chip structure to create the session with
+ *
+ * This function loads the NULL seed from its saved context and starts
+ * an authentication session on the null seed, fills in the
+ * @chip->auth structure to contain all the session details necessary
+ * for performing the HMAC, encrypt and decrypt operations and
+ * returns.  The NULL seed is flushed before this function returns.
+ *
+ * Return: zero on success or actual error encountered.
+ */
+int tpm2_start_auth_session(struct tpm_chip *chip)
+{
+	struct tpm_buf buf;
+	struct tpm2_auth *auth = chip->auth;
+	int rc;
+	unsigned int offset = 0; /* dummy offset for null seed context */
+	u32 nullkey;
+
+	rc = tpm2_load_context(chip, chip->tpmkeycontext, &offset,
+			       &nullkey);
+	if (rc)
+		goto out;
+
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
+	tpm_buf_append_salt(&buf, chip);
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
+		rc = parse_start_auth_session(auth, &buf);
+
+	tpm_buf_destroy(&buf);
+
+	if (rc)
+		goto out;
+
+ out:
+	return rc;
+}
+EXPORT_SYMBOL(tpm2_start_auth_session);
+
+static int parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
+				u32 *nullkey)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	off_t offset_r = TPM_HEADER_SIZE, offset_t;
+	u16 len = TPM_HEADER_SIZE;
+	u32 tot_len = be32_to_cpu(head->length);
+	u32 val, parm_len;
+
+	*nullkey = tpm_buf_read_u32(buf, &offset_r);
+	parm_len = tpm_buf_read_u32(buf, &offset_r);
+	/*
+	 * parm_len doesn't include the header, but all the other
+	 * lengths and offsets do, so add it to parm len to make
+	 * the comparisons easier
+	 */
+	parm_len += TPM_HEADER_SIZE;
+
+	if (parm_len + 8 > tot_len)
+		return -EINVAL;
+	len = tpm_buf_read_u16(buf, &offset_r);
+	offset_t = offset_r;
+	/* now we have the public area, compute the name of the object */
+	put_unaligned_be16(TPM_ALG_SHA256, chip->tpmkeyname);
+	sha256(&buf->data[offset_r], len, chip->tpmkeyname + 2);
+
+	/* validate the public key */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	/* key type (must be what we asked for) */
+	if (val != TPM_ALG_ECC)
+		return -EINVAL;
+	val = tpm_buf_read_u16(buf, &offset_t);
+	/* name algorithm */
+	if (val != TPM_ALG_SHA256)
+		return -EINVAL;
+	val = tpm_buf_read_u32(buf, &offset_t);
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
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != 0)
+		return -EINVAL;
+	/* symmetric key parameters */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != TPM_ALG_AES)
+		return -EINVAL;
+	/* symmetric key length */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != AES_KEYBITS)
+		return -EINVAL;
+	/* symmetric encryption scheme */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != TPM_ALG_CFB)
+		return -EINVAL;
+	/* signing scheme */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != TPM_ALG_NULL)
+		return -EINVAL;
+	/* ECC Curve */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != TPM2_ECC_NIST_P256)
+		return -EINVAL;
+	/* KDF Scheme */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != TPM_ALG_NULL)
+		return -EINVAL;
+	/* x point */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != 32)
+		return -EINVAL;
+	memcpy(chip->ec_point_x, &buf->data[offset_t], val);
+	offset_t += val;
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != 32)
+		return -EINVAL;
+	memcpy(chip->ec_point_y, &buf->data[offset_t], val);
+	offset_t += val;
+
+	/* original length of the whole TPM2B */
+	offset_r += len;
+
+	/* should have exactly consumed the TPM2B public structure */
+	if (offset_t != offset_r)
+		return -EINVAL;
+	if (offset_r > parm_len)
+		return -EINVAL;
+	/* creation data (skip) */
+	len = tpm_buf_read_u16(buf, &offset_r);
+	offset_r += len;
+	if (offset_r > parm_len)
+		return -EINVAL;
+	/* creation digest (must be sha256) */
+	len = tpm_buf_read_u16(buf, &offset_r);
+	offset_r += len;
+	if (len != SHA256_DIGEST_SIZE || offset_r > parm_len)
+		return -EINVAL;
+	/* TPMT_TK_CREATION follows */
+	/* tag, must be TPM_ST_CREATION (0x8021) */
+	val = tpm_buf_read_u16(buf, &offset_r);
+	if (val != TPM2_ST_CREATION || offset_r > parm_len)
+		return -EINVAL;
+	/* hierarchy (must be NULL) */
+	val = tpm_buf_read_u32(buf, &offset_r);
+	if (val != TPM2_RH_NULL || offset_r > parm_len)
+		return -EINVAL;
+	/* the ticket digest HMAC (might not be sha256) */
+	len = tpm_buf_read_u16(buf, &offset_r);
+	offset_r += len;
+	if (offset_r > parm_len)
+		return -EINVAL;
+	/*
+	 * finally we have the name, which is a sha256 digest plus a 2
+	 * byte algorithm type
+	 */
+	len = tpm_buf_read_u16(buf, &offset_r);
+	if (offset_r + len != parm_len + 8)
+		return -EINVAL;
+	if (len != SHA256_DIGEST_SIZE + 2)
+		return -EINVAL;
+
+	if (memcmp(chip->tpmkeyname, &buf->data[offset_r],
+		   SHA256_DIGEST_SIZE + 2) != 0) {
+		dev_err(&chip->dev, "NULL Seed name comparison failed\n");
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
+	rc = tpm_buf_init_sized(&template);
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
+	tpm_buf_append_empty_auth(&buf, TPM2_RS_PW);
+	/* sensitive create size is 4 for two empty buffers */
+	tpm_buf_append_u16(&buf, 4);
+	/* sensitive create auth data (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* sensitive create sensitive data (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* the public template */
+	tpm_buf_append(&buf, template.data, template.length);
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
+		rc = parse_create_primary(chip, &buf, handle);
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
+static int tpm2_create_null_primary(struct tpm_chip *chip)
+{
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
+/**
+ * tpm2_sessions_init() - start of day initialization for the sessions code
+ * @chip: TPM chip
+ *
+ * Derive and context save the null primary and allocate memory in the
+ * struct tpm_chip for the authorizations.
+ */
+int tpm2_sessions_init(struct tpm_chip *chip)
+{
+	int rc;
+
+	rc = tpm2_create_null_primary(chip);
+	if (rc)
+		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
+
+	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
+	if (!chip->auth)
+		return -ENOMEM;
+
+	return rc;
+}
+EXPORT_SYMBOL(tpm2_sessions_init);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 6be263509e81..c5de644ad96e 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -30,17 +30,28 @@
 struct tpm_chip;
 struct trusted_key_payload;
 struct trusted_key_options;
+/* opaque structure, holds auth session parameters like the session key */
+struct tpm2_auth;
+
+enum tpm2_session_types {
+	TPM2_SE_HMAC	= 0x00,
+	TPM2_SE_POLICY	= 0x01,
+	TPM2_SE_TRIAL	= 0x02,
+};
 
 /* if you add a new hash to this, increment TPM_MAX_HASHES below */
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
 
 /*
@@ -49,6 +60,11 @@ enum tpm_algorithms {
  */
 #define TPM_MAX_HASHES	5
 
+enum tpm2_curves {
+	TPM2_ECC_NONE		= 0x0000,
+	TPM2_ECC_NIST_P256	= 0x0003,
+};
+
 struct tpm_digest {
 	u16 alg_id;
 	u8 digest[TPM_MAX_DIGEST_SIZE];
@@ -116,6 +132,20 @@ struct tpm_chip_seqops {
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
+#define TPM2_MAX_CONTEXT_SIZE 4096
+
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
@@ -170,6 +200,15 @@ struct tpm_chip {
 
 	/* active locality */
 	int locality;
+
+#ifdef CONFIG_TPM_BUS_SECURITY
+	/* details for communication security via sessions */
+	u8 tpmkeycontext[TPM2_MAX_CONTEXT_SIZE]; /* context for NULL seed */
+	u8 tpmkeyname[TPM2_NAME_SIZE];		 /* name of NULL seed */
+	u8 ec_point_x[EC_PT_SZ];
+	u8 ec_point_y[EC_PT_SZ];
+	struct tpm2_auth *auth;
+#endif
 };
 
 #define TPM_HEADER_SIZE		10
@@ -194,6 +233,7 @@ enum tpm2_timeouts {
 enum tpm2_structures {
 	TPM2_ST_NO_SESSIONS	= 0x8001,
 	TPM2_ST_SESSIONS	= 0x8002,
+	TPM2_ST_CREATION	= 0x8021,
 };
 
 /* Indicates from what layer of the software stack the error comes from */
@@ -231,6 +271,10 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_POLICY_AUTHVALUE	= 0x016B,
+	TPM2_CC_POLICY_COUNTER_TIMER	= 0x016D,
+	TPM2_CC_READ_PUBLIC		= 0x0173,
+	TPM2_CC_START_AUTH_SESS		= 0x0176,
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
 	TPM2_CC_GET_CAPABILITY	        = 0x017A,
 	TPM2_CC_GET_RANDOM	        = 0x017B,
@@ -243,9 +287,25 @@ enum tpm2_command_codes {
 };
 
 enum tpm2_permanent_handles {
+	TPM2_RH_NULL		= 0x40000007,
 	TPM2_RS_PW		= 0x40000009,
 };
 
+/* Most Significant Octet for key types  */
+enum tpm2_mso_type {
+	TPM2_MSO_NVRAM		= 0x01,
+	TPM2_MSO_SESSION	= 0x02,
+	TPM2_MSO_POLICY		= 0x03,
+	TPM2_MSO_PERMANENT	= 0x40,
+	TPM2_MSO_VOLATILE	= 0x80,
+	TPM2_MSO_PERSISTENT	= 0x81,
+};
+
+static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
+{
+	return handle >> 24;
+}
+
 enum tpm2_capabilities {
 	TPM2_CAP_HANDLES	= 1,
 	TPM2_CAP_COMMANDS	= 2,
@@ -313,16 +373,30 @@ struct tpm_buf {
 	u32 flags;
 	u32 length;
 	u8 *data;
+	u8 handles;
 };
 
 enum tpm2_object_attributes {
 	TPM2_OA_FIXED_TPM		= BIT(1),
+	TPM2_OA_ST_CLEAR		= BIT(2),
 	TPM2_OA_FIXED_PARENT		= BIT(4),
+	TPM2_OA_SENSITIVE_DATA_ORIGIN	= BIT(5),
 	TPM2_OA_USER_WITH_AUTH		= BIT(6),
+	TPM2_OA_ADMIN_WITH_POLICY	= BIT(7),
+	TPM2_OA_NO_DA			= BIT(10),
+	TPM2_OA_ENCRYPTED_DUPLICATION	= BIT(11),
+	TPM2_OA_RESTRICTED		= BIT(16),
+	TPM2_OA_DECRYPT			= BIT(17),
+	TPM2_OA_SIGN			= BIT(18),
 };
 
 enum tpm2_session_attributes {
 	TPM2_SA_CONTINUE_SESSION	= BIT(0),
+	TPM2_SA_AUDIT_EXCLUSIVE		= BIT(1),
+	TPM2_SA_AUDIT_RESET		= BIT(3),
+	TPM2_SA_DECRYPT			= BIT(5),
+	TPM2_SA_ENCRYPT			= BIT(6),
+	TPM2_SA_AUDIT			= BIT(7),
 };
 
 struct tpm2_hash {
@@ -373,6 +447,15 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
+static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
+{
+	/* simple authorization for empty auth */
+	tpm_buf_append_u32(buf, 9);		/* total length of auth */
+	tpm_buf_append_u32(buf, handle);
+	tpm_buf_append_u16(buf, 0);		/* nonce len */
+	tpm_buf_append_u8(buf, 0);		/* attributes */
+	tpm_buf_append_u16(buf, 0);		/* hmac len */
+}
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
@@ -399,5 +482,102 @@ static inline struct tpm_chip *tpm_default_chip(void)
 {
 	return NULL;
 }
+
+static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
+{
+}
 #endif
+#ifdef CONFIG_TPM_BUS_SECURITY
+
+int tpm2_start_auth_session(struct tpm_chip *chip);
+void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
+			 u32 handle, u8 *name);
+void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
+				 u8 attributes, u8 *passphrase,
+				 int passphraselen);
+static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
+						   struct tpm_buf *buf,
+						   u8 attributes,
+						   u8 *passphrase,
+						   int passphraselen)
+{
+	tpm_buf_append_hmac_session(chip, buf, attributes, passphrase,
+				    passphraselen);
+}
+void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
+int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
+				int rc);
+void tpm2_end_auth_session(struct tpm_chip *chip);
+#else
+#include <asm/unaligned.h>
+
+static inline int tpm2_start_auth_session(struct tpm_chip *chip)
+{
+	return 0;
+}
+static inline void tpm2_end_auth_session(struct tpm_chip *chip)
+{
+}
+static inline void tpm_buf_append_name(struct tpm_chip *chip,
+				       struct tpm_buf *buf,
+				       u32 handle, u8 *name)
+{
+	tpm_buf_append_u32(buf, handle);
+	/* count the number of handles in the upper bits of flags */
+	buf->handles++;
+}
+static inline void tpm_buf_append_hmac_session(struct tpm_chip *chip,
+					       struct tpm_buf *buf,
+					       u8 attributes, u8 *passphrase,
+					       int passphraselen)
+{
+	/* offset tells us where the sessions area begins */
+	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+	u32 len = 9 + passphraselen;
+
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
+static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
+						   struct tpm_buf *buf,
+						   u8 attributes,
+						   u8 *passphrase,
+						   int passphraselen)
+{
+	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+	struct tpm_header *head = (struct tpm_header *) buf->data;
+
+	/*
+	 * if the only sessions are optional, the command tag
+	 * must change to TPM2_ST_NO_SESSIONS
+	 */
+	if (tpm_buf_length(buf) == offset)
+		head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+}
+static inline void tpm_buf_fill_hmac_session(struct tpm_chip *chip,
+					     struct tpm_buf *buf)
+{
+}
+static inline int tpm_buf_check_hmac_response(struct tpm_chip *chip,
+					      struct tpm_buf *buf,
+					      int rc)
+{
+	return rc;
+}
+#endif	/* CONFIG_TPM_BUS_SECURITY */
+
 #endif
-- 
2.35.3


