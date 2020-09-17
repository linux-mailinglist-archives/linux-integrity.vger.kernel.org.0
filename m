Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4765C26DDAC
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 16:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgIQN6h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 09:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgIQN6Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 09:58:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88919C0611BC
        for <linux-integrity@vger.kernel.org>; Thu, 17 Sep 2020 06:47:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so1146443plt.9
        for <linux-integrity@vger.kernel.org>; Thu, 17 Sep 2020 06:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sHmkwc1IEt5uhNq3ZTTT253WhE5FWjqQoBIr/mPKXTw=;
        b=CYS1L/eILGc3sY/EfqUl9GQ0N4Kf5jWArABkP0EyIJNq1974J9yQT1DebLoQWngXjz
         hAd7uMcxDrr2/VL9F+MLhsO9EkrPZ00Iz1A9Odl41g7NFRXSK1xHmshoI0tgVOZUnK12
         u23s64HeYb/q5Q6cqcmWgSGQTaQ4XLme+Syv6dKzm+ZkygxxEkwUMIi/DqthDsp5y01l
         8GlA2nGiiHmfrWxWkzVu2IIn6vJwUHiHsqPbQ+DW1R3i5qwfEyrLBcO9jJviqaUlFuTK
         JFlkgvmlYD3bDLtkceFGe+QS0GDs2bwR/pthyxR8GD5e7gMNqffcAxHjxo7Ml6Wcg0Bs
         EkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sHmkwc1IEt5uhNq3ZTTT253WhE5FWjqQoBIr/mPKXTw=;
        b=IJl4cUa91+w2sJeVsnjB25+vvr6bov3Ry6d9+/MPch0cNSbGj8ZOCIjR2AK45XgBqe
         r83czBugqe2o1e9zLfkcCQ5AcRU3YLbqknCn+KLETpc3u6KSlyvN49WAtAlNp9vq1YPl
         RCs4QCC1pt5Nb8s7Otz0V+4yKSTWHfxcq3YJHWyr/MQ4IapCEwCtqzc0p3s0zTAfDT06
         Q89y3zW/ru2JovYk7G15+Q8MZGhG0cELP9vnEzrQ9OfcDe30Dg59bdbODlD6altDw8F9
         Daopw7QWvazidA//1qRnEHBgkx3SnzkUCpKqkM5ssywjphZ5kyBdDBvTbqvDsIOQNFIO
         wazw==
X-Gm-Message-State: AOAM530fYdsoAqJFFvEgOtS84YZMWVBnp8rK0hS4vdvM7l+bObJ6mXAW
        RJqcnuBCAmY+n8iW408CO/4+Fg==
X-Google-Smtp-Source: ABdhPJwxQVtt4v228fRD0XKWdqSZIxyK+cWpwqFQD/Mw4fAWLYkgja+pLDwxPZk1b+/8iEP0JD+p3g==
X-Received: by 2002:a17:90b:4ac4:: with SMTP id mh4mr8832809pjb.224.1600350435811;
        Thu, 17 Sep 2020 06:47:15 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.163])
        by smtp.gmail.com with ESMTPSA id i73sm6821120pfe.67.2020.09.17.06.47.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 06:47:15 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 1/4] KEYS: trusted: Add generic trusted keys framework
Date:   Thu, 17 Sep 2020 19:16:35 +0530
Message-Id: <1600350398-4813-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600350398-4813-1-git-send-email-sumit.garg@linaro.org>
References: <1600350398-4813-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Current trusted keys framework is tightly coupled to use TPM device as
an underlying implementation which makes it difficult for implementations
like Trusted Execution Environment (TEE) etc. to provide trusted keys
support in case platform doesn't posses a TPM device.

