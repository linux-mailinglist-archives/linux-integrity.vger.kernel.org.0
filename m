Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF3EE2715
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 01:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408013AbfJWXj6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 19:39:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51372 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392752AbfJWXj5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 19:39:57 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 36CA42010AC3;
        Wed, 23 Oct 2019 16:39:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36CA42010AC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571873996;
        bh=TjZgExhOyS9lfgObayA5QjipEv197/miPQlmIXuI1sA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YD86IyjKkhcI2P1ZCoFpu3HtiH16eqctPx7rSgxp5L+9pPxQtOiKu2JCUk4j7lX8r
         +ySdN4SKkhxI7FX8RHT4MzbVHbmAl+HC7rltIXVFeaUS2AywG4DZ70864VbM/n2+3T
         dNDhG7EAoEJxHfh5hzgvHBpebuptE6TEhzbOADA0=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v2 2/4] KEYS: Queue key for measurement if ima is not initialized. Measure queued keys when ima is initialized
Date:   Wed, 23 Oct 2019 16:39:48 -0700
Message-Id: <20191023233950.22072-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023233950.22072-1-nramas@linux.microsoft.com>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Defined functions to queue key for measurement if ima is not yet
initialized. ima hook function ima_post_key_create_or_update will
queue the key if ima is not yet initialized.

Process queued keys and measure them when ima initialization
is completed.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h       | 13 +++++
 security/integrity/ima/ima_init.c  |  9 ++-
 security/integrity/ima/ima_main.c  |  4 +-
 security/integrity/ima/ima_queue.c | 94 ++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 2d4130ff5655..38279707632a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -199,6 +199,17 @@ enum ima_hooks {
 	__ima_hooks(__ima_hook_enumify)
 };
 
+/*
+ * To track trusted keys that need to be measured when IMA is initialized.
+ */
+struct ima_trusted_key_entry {
+	struct list_head list;
+	void *public_key;
+	u32  public_key_len;
+	char *key_description;
+	enum ima_hooks func;
+};
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
@@ -225,6 +236,8 @@ int ima_store_template(struct ima_template_entry *entry, int violation,
 		       const unsigned char *filename, int pcr);
 void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
+int ima_queue_key_for_measurement(struct key *key, enum ima_hooks func);
+void ima_measure_queued_keys(void);
 
 /* IMA policy related functions */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 52847ce765a4..8734ed5322c7 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -132,5 +132,12 @@ int __init ima_init(void)
 
 	ima_init_policy();
 
-	return ima_fs_init();
+	rc = ima_fs_init();
+	if (rc != 0)
+		return rc;
+
+	ima_initialized = true;
+
+	ima_measure_queued_keys();
+	return 0;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8bde12385912..bce430b3386e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -710,8 +710,10 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (key->type != &key_type_asymmetric)
 		return;
 
-	if (!ima_initialized)
+	if (!ima_initialized) {
+		ima_queue_key_for_measurement(key, NONE);
 		return;
+	}
 
 	pk = key->payload.data[asym_crypto];
 	process_buffer_measurement(pk->key, pk->keylen,
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 1ce8b1701566..d42987022c12 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -46,6 +46,13 @@ struct ima_h_table ima_htable = {
  */
 static DEFINE_MUTEX(ima_extend_list_mutex);
 
+/*
+ * Used to synchronize access to the list of trusted keys (ima_trusted_keys)
+ * that need to be measured when IMA is initialized.
+ */
+static DEFINE_MUTEX(ima_trusted_keys_mutex);
+static LIST_HEAD(ima_trusted_keys);
+
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 						       int pcr)
@@ -232,3 +239,90 @@ int __init ima_init_digests(void)
 
 	return 0;
 }
+
+static void ima_free_trusted_key_entry(struct ima_trusted_key_entry *entry)
+{
+	if (entry != NULL) {
+		if (entry->public_key != NULL)
+			kzfree(entry->public_key);
+		if (entry->key_description != NULL)
+			kzfree(entry->key_description);
+		kzfree(entry);
+	}
+}
+
+static struct ima_trusted_key_entry *ima_alloc_trusted_queue_entry(
+	struct key *key,
+	enum ima_hooks func)
+{
+	int rc = 0;
+	const struct public_key *pk;
+	size_t key_description_len;
+	struct ima_trusted_key_entry *entry = NULL;
+
+	pk = key->payload.data[asym_crypto];
+	key_description_len = strlen(key->description) + 1;
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (entry != NULL) {
+		entry->public_key = kzalloc(pk->keylen, GFP_KERNEL);
+		entry->key_description =
+			kzalloc(key_description_len, GFP_KERNEL);
+	}
+
+	if ((entry == NULL) || (entry->public_key == NULL) ||
+	    (entry->key_description == NULL)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	strcpy(entry->key_description, key->description);
+	memcpy(entry->public_key, pk->key, pk->keylen);
+	entry->public_key_len = pk->keylen;
+	entry->func = func;
+	rc = 0;
+
+out:
+	if (rc) {
+		ima_free_trusted_key_entry(entry);
+		entry = NULL;
+	}
+
+	return entry;
+}
+
+int ima_queue_key_for_measurement(struct key *key, enum ima_hooks func)
+{
+	int rc = 0;
+	struct ima_trusted_key_entry *entry = NULL;
+
+	mutex_lock(&ima_trusted_keys_mutex);
+
+	entry = ima_alloc_trusted_queue_entry(key, func);
+	if (entry != NULL) {
+		INIT_LIST_HEAD(&entry->list);
+		list_add_tail(&entry->list, &ima_trusted_keys);
+	} else
+		rc = -ENOMEM;
+
+	mutex_unlock(&ima_trusted_keys_mutex);
+
+	return rc;
+}
+
+void ima_measure_queued_keys(void)
+{
+	struct ima_trusted_key_entry *entry, *tmp;
+
+	mutex_lock(&ima_trusted_keys_mutex);
+
+	list_for_each_entry_safe(entry, tmp, &ima_trusted_keys, list) {
+		process_buffer_measurement(entry->public_key,
+					   entry->public_key_len,
+					   entry->key_description,
+					   NONE, 0);
+		list_del(&entry->list);
+		ima_free_trusted_key_entry(entry);
+	}
+
+	mutex_unlock(&ima_trusted_keys_mutex);
+}
-- 
2.17.1

