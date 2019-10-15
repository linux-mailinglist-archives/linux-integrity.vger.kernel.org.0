Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4CBD845B
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 01:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfJOXR4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Oct 2019 19:17:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55638 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfJOXR4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 19:17:56 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0030320B7116;
        Tue, 15 Oct 2019 16:17:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0030320B7116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571181474;
        bh=rP5cSXuariiug4gmhtXvKGyML5csYBzMXGUR9dXX4QE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFU2UG73zFTrF0EbjWLkyV4Oyv9fU+DQatxYDlm9OhIiAb9K4JknMzxukU0wcjMIm
         CSfYboMOWRJKbWK3A6T0+YkwOEqamyqZJEHnkeQkmGMtuhNgHAwfqo+5CKw6Xax+lK
         rV36CKpTbWr+oejk+QPir0LDuYiR5GxH+03Smx5Y=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        kgoldman@us.ibm.com, mjg59@google.com, dhowells@redhat.com
Cc:     balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
Subject: [PATCH v0 1/1] KEYS: LSM Hook for key_create_or_update
Date:   Tue, 15 Oct 2019 16:17:50 -0700
Message-Id: <20191015231750.25992-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015231750.25992-1-nramas@linux.microsoft.com>
References: <20191015231750.25992-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a LSM Hook for key_create_or_update function. The motive behind
this change is enable subsystems to receive notification when
a new key is created or updated.

IMA will be one of the subsystems that will use this hook to measure
the newly created key.

This change set includes helper functions to check if the keyring
(to which a new key is being added, for example) is one of 
the trusted keys keyring (builtin, secondary, or platform).

The change set also includes an IMA function that will be called
from the LSM hook to notify of the newly created key and the keyring
to which the key is being added to.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 certs/system_keyring.c            | 23 +++++++++++++++++++++++
 include/keys/system_keyring.h     |  4 ++++
 include/linux/ima.h               |  8 ++++++++
 include/linux/lsm_hooks.h         | 14 ++++++++++++++
 include/linux/security.h          | 10 ++++++++++
 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_main.c | 19 +++++++++++++++++++
 security/keys/key.c               |  8 ++++++++
 security/security.c               | 11 +++++++++++
 9 files changed, 98 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 1eba08a1af82..a89d23fb5d9d 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -283,3 +283,26 @@ void __init set_platform_trusted_keys(struct key *keyring)
 	platform_trusted_keys = keyring;
 }
 #endif
+
+inline bool is_builtin_trusted_keyring(struct key *keyring)
+{
+	return (keyring == builtin_trusted_keys);
+}
+
+inline bool is_secondary_trusted_keyring(struct key *keyring)
+{
+	#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
+	return (keyring == secondary_trusted_keys);
+	#else
+	return false;
+	#endif
+}
+
+inline bool is_platform_trusted_keyring(struct key *keyring)
+{
+	#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+	return (keyring == platform_trusted_keys);
+	#else
+	return false;
+	#endif
+}
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index c1a96fdf598b..2517181d8d6c 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -66,4 +66,8 @@ static inline void set_platform_trusted_keys(struct key *keyring)
 }
 #endif
 
+extern bool is_builtin_trusted_keyring(struct key *keyring);
+extern bool is_secondary_trusted_keyring(struct key *keyring);
+extern bool is_platform_trusted_keyring(struct key *keyring);
+
 #endif /* _KEYS_SYSTEM_KEYRING_H */
diff --git a/include/linux/ima.h b/include/linux/ima.h
index a20ad398d260..3fbeca697a1f 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -25,6 +25,8 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_kexec_cmdline(const void *buf, int size);
 
+extern int ima_post_key_create_or_update(struct key *keyring,
+					 struct key *key);
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
@@ -91,6 +93,12 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 }
 
 static inline void ima_kexec_cmdline(const void *buf, int size) {}
+
+static inline int ima_post_key_create_or_update(struct key *keyring,
+						struct key *key)
+{
+	return 0;
+}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index df1318d85f7d..a7f680e05d78 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1066,6 +1066,16 @@
  *
  * Security hooks affecting all Key Management operations
  *
