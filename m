Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8421368AF
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jun 2019 02:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFFAQ4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 20:16:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35750 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFFAQ4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 20:16:56 -0400
Received: from [10.200.157.26] (unknown [131.107.160.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 11D0420B464C;
        Wed,  5 Jun 2019 17:16:54 -0700 (PDT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jordan Hand <jorhand@linux.microsoft.com>
From:   Lakshmi <nramas@linux.microsoft.com>
Subject: [PATCH 2/2] [IMA] Measure public keys of BuiltIn Trusted Keys
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>
Message-ID: <a612d6ff-3e90-f278-bd7b-cb0f47d5f4d3@linux.microsoft.com>
Date:   Wed, 5 Jun 2019 17:16:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

During IMA initialization, the keys in "BuiltIn Trusted Keys" will be
enumerated and public key of those keys and key description will be
extracted, and measured to IMA log.
"[PATCH 1/2] [IMA] Measure public keys of BuiltIn Trusted Keys -
Query public key of given key" will be used here.

An attestation service will validate that the client machine had
only known good\trusted keys in its "Trusted Keys" keyring.
Note that the attestation service will receive the list of
"Trusted Keys" from a trustworthy source (which is different from the
client machines that are being attested). Attesting the "Trusted Keys"
in turn attests the "IMA Signer Key(s)" that were used on the client.

Signed-off-by: Lakshmi <nramas@microsoft.com>
---
  certs/system_keyring.c            |  7 +++
  include/keys/system_keyring.h     |  9 ++++
  include/linux/key.h               | 32 ++++++++++++
  security/integrity/digsig.c       | 58 ++++++++++++++++++++++
  security/integrity/ima/Kconfig    |  9 ++++
  security/integrity/ima/ima_init.c | 62 +++++++++++++++++++++++
  security/integrity/integrity.h    | 25 ++++++++++
  security/keys/keyring.c           | 82 +++++++++++++++++++++++++++++++
  8 files changed, 284 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index c05c29ae4d5d..fc7147db4222 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -287,3 +287,10 @@ void __init set_platform_trusted_keys(struct key 
*keyring)
  	platform_trusted_keys = keyring;
  }
  #endif
+
+#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
+struct key *get_builtin_trusted_keys(void)
+{
+	return builtin_trusted_keys;
+}
+#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 42a93eda331c..0378355513a9 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -70,4 +70,13 @@ static inline void set_platform_trusted_keys(struct 
key *keyring)
  }
  #endif

+#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
+extern struct key *get_builtin_trusted_keys(void);
+#else
+static struct key *get_builtin_trusted_keys(void)
+{
+	return NULL;
+}
+#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */
+
  #endif /* _KEYS_SYSTEM_KEYRING_H */
diff --git a/include/linux/key.h b/include/linux/key.h
index 7099985e35a9..3afcc26fa4dc 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -349,6 +349,38 @@ extern void key_set_timeout(struct key *, unsigned);
  extern key_ref_t lookup_user_key(key_serial_t id, unsigned long flags,
  				 key_perm_t perm);

+/*
+ * Context data used to iterate through the keys in a keyring
+ * and read the key references into an array.
+ *
+ *  keyring_keys_count - Number of keys in keyring_keys array
+ *  keyring_keys_size - Max number of keys in keyring_keys array
+ *  keyring_keys - Array containing keys read from the keyring
+ */
+struct keyring_keys_read_context {
+	size_t keyring_keys_size;
+	size_t keyring_keys_count;
+	const struct key *keyring_keys[0];
+};
+
+#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
+extern long keyring_read_keys(const struct key *keyring,
+				struct keyring_keys_read_context **ctx);
+extern long keyring_read_builtin_trusted_keys(
+				struct keyring_keys_read_context **ctx);
+#else
+static inline long keyring_read_keys(const struct key *keyring,
+			 struct keyring_keys_read_context **ctx)
+{
+	return -EOPNOTSUPP;
+}
+static inline long keyring_read_builtin_trusted_keys(
+	struct keyring_keys_read_context **ctx)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */
+
  /*
   * The permissions required on a key that we're looking up.
   */
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e19c2eb72c51..7e0423478d30 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -179,3 +179,61 @@ int __init integrity_load_cert(const unsigned int 
id, const char *source,
  	pr_info("Loading X.509 certificate: %s\n", source);
  	return integrity_add_key(id, data, len, perm);
  }