So this patch tries to add generic trusted keys framework where underlying
implementations like TPM, TEE etc. could be easily plugged-in.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 include/keys/trusted-type.h               |  42 ++++
 include/keys/trusted_tpm.h                |  17 +-
 security/keys/trusted-keys/Makefile       |   1 +
 security/keys/trusted-keys/trusted_core.c | 321 ++++++++++++++++++++++++++++
 security/keys/trusted-keys/trusted_tpm1.c | 336 +++++-------------------------
 5 files changed, 422 insertions(+), 295 deletions(-)
 create mode 100644 security/keys/trusted-keys/trusted_core.c

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index a94c03a..edd635a 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -40,6 +40,48 @@ struct trusted_key_options {
 	uint32_t policyhandle;
 };
 
+struct trusted_key_ops {
+	/*
+	 * flag to indicate if trusted key implementation supports migration
+	 * or not.
+	 */
+	unsigned char migratable;
+
+	/* Initialize key interface. */
+	int (*init)(void);
+
+	/* Seal a key. */
+	int (*seal)(struct trusted_key_payload *p, char *datablob);
+
+	/* Unseal a key. */
+	int (*unseal)(struct trusted_key_payload *p, char *datablob);
+
+	/* Get a randomized key. */
+	int (*get_random)(unsigned char *key, size_t key_len);
+
+	/* Exit key interface. */
+	void (*exit)(void);
+};
+
 extern struct key_type key_type_trusted;
 
+#define TRUSTED_DEBUG 0
+
+#if TRUSTED_DEBUG
+static inline void dump_payload(struct trusted_key_payload *p)
+{
+	pr_info("trusted_key: key_len %d\n", p->key_len);
+	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
+		       16, 1, p->key, p->key_len, 0);
+	pr_info("trusted_key: bloblen %d\n", p->blob_len);
+	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
+		       16, 1, p->blob, p->blob_len, 0);
+	pr_info("trusted_key: migratable %d\n", p->migratable);
+}
+#else
+static inline void dump_payload(struct trusted_key_payload *p)
+{
+}
+#endif
+
 #endif /* _KEYS_TRUSTED_TYPE_H */
diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index a56d8e1..fb3280a 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -16,6 +16,8 @@
 #define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
 #define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
 
+extern struct trusted_key_ops tpm_trusted_key_ops;
+
 struct osapsess {
 	uint32_t handle;
 	unsigned char secret[SHA1_DIGEST_SIZE];
@@ -60,17 +62,6 @@ static inline void dump_options(struct trusted_key_options *o)
 		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
 }
 
