Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61464E0F13
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 02:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbfJWASh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Oct 2019 20:18:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45298 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732315AbfJWAS0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Oct 2019 20:18:26 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B7132010AC8;
        Tue, 22 Oct 2019 17:18:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B7132010AC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571789905;
        bh=l3/xpxDJDNPHhTjWJ68OgeQThxUX96N97fTeydZwHaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFw4V83FIRb9/kKNS80AHaLOAxb18GAxUAoHQDsmgtjgeYqh4zjQTx/5eHQBz4A7W
         sg6wHJlSkrhtKDNqK5vSXxOCCWZiJYGcF3MRPLdr7YJmMvV9VOlZyVAtHySJPZsNT8
         59WqKDVFBJd8zSoyI1OXfNViIfpKYIPGQcm2ymUY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v1 6/6] KEYS: measure keys when they are created or updated
Date:   Tue, 22 Oct 2019 17:18:18 -0700
Message-Id: <20191023001818.3684-7-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023001818.3684-1-nramas@linux.microsoft.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A new LSM function namely, security_key_create_or_update, has
been added. This function is called by key_create_or_update
function when a new key is created or an existing key is updated.
This call is made when the key has been instantiated and linked
to the target keyring.

security_key_create_or_update is passed the target keyring, key,
key creation flags, and a boolean flag indicating whether
the key was newly created or an existing key was updated.
This function calls the ima function ima_post_key_create_or_update
to measure the key.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/ima.h      | 15 +++++++-
 include/linux/security.h | 13 ++++++-
 security/keys/key.c      | 78 +++++++++++++++++++++++++++++++++++-----
 security/security.c      | 10 ++++++
 4 files changed, 105 insertions(+), 11 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index a20ad398d260..ce763901380d 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -24,7 +24,11 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_kexec_cmdline(const void *buf, int size);
-
+extern int ima_post_key_create_or_update(struct key *keyring,
+					 struct key *key,
+					 const struct cred *cred,
+					 unsigned long flags,
+					 bool create);
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
@@ -91,6 +95,15 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 }
 
 static inline void ima_kexec_cmdline(const void *buf, int size) {}
+
+static inline int ima_post_key_create_or_update(struct key *keyring,
+						struct key *key,
+						const struct cred *cred,
+						unsigned long flags,
+						bool create)
+{
+	return 0;
+}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f7441abbf42..c8348da3db2e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1677,7 +1677,9 @@ void security_key_free(struct key *key);
 int security_key_permission(key_ref_t key_ref,
 			    const struct cred *cred, unsigned perm);
 int security_key_getsecurity(struct key *key, char **_buffer);
-
+int security_key_create_or_update(struct key *keyring, struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags, bool create);
 #else
 
 static inline int security_key_alloc(struct key *key,
@@ -1704,6 +1706,15 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 	return 0;
 }
 
+static inline int security_key_create_or_update(struct key *keyring,
+						struct key *key,
+						const struct cred *cred,
+						unsigned long flags,
+						bool create)
+{
+	return 0;
+}
+
 #endif
 #endif /* CONFIG_KEYS */
 
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
index 250ee2d76406..707a9e7fa94d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2303,6 +2303,16 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 	return call_int_hook(key_getsecurity, 0, key, _buffer);
 }
 
+int security_key_create_or_update(struct key *keyring,
+				  struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags,
+				  bool create)
+{
+	return ima_post_key_create_or_update(keyring, key, cred,
+					     flags, create);
+}
+
 #endif	/* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
-- 
2.17.1

