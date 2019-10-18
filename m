Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA3DCFA2
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Oct 2019 21:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443352AbfJRTxf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Oct 2019 15:53:35 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56838 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440122AbfJRTxf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Oct 2019 15:53:35 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2299720BBF8C;
        Fri, 18 Oct 2019 12:53:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2299720BBF8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571428413;
        bh=oAy5SSZ1zkgcHxbdKT0WxiKQ1TErswG6+Y1V0zmQQ+w=;
        h=From:To:Cc:Subject:Date:From;
        b=abSOZU37ldva4EQdfyRExSPeK+MqcludBf2OzbvkNAGRbJU77huIKgA8kgZIH+Y6b
         7UVinTbXAr3of9MGBjsisjSOx/FQ3J1jWqxFf4EEVHBE6U1EDNYw+BU7Qbj9Pdg6Xb
         8LuR8QPfxd3BZ8odlFvCMuZ2lKFEg0ufiabOAoC0=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        sashal@kernel.org, jamorris@linux.microsoft.com
Cc:     msft-linux-kernel@linux.microsoft.com, nramas@linux.microsoft.com,
        prsriva@linux.microsoft.com
Subject: [PATCH v0] KEYS: Security LSM Hook for key_create_or_update
Date:   Fri, 18 Oct 2019 12:53:28 -0700
Message-Id: <20191018195328.6704-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Problem Statement:
key_create_or_update function currently does not have
a security LSM hook. The hook is needed to allow security
subsystems to use key create or update information.

security_key_alloc LSM hook that is currently available is not
providing enough information about the key (the key payload,
the target keyring, etc.). Also, this LSM hook is only available
for key create.

Changes made:
Adding a new LSM hook for key key_create_or_update,
security_key_create_or_update, which is called after
   => A newly created key is instantiated and linked to the target
      keyring (__key_instantiate_and_link).
   => An existing key is updated with a new payload (__key_update)

security_key_create_or_update is passed the target keyring, key,
cred, key creation flags, and a boolean flag indicating whether
the key was newly created or updated.

Security subsystems can use this hook for handling key create or update.
For example, IMA subsystem can measure the key when it is created or
updated.

Testing performed:
  * Booted the kernel with this change.
  * Executed keyctl tests from the Linux Test Project (LTP)
  * Added a new key to a keyring and verified "key create" code path.
    => In this case added a key to builtin_trusted_keys keyring.
  * Added the same key again and verified "key update" code path.
    => Add the same key to builtin_trusted_keys keyring.
    => find_key_to_update found the key and LSM hook was
       called for key update (create flag set to false).
  * Forced the LSM hook (security_key_create_or_update) to
    return an error and verified that the key was not added to
    the keyring ("keyctl list <keyring>" does not list the key).

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/lsm_hooks.h | 13 +++++++
 include/linux/security.h  | 10 +++++
 security/keys/key.c       | 78 ++++++++++++++++++++++++++++++++++-----
 security/security.c       |  8 ++++
 4 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index df1318d85f7d..2f2e95df62f3 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1066,6 +1066,15 @@
  *
  * Security hooks affecting all Key Management operations
  *
+ * @key_create_or_update:
+ *      Notification of key create or update.
+ *      @keyring points to the keyring to which the key belongs
+ *      @key points to the key being created or updated
+ *      @cred current cred
+ *      @flags is the allocation flags
+ *      @create flag set to true if the key was created.
+ *              flag set to false if the key was updated.
+ *      Return 0 if permission is granted, -ve error otherwise.
  * @key_alloc:
  *	Permit allocation of a key and assign security data. Note that key does
  *	not have a serial number assigned at this point.
