Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD5BD46B7
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2019 19:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfJKRfy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Oct 2019 13:35:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53922 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfJKRfy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Oct 2019 13:35:54 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5091620B711D;
        Fri, 11 Oct 2019 10:35:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5091620B711D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570815352;
        bh=wUc2KG105B2ntuYI4PfdvGpNlyKUu3VYOJqAH8E5qqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qAUiXxl/N4hFfwLtgBpPoYmBgJ8Uo7JEW/eElWFoMwZ+NF+0vmSZmkjmrzil8MHXT
         kEHb3mXwlFupwsSQWN4McXZll9Npb76GQp5ZFCKa9kMXV8XyL0XOR3vXMV/EgVF0r0
         4QeQQ9LQb6/tBUOy/5/hBsnYRydDGlmltXa+Jxok=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        kgoldman@us.ibm.com, mjg59@google.com, dhowells@redhat.com
Cc:     balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
Subject: [PATCH v0 2/2] KEYS: LSM Hook for key_create_or_update
Date:   Fri, 11 Oct 2019 10:35:47 -0700
Message-Id: <20191011173547.3200-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011173547.3200-1-nramas@linux.microsoft.com>
References: <20191011173547.3200-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

LSM Hook to key_create_or_update. The LSM hook will call_int_hook
IMA function ima_post_key_create_or_update.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 certs/system_keyring.c        | 14 ++++++++++++++
 include/keys/system_keyring.h |  2 ++
 include/linux/lsm_hooks.h     | 15 +++++++++++++++
 include/linux/security.h      | 12 ++++++++++++
 security/keys/key.c           | 12 ++++++++++++
 security/security.c           | 14 ++++++++++++++
 6 files changed, 69 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 1eba08a1af82..bed19a2f5dd1 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -283,3 +283,17 @@ void __init set_platform_trusted_keys(struct key *keyring)
 	platform_trusted_keys = keyring;
 }
 #endif
+
+bool is_builtin_or_secondary_trusted_keyring(struct key *keyring)
+{
+	bool trustedkeyring;
+
+	trustedkeyring = (keyring == builtin_trusted_keys);
+
+	#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
+	if (!trustedkeyring)
+		trustedkeyring = (keyring == secondary_trusted_keys);
+	#endif
+
+	return trustedkeyring;
+}
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index c1a96fdf598b..eb7aa81ec5d3 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -66,4 +66,6 @@ static inline void set_platform_trusted_keys(struct key *keyring)
 }
 #endif
 
+extern bool is_builtin_or_secondary_trusted_keyring(struct key *keyring);
+
 #endif /* _KEYS_SYSTEM_KEYRING_H */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index df1318d85f7d..d447ee689910 100644
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
@@ -1781,6 +1791,10 @@ union security_list_options {
 
 	/* key management security hooks */
 #ifdef CONFIG_KEYS
+	int (*key_create_or_update)(struct key *keyring, struct key *key,
+				    const struct cred *cred,
+				    unsigned long flags,
+				    bool builtin_or_secondary);
 	int (*key_alloc)(struct key *key, const struct cred *cred,
 				unsigned long flags);
 	void (*key_free)(struct key *key);
@@ -2026,6 +2040,7 @@ struct security_hook_heads {
 	struct hlist_head xfrm_decode_session;
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 #ifdef CONFIG_KEYS
+	struct hlist_head key_create_or_update;
 	struct hlist_head key_alloc;
 	struct hlist_head key_free;
 	struct hlist_head key_permission;
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f7441abbf42..0db4316e236e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1672,6 +1672,10 @@ static inline int security_path_chroot(const struct path *path)
 #ifdef CONFIG_KEYS
 #ifdef CONFIG_SECURITY
 
+int security_key_create_or_update(struct key *keyring, struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags,
+				  bool builtin_or_secondary);
 int security_key_alloc(struct key *key, const struct cred *cred, unsigned long flags);
 void security_key_free(struct key *key);
 int security_key_permission(key_ref_t key_ref,
@@ -1680,6 +1684,14 @@ int security_key_getsecurity(struct key *key, char **_buffer);
 
 #else
 
+int security_key_create_or_update(struct key *keyring, struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags,
+				  bool builtin_or_secondary)
+{
+	return 0;
+}
+
 static inline int security_key_alloc(struct key *key,
 				     const struct cred *cred,
 				     unsigned long flags)
diff --git a/security/keys/key.c b/security/keys/key.c
index 764f4c57913e..973dfead490c 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -14,6 +14,7 @@
 #include <linux/workqueue.h>
 #include <linux/random.h>
 #include <linux/err.h>
+#include <keys/system_keyring.h>
 #include "internal.h"
 
 struct kmem_cache *key_jar;
@@ -823,6 +824,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	key_ref_t key_ref;
 	int ret;
 	struct key_restriction *restrict_link = NULL;
+	bool trusted_keyring = false;
 
 	/* look up the key type to see if it's one of the registered kernel
 	 * types */
@@ -936,6 +938,16 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	/* let the security module know about the key */
+	trusted_keyring = is_builtin_or_secondary_trusted_keyring(keyring);
+	ret = security_key_create_or_update(keyring, key, cred, flags,
+					    trusted_keyring);
+	if (ret < 0) {
+		key_put(key);
+		key_ref = ERR_PTR(ret);
+		goto error_link_end;
+	}
+
 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
 
 error_link_end:
diff --git a/security/security.c b/security/security.c
index 250ee2d76406..df6f561e4418 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2280,6 +2280,20 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 
 #ifdef CONFIG_KEYS
 
+int security_key_create_or_update(struct key *keyring, struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags,
+				  bool builtin_or_secondary)
+{
+	int rc = call_int_hook(key_create_or_update, 0,
+			       keyring, key, cred, flags,
+			       builtin_or_secondary);
+	if (rc)
+		return rc;
+	return ima_post_key_create_or_update(keyring, key,
+					     builtin_or_secondary);
+}
+
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-- 
2.17.1