+ * @key_create_or_update:
+ *      Notification of key create or update.
+ *      @keyring points to the keyring to which the key belongs
+ *      @key points to the key being created or updated
+ *      @cred current cred
+ *      @flags is the allocation flags
+ *      @builtin_or_secondary flag indicating whether
+ *      the keyring to which the key belongs is the builtin
+ *      or secondary trusted keys keyring
+ *      Return 0 if permission is granted, -ve error otherwise.
  * @key_alloc:
  *	Permit allocation of a key and assign security data. Note that key does
  *	not have a serial number assigned at this point.
@@ -1781,6 +1791,9 @@ union security_list_options {
 
 	/* key management security hooks */
 #ifdef CONFIG_KEYS
+	int (*key_create_or_update)(struct key *keyring, struct key *key,
+				    const struct cred *cred,
+				    unsigned long flags);
 	int (*key_alloc)(struct key *key, const struct cred *cred,
 				unsigned long flags);
 	void (*key_free)(struct key *key);
@@ -2026,6 +2039,7 @@ struct security_hook_heads {
 	struct hlist_head xfrm_decode_session;
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 #ifdef CONFIG_KEYS
+	struct hlist_head key_create_or_update;
 	struct hlist_head key_alloc;
 	struct hlist_head key_free;
 	struct hlist_head key_permission;
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f7441abbf42..e1cc1c703623 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1672,6 +1672,9 @@ static inline int security_path_chroot(const struct path *path)
 #ifdef CONFIG_KEYS
 #ifdef CONFIG_SECURITY
 
+int security_key_create_or_update(struct key *keyring, struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags);
 int security_key_alloc(struct key *key, const struct cred *cred, unsigned long flags);
 void security_key_free(struct key *key);
 int security_key_permission(key_ref_t key_ref,
@@ -1680,6 +1683,13 @@ int security_key_getsecurity(struct key *key, char **_buffer);
 
 #else
 
+int security_key_create_or_update(struct key *keyring, struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags)
+{
+	return 0;
+}
+
 static inline int security_key_alloc(struct key *key,
 				     const struct cred *cred,
 				     unsigned long flags)
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b6847ee1f47a..8b519c7a6fed 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -21,6 +21,7 @@
 #include <linux/tpm.h>
 #include <linux/audit.h>
 #include <crypto/hash_info.h>
+#include <keys/asymmetric-type.h>
 
 #include "../integrity.h"
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 3d5ce4fd4dcc..b77e489cdce7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -678,6 +678,25 @@ void ima_kexec_cmdline(const void *buf, int size)
 	}
 }
 
+/*
+ * ima_post_key_create_or_update
+ *     @keyring points to the keyring to which the key belongs
+ *     @key points to the key being created or updated
+ * IMA hook called when a new key is created.
+ * This function will measure the key.
+ *
+ * On success return 0.
+ * Return appropriate error code on error
+ */
+int ima_post_key_create_or_update(struct key *keyring, struct key *key)
+{
+	if (key->type != &key_type_asymmetric)
+		return 0;
+
+	/* TODO: Call the function to measure the key */
+	return 0;
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/keys/key.c b/security/keys/key.c
index 764f4c57913e..909554f4d15f 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -936,6 +936,14 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	/* let the security module know about the key */
+	ret = security_key_create_or_update(keyring, key, cred, flags);
+	if (ret < 0) {
+		key_put(key);
+		key_ref = ERR_PTR(ret);
+		goto error_link_end;
+	}
+
 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
 
 error_link_end:
diff --git a/security/security.c b/security/security.c
index 250ee2d76406..a6367abb0c76 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2280,6 +2280,17 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 
 #ifdef CONFIG_KEYS
 
+int security_key_create_or_update(struct key *keyring, struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags)
+{
+	int rc = call_int_hook(key_create_or_update, 0,
+			       keyring, key, cred, flags);
+	if (rc)
+		return rc;
+	return ima_post_key_create_or_update(keyring, key);
+}
+
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-- 
2.17.1