+
+#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
+static int __init store_trusted_keyring_keys(
+			struct keyring_keys_read_context *ctx,
+			int (*store_trusted_key)(
+				void *key,
+				u32 keylen,
+				const char *key_description))
+{
+	int rc = 0;
+	size_t inx;
+
+	for (inx = 0; inx < ctx->keyring_keys_count; inx++) {
+		const struct key *trusted_key = ctx->keyring_keys[inx];
+		const struct public_key *pk;
+
+		pk = query_public_key(trusted_key);
+		if (pk != NULL) {
+			rc = store_trusted_key(pk->key, pk->keylen,
+						trusted_key->description);
+
+			if (rc < 0)
+				break;
+		}
+	}
+
+	return rc;
+}
+
+int __init ima_add_trusted_keyring_keys(int (*store_trusted_key)(
+			void *key,
+			u32 keylen,
+			const char *key_description))
+{
+	struct keyring_keys_read_context *ctx = NULL;
+	int rc;
+
+	// First measure keys from "BuiltIn_Trusted_Keys" keyring
+	rc = keyring_read_builtin_trusted_keys(&ctx);
+	if (rc < 0)
+		return rc;
+	store_trusted_keyring_keys(ctx, store_trusted_key);
+	kfree(ctx);
+	ctx = NULL;
+
+	// Next measure keys from IMA keyring
+	if (keyring[INTEGRITY_KEYRING_IMA]) {
+		rc = keyring_read_keys(keyring[INTEGRITY_KEYRING_IMA], &ctx);
+		if (rc < 0)
+			return rc;
+		store_trusted_keyring_keys(ctx, store_trusted_key);
+		kfree(ctx);
+		ctx = NULL;
+	}
+
+	return 0;
+}
+#endif
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index a18f8c6d13b5..4c1f1a794a6c 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -295,3 +295,12 @@ config IMA_APPRAISE_SIGNED_INIT
  	default n
  	help
  	   This option requires user-space init to be signed.
+
+config IMA_MEASURE_TRUSTED_KEYS
+	bool "Measure the public keys of trusted keys"
+	depends on IMA
+	default n
+	help
+	   This option enables keys in keyrings such as
+	   Builtin Trusted Keys, IMA, Platform, etc. to
+	   be measured during IMA initialization
diff --git a/security/integrity/ima/ima_init.c 
b/security/integrity/ima/ima_init.c
index 6c9295449751..4ad0cf4825b8 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -93,6 +93,61 @@ static int __init ima_add_boot_aggregate(void)
  	return result;
  }