-static inline void dump_payload(struct trusted_key_payload *p)
-{
-	pr_info("trusted_key: key_len %d\n", p->key_len);
-	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
-		       16, 1, p->key, p->key_len, 0);
-	pr_info("trusted_key: bloblen %d\n", p->blob_len);
-	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
-		       16, 1, p->blob, p->blob_len, 0);
-	pr_info("trusted_key: migratable %d\n", p->migratable);
-}
-
 static inline void dump_sess(struct osapsess *s)
 {
 	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
@@ -96,10 +87,6 @@ static inline void dump_options(struct trusted_key_options *o)
 {
 }
 
-static inline void dump_payload(struct trusted_key_payload *p)
-{
-}
-
 static inline void dump_sess(struct osapsess *s)
 {
 }
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index 7b73ceb..49e3bcf 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -4,5 +4,6 @@
 #
 
 obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
+trusted-y += trusted_core.o
 trusted-y += trusted_tpm1.o
 trusted-y += trusted_tpm2.o
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
new file mode 100644
index 0000000..4ae3fb4
--- /dev/null
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2010 IBM Corporation
+ * Copyright (c) 2019-2020, Linaro Limited
+ *
+ * See Documentation/security/keys/trusted-encrypted.rst
+ */
+
+#include <keys/user-type.h>
+#include <keys/trusted-type.h>
+#include <keys/trusted_tpm.h>
+#include <linux/capability.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/key-type.h>
+#include <linux/module.h>
+#include <linux/parser.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+static struct trusted_key_ops *available_trusted_key_ops[] = {
+#if defined(CONFIG_TCG_TPM)
+	&tpm_trusted_key_ops,
+#endif
+};
+static struct trusted_key_ops *trusted_key_ops;
+
+enum {
+	Opt_err,
+	Opt_new, Opt_load, Opt_update,
+};
+
+static const match_table_t key_tokens = {
+	{Opt_new, "new"},
+	{Opt_load, "load"},
+	{Opt_update, "update"},
+	{Opt_err, NULL}
+};
+
+/*
+ * datablob_parse - parse the keyctl data and fill in the
+ *                  payload structure
+ *
+ * On success returns 0, otherwise -EINVAL.
+ */
+static int datablob_parse(char *datablob, struct trusted_key_payload *p)
+{
+	substring_t args[MAX_OPT_ARGS];
+	long keylen;
+	int ret = -EINVAL;
+	int key_cmd;
+	char *c;
+
+	/* main command */
+	c = strsep(&datablob, " \t");
+	if (!c)
+		return -EINVAL;
+	key_cmd = match_token(c, key_tokens, args);
+	switch (key_cmd) {
+	case Opt_new:
+		/* first argument is key size */
+		c = strsep(&datablob, " \t");
+		if (!c)
+			return -EINVAL;
+		ret = kstrtol(c, 10, &keylen);
+		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
+			return -EINVAL;
+		p->key_len = keylen;
+		ret = Opt_new;
+		break;
+	case Opt_load:
+		/* first argument is sealed blob */
+		c = strsep(&datablob, " \t");
+		if (!c)
+			return -EINVAL;
+		p->blob_len = strlen(c) / 2;
+		if (p->blob_len > MAX_BLOB_SIZE)
+			return -EINVAL;
+		ret = hex2bin(p->blob, c, p->blob_len);
+		if (ret < 0)
+			return -EINVAL;
+		ret = Opt_load;
+		break;
+	case Opt_update:
+		ret = Opt_update;
+		break;
+	case Opt_err:
+		return -EINVAL;
+	}
+	return ret;
+}
+
+static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
+{
+	struct trusted_key_payload *p = NULL;
+	int ret;
+
+	ret = key_payload_reserve(key, sizeof(*p));
+	if (ret < 0)
+		return p;
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+
+	p->migratable = trusted_key_ops->migratable;
+
+	return p;
+}
+
+/*
+ * trusted_instantiate - create a new trusted key
+ *
+ * Unseal an existing trusted blob or, for a new key, get a
+ * random key, then seal and create a trusted key-type key,
+ * adding it to the specified keyring.
+ *
+ * On success, return 0. Otherwise return errno.
+ */
+static int trusted_instantiate(struct key *key,
+			       struct key_preparsed_payload *prep)
+{
+	struct trusted_key_payload *payload = NULL;
+	size_t datalen = prep->datalen;
+	char *datablob;
+	int ret = 0;
+	int key_cmd;
+	size_t key_len;
+
+	if (datalen <= 0 || datalen > 32767 || !prep->data)
+		return -EINVAL;
+
+	datablob = kmalloc(datalen + 1, GFP_KERNEL);
+	if (!datablob)
+		return -ENOMEM;
+	memcpy(datablob, prep->data, datalen);
+	datablob[datalen] = '\0';
+
+	payload = trusted_payload_alloc(key);
+	if (!payload) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	key_cmd = datablob_parse(datablob, payload);
+	if (key_cmd < 0) {
+		ret = key_cmd;
+		goto out;
+	}
+
+	dump_payload(payload);
+
+	switch (key_cmd) {
+	case Opt_load:
+		ret = trusted_key_ops->unseal(payload, datablob);
+		dump_payload(payload);
+		if (ret < 0)
+			pr_info("trusted_key: key_unseal failed (%d)\n", ret);
+		break;
+	case Opt_new:
+		key_len = payload->key_len;
+		ret = trusted_key_ops->get_random(payload->key, key_len);
+		if (ret != key_len) {
+			pr_info("trusted_key: key_create failed (%d)\n", ret);
+			goto out;
+		}
+
+		ret = trusted_key_ops->seal(payload, datablob);
+		if (ret < 0)
+			pr_info("trusted_key: key_seal failed (%d)\n", ret);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+out:
+	kfree_sensitive(datablob);
+	if (!ret)
+		rcu_assign_keypointer(key, payload);
+	else
+		kfree_sensitive(payload);
+	return ret;
+}
+
+static void trusted_rcu_free(struct rcu_head *rcu)
+{
+	struct trusted_key_payload *p;
+
+	p = container_of(rcu, struct trusted_key_payload, rcu);
+	kfree_sensitive(p);
+}
+
+/*
+ * trusted_update - reseal an existing key with new PCR values
+ */
+static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
+{
+	struct trusted_key_payload *p;
+	struct trusted_key_payload *new_p;
+	size_t datalen = prep->datalen;
+	char *datablob;
+	int ret = 0;
+
+	if (key_is_negative(key))
+		return -ENOKEY;
+	p = key->payload.data[0];
+	if (!p->migratable)
+		return -EPERM;
+	if (datalen <= 0 || datalen > 32767 || !prep->data)
+		return -EINVAL;
+
+	datablob = kmalloc(datalen + 1, GFP_KERNEL);
+	if (!datablob)
+		return -ENOMEM;
+
+	new_p = trusted_payload_alloc(key);
+	if (!new_p) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(datablob, prep->data, datalen);
+	datablob[datalen] = '\0';
+	ret = datablob_parse(datablob, new_p);
+	if (ret != Opt_update) {
+		ret = -EINVAL;
+		kfree_sensitive(new_p);
+		goto out;
+	}
+
+	/* copy old key values, and reseal with new pcrs */
+	new_p->migratable = p->migratable;
+	new_p->key_len = p->key_len;
+	memcpy(new_p->key, p->key, p->key_len);
+	dump_payload(p);
+	dump_payload(new_p);
+
+	ret = trusted_key_ops->seal(new_p, datablob);
+	if (ret < 0) {
+		pr_info("trusted_key: key_seal failed (%d)\n", ret);
+		kfree_sensitive(new_p);
+		goto out;
+	}
+
+	rcu_assign_keypointer(key, new_p);
+	call_rcu(&p->rcu, trusted_rcu_free);
+out:
+	kfree_sensitive(datablob);
+	return ret;
+}
+
+/*
+ * trusted_read - copy the sealed blob data to userspace in hex.
+ * On success, return to userspace the trusted key datablob size.
+ */
+static long trusted_read(const struct key *key, char *buffer,
+			 size_t buflen)
+{
+	const struct trusted_key_payload *p;
+	char *bufp;
+	int i;
+
+	p = dereference_key_locked(key);
+	if (!p)
+		return -EINVAL;
+
+	if (buffer && buflen >= 2 * p->blob_len) {
+		bufp = buffer;
+		for (i = 0; i < p->blob_len; i++)
+			bufp = hex_byte_pack(bufp, p->blob[i]);
+	}
+	return 2 * p->blob_len;
+}
+
+/*
+ * trusted_destroy - clear and free the key's payload
+ */
+static void trusted_destroy(struct key *key)
+{
+	kfree_sensitive(key->payload.data[0]);
+}
+
+struct key_type key_type_trusted = {
+	.name = "trusted",
+	.instantiate = trusted_instantiate,
+	.update = trusted_update,
+	.destroy = trusted_destroy,
+	.describe = user_describe,
+	.read = trusted_read,
+};
+EXPORT_SYMBOL_GPL(key_type_trusted);
+
+static int __init init_trusted(void)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < sizeof(available_trusted_key_ops); i++) {
+		trusted_key_ops = available_trusted_key_ops[i];
+
+		ret = trusted_key_ops->init();
+		if (!ret)
+			break;
+	}
+
+	/*
+	 * encrypted_keys.ko depends on successful load of this module even if
+	 * trusted key implementation is not found.
+	 */
+	if (ret == -ENODEV)
+		return 0;
+
+	return ret;
+}
+
+static void __exit cleanup_trusted(void)
+{
+	trusted_key_ops->exit();
+}
+
+late_initcall(init_trusted);
+module_exit(cleanup_trusted);
+
+MODULE_LICENSE("GPL");
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index b9fe02e..1c5df77 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -1,29 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2010 IBM Corporation
- *
- * Author:
- * David Safford <safford@us.ibm.com>
+ * Copyright (c) 2019-2020, Linaro Limited
  *
  * See Documentation/security/keys/trusted-encrypted.rst
  */
 
 #include <crypto/hash_info.h>
