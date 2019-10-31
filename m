Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65AC3EA8B9
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 02:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfJaBTz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Oct 2019 21:19:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34418 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfJaBTS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Oct 2019 21:19:18 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id DC23F20B4902;
        Wed, 30 Oct 2019 18:19:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC23F20B4902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572484757;
        bh=ZRFpbgsDbjA1XcnoStH4tyuW3IfSbLxQM+i2Js18XJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcqWxn18jquwKg2h8QjAPd1AX6sd7RAixafXpPaRmtZ1XjIbazhBQMLOY+JBIIoEZ
         6r1VttW6DW957PbX2g4NA9d5QasQl87tO6YM9SVYLFSvaM+N+JTaQe9L5BKlOZIgVQ
         K3ioxg55/QHcv1C+u01SbvJvoQCY3MApNsHVwlVw=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
Subject: [PATCH v3 2/9] KEYS: Defined functions to queue and dequeue keys for measurement
Date:   Wed, 30 Oct 2019 18:19:03 -0700
Message-Id: <20191031011910.2574-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Key measurements cannot be done if the IMA hook to measure keys is
called before IMA is initialized. Key measurement needs to be deferred
if IMA is not yet initialized. Queued keys need to be processed when
IMA initialization is completed.

This patch defines functions to queue and de-queue keys for measurement.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h       | 12 ++++
 security/integrity/ima/ima_queue.c | 92 ++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 22d0628faf56..b9600070e415 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -198,6 +198,16 @@ enum ima_hooks {
 	__ima_hooks(__ima_hook_enumify)
 };
 
+/*
+ * To track keys that need to be measured.
+ */
+struct ima_measure_key_entry {
+	struct list_head list;
+	void *public_key;
+	u32  public_key_len;
+	char *keyring_name;
+};
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
@@ -224,6 +234,8 @@ int ima_store_template(struct ima_template_entry *entry, int violation,
 		       const unsigned char *filename, int pcr);
 void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
+int ima_queue_key_for_measurement(struct key *keyring, struct key *key);
+void ima_measure_queued_keys(void);
 
 /* IMA policy related functions */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 1ce8b1701566..f2503f10abf4 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -46,6 +46,12 @@ struct ima_h_table ima_htable = {
  */
 static DEFINE_MUTEX(ima_extend_list_mutex);
 
+/*
+ * To synchronize access to the list of keys that need to be measured
+ */
+static DEFINE_MUTEX(ima_measure_keys_mutex);
+static LIST_HEAD(ima_measure_keys);
+
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 						       int pcr)
@@ -232,3 +238,89 @@ int __init ima_init_digests(void)
 
 	return 0;
 }
+
+static void ima_free_measure_key_entry(struct ima_measure_key_entry *entry)
+{
+	if (entry != NULL) {
+		if (entry->public_key != NULL)
+			kzfree(entry->public_key);
+		if (entry->keyring_name != NULL)
+			kzfree(entry->keyring_name);
+		kzfree(entry);
+	}
+}
+
+static struct ima_measure_key_entry *ima_alloc_measure_key_entry(
+	struct key *keyring,
+	struct key *key)
+{
+	int rc = 0;
+	const struct public_key *pk;
+	size_t keyring_name_len;
+	struct ima_measure_key_entry *entry = NULL;
+
+	pk = key->payload.data[asym_crypto];
+	keyring_name_len = strlen(keyring->description) + 1;
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (entry != NULL) {
+		entry->public_key = kzalloc(pk->keylen, GFP_KERNEL);
+		entry->keyring_name =
+			kzalloc(keyring_name_len, GFP_KERNEL);
+	}
+
+	if ((entry == NULL) || (entry->public_key == NULL) ||
+	    (entry->keyring_name == NULL)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	strcpy(entry->keyring_name, keyring->description);
+	memcpy(entry->public_key, pk->key, pk->keylen);
+	entry->public_key_len = pk->keylen;
+	rc = 0;
+
+out:
+	if (rc) {
+		ima_free_measure_key_entry(entry);
+		entry = NULL;
+	}
+
+	return entry;
+}
+
+int ima_queue_key_for_measurement(struct key *keyring, struct key *key)
+{
+	int rc = 0;
+	struct ima_measure_key_entry *entry = NULL;
+
+	mutex_lock(&ima_measure_keys_mutex);
+
+	entry = ima_alloc_measure_key_entry(keyring, key);
+	if (entry != NULL) {
+		INIT_LIST_HEAD(&entry->list);
+		list_add_tail(&entry->list, &ima_measure_keys);
+	} else
+		rc = -ENOMEM;
+
+	mutex_unlock(&ima_measure_keys_mutex);
+
+	return rc;
+}
+
+void ima_measure_queued_keys(void)
+{
+	struct ima_measure_key_entry *entry, *tmp;
+
+	mutex_lock(&ima_measure_keys_mutex);
+
+	list_for_each_entry_safe(entry, tmp, &ima_measure_keys, list) {
+		process_buffer_measurement(entry->public_key,
+					   entry->public_key_len,
+					   entry->keyring_name,
+					   NONE, 0);
+		list_del(&entry->list);
+		ima_free_measure_key_entry(entry);
+	}
+
+	mutex_unlock(&ima_measure_keys_mutex);
+}
-- 
2.17.1

