Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13D328998F
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Oct 2020 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390476AbgJIUOg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Oct 2020 16:14:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:30370 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgJIUOd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Oct 2020 16:14:33 -0400
IronPort-SDR: y8cB7gOgZFTtEciIitUdVGFi06OWUEGdzOl2y+/bPNW/paHEVV5MZ1USP3cb7UFa6PoY7qzOCB
 JLo6dBanSBzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="165645696"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="165645696"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:14:31 -0700
IronPort-SDR: jgQsFRAlfHBo80EaDq6UUpsPxAnTNwwEcXCneOQBX38JCbGEvK/O3QEXBqd2evdiIGuqrrbxaD
 ++KTSJnvkkLQ==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="519852282"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:14:31 -0700
From:   ira.weiny@intel.com
To:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-integrity@vger.kernel.org (open list:KEYS-TRUSTED),
        keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH RFC PKS/Trusted keys 2/2] keys/trusted: protect trusted keys using PKS
Date:   Fri,  9 Oct 2020 13:14:10 -0700
Message-Id: <20201009201410.3209180-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009201410.3209180-1-ira.weiny@intel.com>
References: <20201009201410.3209180-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Elena Reshetova <elena.reshetova@intel.com>

Enable additional protection for trusted keys against arbitrary reads
using Protection Keys Supervisor (PKS) feature on architectures which
support it.  PKS feature allows different 'domains' of page mappings
which have an extra level of protection beyond those specified in the
supervisor page table entries. Pages can be placed into such a 'domain'
upon allocation and the access to them is enforced based on the
per-thread per-CPU granularity.

The PKS protection 'domain' is acquired upon TPM initialization and, if
successful, will be used to limit access (both read and write) to pages
containing trusted key plaintext buffer. When a legitimate operation needs
to be performed on this buffer, the access to it is temporally enabled
for a particular thread on a particular CPU.

This is not a perfect solution, but a first step towards providing an
additional protection for the trusted keys residing in the kernel
memory.  Currently, it still does not prevent direct map aliased
attacks, i.e.  when the page with the key content is accessed via the
kernel direct map directly.  In order to address this concern, future
work could utilize PKS in secretmem[1] and/or secretment in trusted
keys.  For this patch, we are focused on just using PKS to remove the
non-direct map alias access to this key data when not needed.

In order to limit access to the pages containing the trusted key
plaintext buffer, trusted_key_enable/disable_access functions are used.
The "disable" function removes access (both read and write) to the pages
allocated for the trusted keys PKS 'domain' on a given CPU and for the
given thread, and the "enable" one enables read and write access on a
given CPU and for the given thread. By default the access to the trusted
keys PKS 'domain' is disabled for all threads on all CPUs.

[1] https://lore.kernel.org/linux-mm/20200924132904.1391-1-rppt@kernel.org/

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/keys/trusted-type.h               |  2 +-
 include/keys/trusted_tpm.h                | 15 ++++
 security/keys/encrypted-keys/encrypted.c  | 38 +++++++---
 security/keys/trusted-keys/trusted_tpm1.c | 90 ++++++++++++++++++++---
 security/keys/trusted-keys/trusted_tpm2.c |  9 +++
 5 files changed, 131 insertions(+), 23 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index a94c03a61d8f..826525e22b45 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -22,7 +22,7 @@ struct trusted_key_payload {
 	unsigned int key_len;
 	unsigned int blob_len;
 	unsigned char migratable;
-	unsigned char key[MAX_KEY_SIZE + 1];
+	unsigned char  *key;
 	unsigned char blob[MAX_BLOB_SIZE];
 };
 
diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index a56d8e1298f2..5aa254c70820 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -47,6 +47,21 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 			struct trusted_key_payload *payload,
 			struct trusted_key_options *options);
 
