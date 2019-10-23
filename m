Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF627E270B
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 01:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392756AbfJWXj5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 19:39:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51362 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392751AbfJWXj5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 19:39:57 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0E21620106BF;
        Wed, 23 Oct 2019 16:39:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E21620106BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571873996;
        bh=sVeuaw2KRkAf1CvJ/ee/ODALLBzP3mWEgOPtKKrnY/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtlTG7GMBYyeG0YstbTm8AEZu6XEkwEXnUXUl0pE6ekT99VgzJbBHG3xg9OfLyc2/
         9oT9Ov6uB77ZKD/kpMaPk5s6us16qm4xATgKrbFkSbRptdjihUut6S1OlqqTYL/grM
         Dc/IVCXAjz4OB7cIrxDFkqz5PFg8jTYaBAF4t45I=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v2 1/4] KEYS: Defined an ima hook for measuring keys on key create or update
Date:   Wed, 23 Oct 2019 16:39:47 -0700
Message-Id: <20191023233950.22072-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023233950.22072-1-nramas@linux.microsoft.com>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Defined an ima hook to measure keys created or updated in the system.

Call this ima hook from key_create_or_update function when a new key
is created or an existing key is updated.

ima hook calls process_buffer_measurement function to measure the key
if ima is initialized. If ima is not yet initialized, the ima hook
currently does nothing. The change to queue the key for measurement
and measure after ima is initialized is implemented in a later patch.

This patch set depends on the following patch set provided by
Nayna Jain from IBM (nayna@linux.ibm.com). That patch set is
currently being reviewed:

[PATCH v8 5/8] ima: make process_buffer_measurement() generic
https://lore.kernel.org/linux-integrity/1569594360-7141-7-git-send-email-nayna@linux.ibm.com/

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/ima.h               |  8 ++++++++
 security/integrity/ima/ima.h      |  3 +++
 security/integrity/ima/ima_init.c |  1 +
 security/integrity/ima/ima_main.c | 26 ++++++++++++++++++++++++++
 security/keys/key.c               |  9 +++++++++
 5 files changed, 47 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index a20ad398d260..4df39aefcd06 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -24,6 +24,9 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_kexec_cmdline(const void *buf, int size);
+extern void ima_post_key_create_or_update(struct key *keyring,
+					  struct key *key,
+					  unsigned long flags, bool create);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -91,6 +94,11 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 }
 
 static inline void ima_kexec_cmdline(const void *buf, int size) {}
+
+static inline void ima_post_key_create_or_update(struct key *keyring,
+						 struct key *key,
+						 unsigned long flags,
+						 bool create) {}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 997a57137351..2d4130ff5655 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -21,6 +21,8 @@
 #include <linux/tpm.h>
 #include <linux/audit.h>
 #include <crypto/hash_info.h>
+#include <crypto/public_key.h>
+#include <keys/asymmetric-type.h>
 
 #include "../integrity.h"
 
@@ -52,6 +54,7 @@ extern int ima_policy_flag;
 extern int ima_hash_algo;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
+extern bool ima_initialized;
 
 /* IMA event related data */
 struct ima_event_data {
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5d55ade5f3b9..52847ce765a4 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -23,6 +23,7 @@
 /* name for boot aggregate entry */
 static const char boot_aggregate_name[] = "boot_aggregate";
 struct tpm_chip *ima_tpm_chip;
+bool ima_initialized;
 
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2b60d8fd017a..8bde12385912 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -693,6 +693,32 @@ void ima_kexec_cmdline(const void *buf, int size)
 	}
 }
 
+/**
+ * ima_post_key_create_or_update - measure keys
+ * @keyring: keyring to which the key is linked to
+ * @key: created or updated key
+ * @flags: key flags
+ * @create: flag indicating whether the key was created or updated
+ *
+ * Keys can only be measured, not appraised.
+ */
+void ima_post_key_create_or_update(struct key *keyring, struct key *key,
+				   unsigned long flags, bool create)
+{
+	const struct public_key *pk;
+
+	if (key->type != &key_type_asymmetric)
+		return;
+
+	if (!ima_initialized)
+		return;
+
+	pk = key->payload.data[asym_crypto];
+	process_buffer_measurement(pk->key, pk->keylen,
+				   key->description,
+				   NONE, 0);
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/keys/key.c b/security/keys/key.c
index 764f4c57913e..7c39054d8da6 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/workqueue.h>
 #include <linux/random.h>
+#include <linux/ima.h>
 #include <linux/err.h>
 #include "internal.h"
 
@@ -936,6 +937,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	/* let the ima module know about the created key. */
+	ima_post_key_create_or_update(keyring, key, flags, true);
+
 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
 
 error_link_end:
@@ -965,6 +969,11 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	}
 
 	key_ref = __key_update(key_ref, &prep);
+	if (!IS_ERR(key_ref)) {
+		/* let the ima module know about the updated key. */
+		ima_post_key_create_or_update(keyring, key, flags, false);
+	}
+
 	goto error_free_prep;
 }
 EXPORT_SYMBOL(key_create_or_update);
-- 
2.17.1