-#include <linux/uaccess.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/parser.h>
 #include <linux/string.h>
 #include <linux/err.h>
-#include <keys/user-type.h>
 #include <keys/trusted-type.h>
 #include <linux/key-type.h>
-#include <linux/rcupdate.h>
 #include <linux/crypto.h>
 #include <crypto/hash.h>
 #include <crypto/sha.h>
-#include <linux/capability.h>
 #include <linux/tpm.h>
 #include <linux/tpm_command.h>
 
@@ -703,7 +696,6 @@ static int key_unseal(struct trusted_key_payload *p,
 
 enum {
 	Opt_err,
-	Opt_new, Opt_load, Opt_update,
 	Opt_keyhandle, Opt_keyauth, Opt_blobauth,
 	Opt_pcrinfo, Opt_pcrlock, Opt_migratable,
 	Opt_hash,
@@ -712,9 +704,6 @@ enum {
 };
 
 static const match_table_t key_tokens = {
-	{Opt_new, "new"},
-	{Opt_load, "load"},
-	{Opt_update, "update"},
 	{Opt_keyhandle, "keyhandle=%s"},
 	{Opt_keyauth, "keyauth=%s"},
 	{Opt_blobauth, "blobauth=%s"},
@@ -841,71 +830,6 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 	return 0;
 }
 
-/*
- * datablob_parse - parse the keyctl data and fill in the
- * 		    payload and options structures
- *
- * On success returns 0, otherwise -EINVAL.
- */
-static int datablob_parse(char *datablob, struct trusted_key_payload *p,
-			  struct trusted_key_options *o)
-{
-	substring_t args[MAX_OPT_ARGS];
-	long keylen;
-	int ret = -EINVAL;
-	int key_cmd;
-	char *c;
-
-	/* main command */
-	c = strsep(&datablob, " \t");
-	if (!c)
-		return -EINVAL;
-	key_cmd = match_token(c, key_tokens, args);
-	switch (key_cmd) {
-	case Opt_new:
-		/* first argument is key size */
-		c = strsep(&datablob, " \t");
-		if (!c)
-			return -EINVAL;
-		ret = kstrtol(c, 10, &keylen);
-		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
-			return -EINVAL;
-		p->key_len = keylen;
-		ret = getoptions(datablob, p, o);
-		if (ret < 0)
-			return ret;
-		ret = Opt_new;
-		break;
-	case Opt_load:
-		/* first argument is sealed blob */
-		c = strsep(&datablob, " \t");
-		if (!c)
-			return -EINVAL;
-		p->blob_len = strlen(c) / 2;
-		if (p->blob_len > MAX_BLOB_SIZE)
-			return -EINVAL;
-		ret = hex2bin(p->blob, c, p->blob_len);
-		if (ret < 0)
-			return -EINVAL;
-		ret = getoptions(datablob, p, o);
-		if (ret < 0)
-			return ret;
-		ret = Opt_load;
-		break;
-	case Opt_update:
-		/* all arguments are options */
-		ret = getoptions(datablob, p, o);
-		if (ret < 0)
-			return ret;
-		ret = Opt_update;
-		break;
-	case Opt_err:
-		return -EINVAL;
-		break;
-	}
-	return ret;
-}
-
 static struct trusted_key_options *trusted_options_alloc(void)
 {
 	struct trusted_key_options *options;
@@ -926,248 +850,99 @@ static struct trusted_key_options *trusted_options_alloc(void)
 	return options;
 }
 
-static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
+static int tpm_trusted_seal(struct trusted_key_payload *p, char *datablob)
 {
-	struct trusted_key_payload *p = NULL;
-	int ret;
-
-	ret = key_payload_reserve(key, sizeof *p);
-	if (ret < 0)
-		return p;
-	p = kzalloc(sizeof *p, GFP_KERNEL);
-	if (p)
-		p->migratable = 1; /* migratable by default */
-	return p;
-}
-
-/*
- * trusted_instantiate - create a new trusted key
- *
- * Unseal an existing trusted blob or, for a new key, get a
- * random key, then seal and create a trusted key-type key,
- * adding it to the specified keyring.
- *
- * On success, return 0. Otherwise return errno.
- */
-static int trusted_instantiate(struct key *key,
-			       struct key_preparsed_payload *prep)
-{
-	struct trusted_key_payload *payload = NULL;
 	struct trusted_key_options *options = NULL;
-	size_t datalen = prep->datalen;
-	char *datablob;
 	int ret = 0;
-	int key_cmd;
-	size_t key_len;
 	int tpm2;
 
 	tpm2 = tpm_is_tpm2(chip);
 	if (tpm2 < 0)
 		return tpm2;
 
-	if (datalen <= 0 || datalen > 32767 || !prep->data)
-		return -EINVAL;
-
-	datablob = kmalloc(datalen + 1, GFP_KERNEL);
-	if (!datablob)
-		return -ENOMEM;
-	memcpy(datablob, prep->data, datalen);
-	datablob[datalen] = '\0';
-
 	options = trusted_options_alloc();
-	if (!options) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	payload = trusted_payload_alloc(key);
-	if (!payload) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!options)
+		return -ENOMEM;
 
-	key_cmd = datablob_parse(datablob, payload, options);
-	if (key_cmd < 0) {
-		ret = key_cmd;
+	ret = getoptions(datablob, p, options);
+	if (ret < 0)
 		goto out;
-	}
+	dump_options(options);
 
 	if (!options->keyhandle) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	dump_payload(payload);
-	dump_options(options);
+	if (tpm2)
+		ret = tpm2_seal_trusted(chip, p, options);
+	else
+		ret = key_seal(p, options);
+	if (ret < 0) {
+		pr_info("tpm_trusted_key: key_seal failed (%d)\n", ret);
+		goto out;
+	}
 
-	switch (key_cmd) {
-	case Opt_load:
-		if (tpm2)
-			ret = tpm2_unseal_trusted(chip, payload, options);
-		else
-			ret = key_unseal(payload, options);
-		dump_payload(payload);
-		dump_options(options);
-		if (ret < 0)
-			pr_info("trusted_key: key_unseal failed (%d)\n", ret);
-		break;
-	case Opt_new:
-		key_len = payload->key_len;
-		ret = tpm_get_random(chip, payload->key, key_len);
-		if (ret != key_len) {
-			pr_info("trusted_key: key_create failed (%d)\n", ret);
+	if (options->pcrlock) {
+		ret = pcrlock(options->pcrlock);
+		if (ret < 0) {
+			pr_info("tpm_trusted_key: pcrlock failed (%d)\n", ret);
 			goto out;
 		}
-		if (tpm2)
-			ret = tpm2_seal_trusted(chip, payload, options);
-		else
-			ret = key_seal(payload, options);
-		if (ret < 0)
-			pr_info("trusted_key: key_seal failed (%d)\n", ret);
-		break;
-	default:
-		ret = -EINVAL;
-		goto out;
 	}
-	if (!ret && options->pcrlock)
-		ret = pcrlock(options->pcrlock);
 out:
-	kfree_sensitive(datablob);
 	kfree_sensitive(options);
-	if (!ret)
-		rcu_assign_keypointer(key, payload);
-	else
-		kfree_sensitive(payload);
 	return ret;
 }
 
-static void trusted_rcu_free(struct rcu_head *rcu)
-{
-	struct trusted_key_payload *p;
-
-	p = container_of(rcu, struct trusted_key_payload, rcu);
-	kfree_sensitive(p);
-}
-
-/*
- * trusted_update - reseal an existing key with new PCR values
- */
-static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
+static int tpm_trusted_unseal(struct trusted_key_payload *p, char *datablob)
 {
-	struct trusted_key_payload *p;
-	struct trusted_key_payload *new_p;
-	struct trusted_key_options *new_o;
-	size_t datalen = prep->datalen;
-	char *datablob;
+	struct trusted_key_options *options = NULL;
 	int ret = 0;
+	int tpm2;
 
-	if (key_is_negative(key))
-		return -ENOKEY;
-	p = key->payload.data[0];
-	if (!p->migratable)
-		return -EPERM;
-	if (datalen <= 0 || datalen > 32767 || !prep->data)
-		return -EINVAL;
+	tpm2 = tpm_is_tpm2(chip);
+	if (tpm2 < 0)
+		return tpm2;
 
-	datablob = kmalloc(datalen + 1, GFP_KERNEL);
-	if (!datablob)
+	options = trusted_options_alloc();
+	if (!options)
 		return -ENOMEM;
-	new_o = trusted_options_alloc();
-	if (!new_o) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	new_p = trusted_payload_alloc(key);
-	if (!new_p) {
-		ret = -ENOMEM;
-		goto out;
-	}
 
-	memcpy(datablob, prep->data, datalen);
-	datablob[datalen] = '\0';
-	ret = datablob_parse(datablob, new_p, new_o);
-	if (ret != Opt_update) {
-		ret = -EINVAL;
-		kfree_sensitive(new_p);
+	ret = getoptions(datablob, p, options);
+	if (ret < 0)
 		goto out;
-	}
+	dump_options(options);
 
-	if (!new_o->keyhandle) {
+	if (!options->keyhandle) {
 		ret = -EINVAL;
-		kfree_sensitive(new_p);
 		goto out;
 	}
 
-	/* copy old key values, and reseal with new pcrs */
-	new_p->migratable = p->migratable;
-	new_p->key_len = p->key_len;
-	memcpy(new_p->key, p->key, p->key_len);
-	dump_payload(p);
-	dump_payload(new_p);
+	if (tpm2)
+		ret = tpm2_unseal_trusted(chip, p, options);
+	else
+		ret = key_unseal(p, options);
+	if (ret < 0)
+		pr_info("tpm_trusted_key: key_unseal failed (%d)\n", ret);
 
-	ret = key_seal(new_p, new_o);
-	if (ret < 0) {
-		pr_info("trusted_key: key_seal failed (%d)\n", ret);
-		kfree_sensitive(new_p);
-		goto out;
-	}
-	if (new_o->pcrlock) {
-		ret = pcrlock(new_o->pcrlock);
+	if (options->pcrlock) {
+		ret = pcrlock(options->pcrlock);
 		if (ret < 0) {
-			pr_info("trusted_key: pcrlock failed (%d)\n", ret);
-			kfree_sensitive(new_p);
+			pr_info("tpm_trusted_key: pcrlock failed (%d)\n", ret);
 			goto out;
 		}
 	}
-	rcu_assign_keypointer(key, new_p);
-	call_rcu(&p->rcu, trusted_rcu_free);
 out:
-	kfree_sensitive(datablob);
-	kfree_sensitive(new_o);
+	kfree_sensitive(options);
 	return ret;
 }
 
-/*
- * trusted_read - copy the sealed blob data to userspace in hex.
- * On success, return to userspace the trusted key datablob size.
- */
-static long trusted_read(const struct key *key, char *buffer,
-			 size_t buflen)
-{
-	const struct trusted_key_payload *p;
-	char *bufp;
-	int i;
-
-	p = dereference_key_locked(key);
-	if (!p)
-		return -EINVAL;
-
-	if (buffer && buflen >= 2 * p->blob_len) {
-		bufp = buffer;
-		for (i = 0; i < p->blob_len; i++)
-			bufp = hex_byte_pack(bufp, p->blob[i]);
-	}
-	return 2 * p->blob_len;
-}
-
-/*
- * trusted_destroy - clear and free the key's payload
- */
-static void trusted_destroy(struct key *key)
+static int tpm_trusted_get_random(unsigned char *key, size_t key_len)
 {
-	kfree_sensitive(key->payload.data[0]);
+	return tpm_get_random(chip, key, key_len);
 }
 
-struct key_type key_type_trusted = {
-	.name = "trusted",
-	.instantiate = trusted_instantiate,
-	.update = trusted_update,
-	.destroy = trusted_destroy,
-	.describe = user_describe,
-	.read = trusted_read,
-};
-
-EXPORT_SYMBOL_GPL(key_type_trusted);
-
 static void trusted_shash_release(void)
 {
 	if (hashalg)
@@ -1182,14 +957,14 @@ static int __init trusted_shash_alloc(void)
 
 	hmacalg = crypto_alloc_shash(hmac_alg, 0, 0);
 	if (IS_ERR(hmacalg)) {
-		pr_info("trusted_key: could not allocate crypto %s\n",
+		pr_info("tpm_trusted_key: could not allocate crypto %s\n",
 			hmac_alg);
 		return PTR_ERR(hmacalg);
 	}
 
 	hashalg = crypto_alloc_shash(hash_alg, 0, 0);
 	if (IS_ERR(hashalg)) {
-		pr_info("trusted_key: could not allocate crypto %s\n",
+		pr_info("tpm_trusted_key: could not allocate crypto %s\n",
 			hash_alg);
 		ret = PTR_ERR(hashalg);
 		goto hashalg_fail;
@@ -1217,16 +992,13 @@ static int __init init_digests(void)
 	return 0;
 }
 
-static int __init init_trusted(void)
+static int __init init_tpm_trusted(void)
 {
 	int ret;
 
-	/* encrypted_keys.ko depends on successful load of this module even if
-	 * TPM is not used.
-	 */
 	chip = tpm_default_chip();
 	if (!chip)
-		return 0;
+		return -ENODEV;
 
 	ret = init_digests();
 	if (ret < 0)
@@ -1247,7 +1019,7 @@ static int __init init_trusted(void)
 	return ret;
 }
 
-static void __exit cleanup_trusted(void)
+static void __exit exit_tpm_trusted(void)
 {
 	if (chip) {
 		put_device(&chip->dev);
@@ -1257,7 +1029,11 @@ static void __exit cleanup_trusted(void)
 	}
 }
 
-late_initcall(init_trusted);
-module_exit(cleanup_trusted);
-
-MODULE_LICENSE("GPL");
+struct trusted_key_ops tpm_trusted_key_ops = {
+	.migratable = 1, /* migratable by default */
+	.init = init_tpm_trusted,
+	.seal = tpm_trusted_seal,
+	.unseal = tpm_trusted_unseal,
+	.get_random = tpm_trusted_get_random,
+	.exit = exit_tpm_trusted,
+};
-- 
2.7.4