+#if defined(CONFIG_TRUSTED_KEYS) || \
+	(defined(CONFIG_TRUSTED_KEYS_MODULE) && defined(CONFIG_ENCRYPTED_KEYS_MODULE))
+void trusted_key_enable_access(void);
+void trusted_key_disable_access(void);
+#else
+static inline void trusted_key_enable_access(void)
+{
+
+}
+static inline void trusted_key_disable_access(void)
+{
+
+}
+#endif
+
 #define TPM_DEBUG 0
 
 #if TPM_DEBUG
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 192e531c146f..d996e9fd2dec 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <keys/user-type.h>
 #include <keys/trusted-type.h>
+#include <keys/trusted_tpm.h>
 #include <keys/encrypted-type.h>
 #include <linux/key-type.h>
 #include <linux/random.h>
@@ -344,10 +345,12 @@ static int calc_hmac(u8 *digest, const u8 *key, unsigned int keylen,
 }
 
 enum derived_key_type { ENC_KEY, AUTH_KEY };
+enum master_key_type { TRUSTED_KEY, USER_KEY };
 
 /* Derive authentication/encryption key from trusted key */
 static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
-			   const u8 *master_key, size_t master_keylen)
+			   const u8 *master_key, size_t master_keylen,
+			   enum master_key_type m_key_type)
 {
 	u8 *derived_buf;
 	unsigned int derived_buf_len;
@@ -366,8 +369,13 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
 	else
 		strcpy(derived_buf, "ENC_KEY");
 
+	if (unlikely(m_key_type == TRUSTED_KEY))
+		trusted_key_enable_access();
 	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
 	       master_keylen);
+	if (unlikely(m_key_type == TRUSTED_KEY))
+		trusted_key_disable_access();
+
 	ret = crypto_shash_tfm_digest(hash_tfm, derived_buf, derived_buf_len,
 				      derived_key);
 	kfree_sensitive(derived_buf);