+#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
+int __init store_trusted_keyring_key(void *key,
+					u32 keylen, const char *key_description)
+{
+	static const char op[] = "store_trusted_keyring_key";
+	const char *audit_cause = "ENOMEM";
+	struct ima_template_entry *entry;
+	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
+	struct ima_event_data event_data = {iint, NULL, key_description,
+					    NULL, 0, NULL};
+	int result = -ENOMEM;
+	int violation = 0;
+	struct {
+		struct ima_digest_data hdr;
+		char digest[TPM_DIGEST_SIZE];
+	} hash;
+
+	if (key == NULL || keylen == 0)
+		return 0;
+
+	memset(iint, 0, sizeof(*iint));
+	memset(&hash, 0, sizeof(hash));
+	iint->ima_hash = &hash.hdr;
+	iint->ima_hash->algo = HASH_ALGO_SHA1;
+	iint->ima_hash->length = SHA1_DIGEST_SIZE;
+
+	result = ima_calc_buffer_hash(key, keylen, &hash.hdr);
+	if (result < 0) {
+		audit_cause = "hashing_error";
+		goto err_out;
+	}
+
+	result = ima_alloc_init_template(&event_data, &entry);
+	if (result < 0) {
+		audit_cause = "alloc_entry";
+		goto err_out;
+	}
+
+	result = ima_store_template(entry, violation, NULL,
+					key_description,
+					CONFIG_IMA_MEASURE_PCR_IDX);
+	if (result < 0) {
+		ima_free_template_entry(entry);
+		audit_cause = "store_entry";
+		goto err_out;
+	}
+	return 0;
+err_out:
+	integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
+				key_description, op,
+				audit_cause, result, 0);
+	return result;
+}
+#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */
+
  #ifdef CONFIG_IMA_LOAD_X509
  void __init ima_load_x509(void)
  {
@@ -133,6 +188,13 @@ int __init ima_init(void)
  	if (rc != 0)
  		return rc;

+#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
+	/* Measure keys from trusted keyrings */
+	rc = ima_add_trusted_keyring_keys(store_trusted_keyring_key);
+	if (rc != 0)
+		return rc;
+#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */
+
  	ima_init_policy();

  	return ima_fs_init();
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7de59f44cba3..050edde06fcf 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -242,3 +242,28 @@ static inline void __init 
add_to_platform_keyring(const char *source,
  {
  }
  #endif
+
+#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
+int __init ima_add_trusted_keyring_keys(int (*store_trusted_key)(
+			void *key,
+			u32 keylen,
+			const char *key_description));
+
+int __init store_trusted_keyring_key(void *key,
+					u32 keylen,
+					const char *key_description);
+#else
+static int __init ima_add_trusted_keyring_keys(int (*store_trusted_key)(
+			void *key,
+			u32 keylen,
+			const char *key_description))
+{
+	return -EOPNOTSUPP;
+}
+static int __init store_trusted_keyring_key(void *key,
+					u32 keylen,
+					const char *key_description)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index e14f09e3a4b0..37865ff2b234 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -20,6 +20,7 @@
  #include <keys/user-type.h>
  #include <linux/assoc_array_priv.h>
  #include <linux/uaccess.h>
+#include <keys/system_keyring.h>
  #include "internal.h"

  /*
@@ -1583,3 +1584,84 @@ void keyring_restriction_gc(struct key *keyring, 
struct key_type *dead_type)

  	kleave(" [restriction gc]");
  }
+
+#ifdef CONFIG_IMA_MEASURE_TRUSTED_KEYS
+static int keyring_keys_iterator(const void *object, void *data)
+{
+	struct keyring_keys_read_context *ctx = data;
+	const struct key *key = keyring_ptr_to_key(object);
+
+	if (ctx->keyring_keys_count >= ctx->keyring_keys_size)
+		return 1;
+
+	ctx->keyring_keys[ctx->keyring_keys_count++] = key;
+	return 0;
+}
+
+/*
+ * Read a list of keys from the given keyring.
+ *  keyring - Keyring to read the list of keys from
+ *  ctx - Keyring data is returned in this.
+ *
+ * Memory for keyring_keys_read_context is allocated here.
+ * Caller is responsible for freeing this buffer.
+ */
+long keyring_read_keys(const struct key *keyring,
+			 struct keyring_keys_read_context **ctx)
+{
+	long ret;
+	long keycount;
+
+	kenter("{%d}", key_serial(keyring));
+
+	if (ctx == NULL) {
+		kleave(" = %ld [invalid ctx]", ret);
+		return -EINVAL;
+	}
+
+	rcu_read_lock();
+	keycount = keyring->keys.nr_leaves_on_tree;
+	rcu_read_unlock();
+
+	// Allocate context data. Caller must free this memory
+	*ctx = kzalloc(sizeof(struct keyring_keys_read_context) +
+			keycount * sizeof(struct key *), GFP_KERNEL);
+	if (*ctx == NULL) {
+		kleave(" = %ld [no memory]", ret);
+		return -ENOMEM;
+	}
+
+	(*ctx)->keyring_keys_size = keycount;
+	(*ctx)->keyring_keys_count = 0;
+
+	if (keycount == 0) {
+		kleave(" = %ld [keyring empty]", ret);
+		return 0;
+	}
+
+	rcu_read_lock();
+	ret = assoc_array_iterate(&keyring->keys,
+					  keyring_keys_iterator, *ctx);
+	if (ret == 0)
+		kleave(" = %ld [ok]", ret);
+	else
+		kleave(" = %ld [error]", ret);
+	rcu_read_unlock();
+
+	return ret;
+}
+
+/*
+ * Read a list of keys from builtin_trusted_keys keyring.
+ *  ctx - Keyring data is returned in this.
+ *
+ * Memory for keyring_keys_read_context is allocated here.
+ * Caller is responsible for freeing this buffer.
+ */
+long keyring_read_builtin_trusted_keys(
+	struct keyring_keys_read_context **ctx)
+{
+	return keyring_read_keys(get_builtin_trusted_keys(), ctx);
+}
+
+#endif /* CONFIG_IMA_MEASURE_TRUSTED_KEYS */
-- 
2.17.1

