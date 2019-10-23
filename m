Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8A5E2713
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 01:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408054AbfJWXj6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 19:39:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51382 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392753AbfJWXj5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 19:39:57 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 637492010AC4;
        Wed, 23 Oct 2019 16:39:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 637492010AC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571873996;
        bh=4yuZ3A83R6RFlsx6gkiQGFNvjYib+E4kbmtDInCBuro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkAu7fQ7I+graidZ9eAuzXf6HTZdF7thexx9nZbcpJYzqslvwvF5abLWdcT0BVC2t
         6dvc0xpaWI8WAtcTVoH173/wu/lGmpccS+4IjXqxsXBK28zHmixUqEGCd7CTD4cu3u
         K1KtolbAMdVLCHdBpJBAyd5sHXj4jNXz/Wz2/sRA=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v2 3/4] KEYS: Added BUILTIN_TRUSTED_KEYS enum to measure keys added to builtin_trusted_keys keyring
Date:   Wed, 23 Oct 2019 16:39:49 -0700
Message-Id: <20191023233950.22072-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023233950.22072-1-nramas@linux.microsoft.com>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Added an ima policy hook BUILTIN_TRUSTED_KEYS to measure keys added
to builtin_trusted_keys keyring.

Added a helper function to check if the given keyring is
the builtin_trusted_keys keyring.

Defined a function to map the keyring to ima policy hook function
and use it when measuring the key.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  1 +
 certs/system_keyring.c               |  5 +++++
 include/keys/system_keyring.h        |  2 ++
 security/integrity/ima/ima.h         |  2 ++
 security/integrity/ima/ima_api.c     |  1 +
 security/integrity/ima/ima_main.c    | 25 +++++++++++++++++++++++--
 security/integrity/ima/ima_queue.c   |  2 +-
 7 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index fc376a323908..25566c74e679 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,6 +29,7 @@ Description:
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE]
+				[BUILTIN_TRUSTED_KEYS]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 1eba08a1af82..5533c7f92fef 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -283,3 +283,8 @@ void __init set_platform_trusted_keys(struct key *keyring)
 	platform_trusted_keys = keyring;
 }
 #endif
+
+inline bool is_builtin_trusted_keyring(struct key *keyring)
+{
+	return (keyring == builtin_trusted_keys);
+}
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index c1a96fdf598b..2bc0aaa07f05 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -66,4 +66,6 @@ static inline void set_platform_trusted_keys(struct key *keyring)
 }
 #endif
 
+extern bool is_builtin_trusted_keyring(struct key *keyring);
+
 #endif /* _KEYS_SYSTEM_KEYRING_H */
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 38279707632a..92c25a6b4da7 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -23,6 +23,7 @@
 #include <crypto/hash_info.h>
 #include <crypto/public_key.h>
 #include <keys/asymmetric-type.h>
+#include <keys/system_keyring.h>
 
 #include "../integrity.h"
 
@@ -192,6 +193,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
 	hook(KEXEC_CMDLINE)		\
+	hook(BUILTIN_TRUSTED_KEYS)	\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index f614e22bf39f..cc04706b7e7a 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -175,6 +175,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
  *	| KEXEC_CMDLINE
+ *	| BUILTIN_TRUSTED_KEYS
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index bce430b3386e..986f80eead4d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -605,6 +605,24 @@ int ima_load_data(enum kernel_load_data_id id)
 	return 0;
 }
 
+/*
+ * Maps the given keyring to a IMA Hook.
+ * @keyring: A keyring to which a key maybe linked to.
+ *
+ * This function currently handles only builtin_trusted_keys.
+ * To handle more keyrings, this function, ima hook and
+ * ima policy handler need to be updated.
+ */
+static enum ima_hooks keyring_policy_map(struct key *keyring)
+{
+	enum ima_hooks func = NONE;
+
+	if (is_builtin_trusted_keyring(keyring))
+		func = BUILTIN_TRUSTED_KEYS;
+
+	return func;
+}
+
 /*
  * process_buffer_measurement - Measure the buffer to ima log.
  * @buf: pointer to the buffer that needs to be added to the log.
@@ -706,19 +724,22 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   unsigned long flags, bool create)
 {
 	const struct public_key *pk;
+	enum ima_hooks func;
 
 	if (key->type != &key_type_asymmetric)
 		return;
 
+	func = keyring_policy_map(keyring);
+
 	if (!ima_initialized) {
-		ima_queue_key_for_measurement(key, NONE);
+		ima_queue_key_for_measurement(key, func);
 		return;
 	}
 
 	pk = key->payload.data[asym_crypto];
 	process_buffer_measurement(pk->key, pk->keylen,
 				   key->description,
-				   NONE, 0);
+				   func, 0);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index d42987022c12..ed77c4dc0520 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -319,7 +319,7 @@ void ima_measure_queued_keys(void)
 		process_buffer_measurement(entry->public_key,
 					   entry->public_key_len,
 					   entry->key_description,
-					   NONE, 0);
+					   entry->func, 0);
 		list_del(&entry->list);
 		ima_free_trusted_key_entry(entry);
 	}
-- 
2.17.1