@@ -408,7 +416,8 @@ static struct skcipher_request *init_skcipher_req(const u8 *key,
 }
 
 static struct key *request_master_key(struct encrypted_key_payload *epayload,
-				      const u8 **master_key, size_t *master_keylen)
+				      const u8 **master_key, size_t *master_keylen,
+				      enum master_key_type *m_key_type)
 {
 	struct key *mkey = ERR_PTR(-EINVAL);
 
@@ -417,11 +426,13 @@ static struct key *request_master_key(struct encrypted_key_payload *epayload,
 		mkey = request_trusted_key(epayload->master_desc +
 					   KEY_TRUSTED_PREFIX_LEN,
 					   master_key, master_keylen);
+		*m_key_type = TRUSTED_KEY;
 	} else if (!strncmp(epayload->master_desc, KEY_USER_PREFIX,
 			    KEY_USER_PREFIX_LEN)) {
 		mkey = request_user_key(epayload->master_desc +
 					KEY_USER_PREFIX_LEN,
 					master_key, master_keylen);
+		*m_key_type = USER_KEY;
 	} else
 		goto out;
 
@@ -486,13 +497,14 @@ static int derived_key_encrypt(struct encrypted_key_payload *epayload,
 }
 
 static int datablob_hmac_append(struct encrypted_key_payload *epayload,
-				const u8 *master_key, size_t master_keylen)
+				const u8 *master_key, size_t master_keylen,
+				enum master_key_type m_key_type)
 {
 	u8 derived_key[HASH_SIZE];
 	u8 *digest;
 	int ret;
 
-	ret = get_derived_key(derived_key, AUTH_KEY, master_key, master_keylen);
+	ret = get_derived_key(derived_key, AUTH_KEY, master_key, master_keylen, m_key_type);
 	if (ret < 0)
 		goto out;
 
@@ -509,7 +521,7 @@ static int datablob_hmac_append(struct encrypted_key_payload *epayload,
 /* verify HMAC before decrypting encrypted key */
 static int datablob_hmac_verify(struct encrypted_key_payload *epayload,
 				const u8 *format, const u8 *master_key,
-				size_t master_keylen)
+				size_t master_keylen, enum master_key_type m_key_type)
 {
 	u8 derived_key[HASH_SIZE];
 	u8 digest[HASH_SIZE];
@@ -517,7 +529,7 @@ static int datablob_hmac_verify(struct encrypted_key_payload *epayload,
 	char *p;
 	unsigned short len;
 
-	ret = get_derived_key(derived_key, AUTH_KEY, master_key, master_keylen);
+	ret = get_derived_key(derived_key, AUTH_KEY, master_key, master_keylen, m_key_type);
 	if (ret < 0)
 		goto out;
 
@@ -664,6 +676,7 @@ static int encrypted_key_decrypt(struct encrypted_key_payload *epayload,
 	size_t master_keylen;
 	size_t asciilen;
 	int ret;
+	enum master_key_type m_key_type;
 
 	encrypted_datalen = roundup(epayload->decrypted_datalen, blksize);
 	asciilen = (ivsize + 1 + encrypted_datalen + HASH_SIZE) * 2;
@@ -685,17 +698,17 @@ static int encrypted_key_decrypt(struct encrypted_key_payload *epayload,
 	if (ret < 0)
 		return -EINVAL;
 
-	mkey = request_master_key(epayload, &master_key, &master_keylen);
+	mkey = request_master_key(epayload, &master_key, &master_keylen, &m_key_type);
 	if (IS_ERR(mkey))
 		return PTR_ERR(mkey);
 
-	ret = datablob_hmac_verify(epayload, format, master_key, master_keylen);
+	ret = datablob_hmac_verify(epayload, format, master_key, master_keylen, m_key_type);
 	if (ret < 0) {
 		pr_err("encrypted_key: bad hmac (%d)\n", ret);
 		goto out;
 	}
 
-	ret = get_derived_key(derived_key, ENC_KEY, master_key, master_keylen);
+	ret = get_derived_key(derived_key, ENC_KEY, master_key, master_keylen, m_key_type);
 	if (ret < 0)
 		goto out;
 
@@ -908,6 +921,7 @@ static long encrypted_read(const struct key *key, char *buffer,
 	char *ascii_buf;
 	size_t asciiblob_len;
 	int ret;
+	enum master_key_type m_key_type;
 
 	epayload = dereference_key_locked(key);
 
@@ -919,11 +933,11 @@ static long encrypted_read(const struct key *key, char *buffer,
 	if (!buffer || buflen < asciiblob_len)
 		return asciiblob_len;
 
-	mkey = request_master_key(epayload, &master_key, &master_keylen);
+	mkey = request_master_key(epayload, &master_key, &master_keylen, &m_key_type);
 	if (IS_ERR(mkey))
 		return PTR_ERR(mkey);
 
-	ret = get_derived_key(derived_key, ENC_KEY, master_key, master_keylen);
+	ret = get_derived_key(derived_key, ENC_KEY, master_key, master_keylen, m_key_type);
 	if (ret < 0)
 		goto out;
 
@@ -931,7 +945,7 @@ static long encrypted_read(const struct key *key, char *buffer,
 	if (ret < 0)
 		goto out;
 
-	ret = datablob_hmac_append(epayload, master_key, master_keylen);
+	ret = datablob_hmac_append(epayload, master_key, master_keylen, m_key_type);
 	if (ret < 0)
 		goto out;
 
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index b9fe02e5f84f..62e6c5eb8e2b 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -26,9 +26,49 @@
 #include <linux/capability.h>
 #include <linux/tpm.h>
 #include <linux/tpm_command.h>
+#include <linux/pkeys.h>
+#include <linux/vmalloc.h>
+#include <uapi/asm-generic/mman-common.h>
 
 #include <keys/trusted_tpm.h>
 
+#define PKEY_INVALID (INT_MIN)
+static int trusted_keys_pkey = PKEY_INVALID;
+
+#if defined(CONFIG_TRUSTED_KEYS) || \
+	(defined(CONFIG_TRUSTED_KEYS_MODULE) && defined(CONFIG_ENCRYPTED_KEYS_MODULE))
+void trusted_key_disable_access(void)
+{
+	if (trusted_keys_pkey == PKEY_INVALID)
+		return;
+
+	pks_mknoaccess(trusted_keys_pkey, false);
+
+}
+EXPORT_SYMBOL_GPL(trusted_key_disable_access);
+
+void trusted_key_enable_access(void)
+{
+	if (trusted_keys_pkey == PKEY_INVALID)
+		return;
+
+	pks_mkrdwr(trusted_keys_pkey, false);
+}
+EXPORT_SYMBOL_GPL(trusted_key_enable_access);
+#endif
+
+static void trusted_payload_free(struct trusted_key_payload *p)
+{
+	if (!p)
+		return;
+
+	trusted_key_enable_access();
+	memzero_explicit(p->key, MAX_KEY_SIZE + 1);
+	trusted_key_disable_access();
+	vfree(p->key);
+	kzfree(p);
+}
+
 static const char hmac_alg[] = "hmac(sha1)";
 static const char hash_alg[] = "sha1";
 static struct tpm_chip *chip;
@@ -663,12 +703,15 @@ static int key_seal(struct trusted_key_payload *p,
 	if (ret)
 		return ret;
 
+	trusted_key_enable_access();
 	/* include migratable flag at end of sealed key */
 	p->key[p->key_len] = p->migratable;
 
 	ret = tpm_seal(&tb, o->keytype, o->keyhandle, o->keyauth,
 		       p->key, p->key_len + 1, p->blob, &p->blob_len,
 		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
+	trusted_key_disable_access();
+
 	if (ret < 0)
 		pr_info("trusted_key: srkseal failed (%d)\n", ret);
 
@@ -689,6 +732,7 @@ static int key_unseal(struct trusted_key_payload *p,
 	if (ret)
 		return ret;
 
+	trusted_key_enable_access();
 	ret = tpm_unseal(&tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
 			 o->blobauth, p->key, &p->key_len);
 	if (ret < 0)
@@ -696,6 +740,7 @@ static int key_unseal(struct trusted_key_payload *p,
 	else
 		/* pull migratable flag out of sealed key */
 		p->migratable = p->key[--p->key_len];
+	trusted_key_disable_access();
 
 	tpm_buf_destroy(&tb);
 	return ret;
@@ -928,15 +973,26 @@ static struct trusted_key_options *trusted_options_alloc(void)
 
 static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
 {
-	struct trusted_key_payload *p = NULL;
+	struct trusted_key_payload *p;
 	int ret;
 
 	ret = key_payload_reserve(key, sizeof *p);
 	if (ret < 0)
-		return p;
+		return NULL;
 	p = kzalloc(sizeof *p, GFP_KERNEL);
-	if (p)
+	if (p) {
 		p->migratable = 1; /* migratable by default */
+		if (trusted_keys_pkey == PKEY_INVALID)
+			p->key = vmalloc(MAX_KEY_SIZE + 1);
+		else
+			p->key = vmalloc_pks(MAX_KEY_SIZE + 1, trusted_keys_pkey);
+
+		if (!(p->key)) {
+			kfree(p);
+			return NULL;
+		}
+	}
+
 	return p;
 }
 
@@ -1012,7 +1068,9 @@ static int trusted_instantiate(struct key *key,
 		break;
 	case Opt_new:
 		key_len = payload->key_len;
+		trusted_key_enable_access();
 		ret = tpm_get_random(chip, payload->key, key_len);
+		trusted_key_disable_access();
 		if (ret != key_len) {
 			pr_info("trusted_key: key_create failed (%d)\n", ret);
 			goto out;
@@ -1036,7 +1094,7 @@ static int trusted_instantiate(struct key *key,
 	if (!ret)
 		rcu_assign_keypointer(key, payload);
 	else
-		kfree_sensitive(payload);
+		trusted_payload_free(payload);
 	return ret;
 }
 
@@ -1045,7 +1103,7 @@ static void trusted_rcu_free(struct rcu_head *rcu)
 	struct trusted_key_payload *p;
 
 	p = container_of(rcu, struct trusted_key_payload, rcu);
-	kfree_sensitive(p);
+	trusted_payload_free(p);
 }
 
 /*
@@ -1087,34 +1145,38 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	ret = datablob_parse(datablob, new_p, new_o);
 	if (ret != Opt_update) {
 		ret = -EINVAL;
-		kfree_sensitive(new_p);
+		trusted_payload_free(new_p);
 		goto out;
 	}
 
 	if (!new_o->keyhandle) {
 		ret = -EINVAL;
-		kfree_sensitive(new_p);
+		trusted_payload_free(new_p);
 		goto out;
 	}
 
 	/* copy old key values, and reseal with new pcrs */
 	new_p->migratable = p->migratable;
 	new_p->key_len = p->key_len;
+
+	trusted_key_enable_access();
 	memcpy(new_p->key, p->key, p->key_len);
+	trusted_key_disable_access();
+
 	dump_payload(p);
 	dump_payload(new_p);
 
 	ret = key_seal(new_p, new_o);
 	if (ret < 0) {
 		pr_info("trusted_key: key_seal failed (%d)\n", ret);
-		kfree_sensitive(new_p);
+		trusted_payload_free(new_p);
 		goto out;
 	}
 	if (new_o->pcrlock) {
 		ret = pcrlock(new_o->pcrlock);
 		if (ret < 0) {
 			pr_info("trusted_key: pcrlock failed (%d)\n", ret);
-			kfree_sensitive(new_p);
+			trusted_payload_free(new_p);
 			goto out;
 		}
 	}
@@ -1219,7 +1281,7 @@ static int __init init_digests(void)
 
 static int __init init_trusted(void)
 {
-	int ret;
+	int ret, key_id;
 
 	/* encrypted_keys.ko depends on successful load of this module even if
 	 * TPM is not used.
@@ -1237,6 +1299,14 @@ static int __init init_trusted(void)
 	ret = register_key_type(&key_type_trusted);
 	if (ret < 0)
 		goto err_release;
+
+	/* Attempt to reserve a PKS key for protecting the trusted keys.
+	 * Note the pkey is never free'ed. This is run at init time and
+	 * we either get the key or we do not.
+	 */
+	key_id = pks_key_alloc("Keyring Trusted Keys");
+	if (key_id >= 0)
+		trusted_keys_pkey = key_id;
 	return 0;
 err_release:
 	trusted_shash_release();
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 08ec7f48f01d..67281394523f 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -8,6 +8,8 @@
 #include <linux/err.h>
 #include <linux/tpm.h>
 #include <linux/tpm_command.h>
+#include <linux/pkeys.h>
+#include <uapi/asm-generic/mman-common.h>
 
 #include <keys/trusted-type.h>
 #include <keys/trusted_tpm.h>
@@ -96,7 +98,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
 	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
 	tpm_buf_append_u16(&buf, payload->key_len + 1);
+
+	trusted_key_enable_access();
 	tpm_buf_append(&buf, payload->key, payload->key_len);
+	trusted_key_disable_access();
+
 	tpm_buf_append_u8(&buf, payload->migratable);
 
 	/* public */
@@ -278,7 +284,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		}
 		data = &buf.data[TPM_HEADER_SIZE + 6];
 
+		trusted_key_enable_access();
 		memcpy(payload->key, data, data_len - 1);
+		trusted_key_disable_access();
+
 		payload->key_len = data_len - 1;
 		payload->migratable = data[data_len - 1];
 	}
-- 
2.28.0.rc0.12.gb6a658bd00c9