@@ -1781,6 +1790,9 @@ union security_list_options {
 
 	/* key management security hooks */
 #ifdef CONFIG_KEYS
+	int (*key_create_or_update)(struct key *keyring, struct key *key,
+				    const struct cred *cred,
+				    unsigned long flags, bool create);
 	int (*key_alloc)(struct key *key, const struct cred *cred,
 				unsigned long flags);
 	void (*key_free)(struct key *key);
@@ -2026,6 +2038,7 @@ struct security_hook_heads {
 	struct hlist_head xfrm_decode_session;
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 #ifdef CONFIG_KEYS
+	struct hlist_head key_create_or_update;
 	struct hlist_head key_alloc;
 	struct hlist_head key_free;
 	struct hlist_head key_permission;
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f7441abbf42..27e1c0a3057b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1672,6 +1672,9 @@ static inline int security_path_chroot(const struct path *path)
 #ifdef CONFIG_KEYS
 #ifdef CONFIG_SECURITY
 
+int security_key_create_or_update(struct key *keyring, struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags, bool create);
 int security_key_alloc(struct key *key, const struct cred *cred, unsigned long flags);
 void security_key_free(struct key *key);
 int security_key_permission(key_ref_t key_ref,
@@ -1680,6 +1683,13 @@ int security_key_getsecurity(struct key *key, char **_buffer);
 
 #else
 
+int security_key_create_or_update(struct key *keyring, struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags, bool create)
+{
+	return 0;
+}
+
 static inline int security_key_alloc(struct key *key,
 				     const struct cred *cred,
 				     unsigned long flags)
diff --git a/security/keys/key.c b/security/keys/key.c
index 764f4c57913e..b913feaf196e 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -781,7 +781,7 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
 }
 
 /**
- * key_create_or_update - Update or create and instantiate a key.
+ * __key_create_or_update - Update or create and instantiate a key.
  * @keyring_ref: A pointer to the destination keyring with possession flag.
  * @type: The type of key.
  * @description: The searchable description for the key.
@@ -789,6 +789,8 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
  * @plen: The length of @payload.
  * @perm: The permissions mask for a new key.
  * @flags: The quota flags for a new key.
+ * @create: Set to true if the key was newly created.
+ *          Set to false if the key was updated.
  *
  * Search the destination keyring for a key of the same description and if one
  * is found, update it, otherwise create and instantiate a new one and create a
@@ -805,13 +807,14 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
  * On success, the possession flag from the keyring ref will be tacked on to
  * the key ref before it is returned.
  */
-key_ref_t key_create_or_update(key_ref_t keyring_ref,
-			       const char *type,
-			       const char *description,
-			       const void *payload,
-			       size_t plen,
-			       key_perm_t perm,
-			       unsigned long flags)
+static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
+					const char *type,
+					const char *description,
+					const void *payload,
+					size_t plen,
+					key_perm_t perm,
+					unsigned long flags,
+					bool *create)
 {
 	struct keyring_index_key index_key = {
 		.description	= description,
@@ -936,6 +939,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	*create = true;
 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
 
 error_link_end:
@@ -948,7 +952,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 error:
 	return key_ref;
 
- found_matching_key:
+found_matching_key:
 	/* we found a matching key, so we're going to try to update it
 	 * - we can drop the locks first as we have the key pinned
 	 */
@@ -964,9 +968,65 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		}
 	}
 
+	*create = false;
 	key_ref = __key_update(key_ref, &prep);
 	goto error_free_prep;
 }
+
+/**
+ * key_create_or_update - Update or create and instantiate a key.
+ * @keyring_ref: A pointer to the destination keyring with possession flag.
+ * @type: The type of key.
+ * @description: The searchable description for the key.
+ * @payload: The data to use to instantiate or update the key.
+ * @plen: The length of @payload.
+ * @perm: The permissions mask for a new key.
+ * @flags: The quota flags for a new key.
+ *
+ * Calls the internal function __key_create_or_update.
+ * If successful calls the security LSM hook.
+ */
+key_ref_t key_create_or_update(key_ref_t keyring_ref,
+			       const char *type,
+			       const char *description,
+			       const void *payload,
+			       size_t plen,
+			       key_perm_t perm,
+			       unsigned long flags)
+{
+	key_ref_t key_ref;
+	struct key *keyring, *key = NULL;
+	int ret = 0;
+	bool create = false;
+
+	key_ref = __key_create_or_update(keyring_ref, type, description,
+					 payload, plen, perm, flags,
+					 &create);
+	if (IS_ERR(key_ref))
+		goto out;
+
+	keyring = key_ref_to_ptr(keyring_ref);
+	key = key_ref_to_ptr(key_ref);
+
+	/* let the security module know about
+	 * the created or updated key.
+	 */
+	ret = security_key_create_or_update(keyring, key,
+					    current_cred(),
+					    flags, create);
+	if (ret < 0)
+		goto security_error;
+	else
+		goto out;
+
+security_error:
+	key_unlink(keyring, key);
+	key_put(key);
+	key_ref = ERR_PTR(ret);
+
+out:
+	return key_ref;
+}
 EXPORT_SYMBOL(key_create_or_update);
 
 /**
diff --git a/security/security.c b/security/security.c
index 250ee2d76406..fc1e4984fb53 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2280,6 +2280,14 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 
 #ifdef CONFIG_KEYS
 
+int security_key_create_or_update(struct key *keyring, struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags, bool create)
+{
+	return call_int_hook(key_create_or_update, 0,
+			     keyring, key, cred, flags, create);
+}
+
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-- 
2.17.1

