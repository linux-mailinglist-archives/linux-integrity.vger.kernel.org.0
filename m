Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C26E0F0B
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 02:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbfJWAS0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Oct 2019 20:18:26 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45294 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732286AbfJWASZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Oct 2019 20:18:25 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id E95142010AC7;
        Tue, 22 Oct 2019 17:18:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E95142010AC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571789905;
        bh=IPbDEriMVz33Apnnpw3koY2My/6+Zihb+a8aOw3IrZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e3oF84acreEnePlHEqDJz62oy6fZyLD4xGnTB9Kp+hhfWDIQG7EBSjmicaJBnrDlE
         /ZSZ/5EL9gUynNlVWtvagcompoOYknFdgjZnKGMFFdex4yv7hboYbuzirYE58Nlkjh
         5Gql6mmNWYmgUvHvwnTRo0xv58d0W9bkaJZy0niY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v1 5/6] KEYS: measure queued keys
Date:   Tue, 22 Oct 2019 17:18:17 -0700
Message-Id: <20191023001818.3684-6-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023001818.3684-1-nramas@linux.microsoft.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Call process_buffer_measurement to measure keys that
are added and updated in the system.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c  | 23 +++++++++++++++++++++
 security/integrity/ima/ima_queue.c | 32 ++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8e965d18fb21..7c2afb954f19 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -678,6 +678,29 @@ void ima_kexec_cmdline(const void *buf, int size)
 	}
 }
 
+/*
+ * ima_post_key_create_or_update
+ * @keyring points to the keyring to which the key belongs
+ * @key points to the key being created or updated
+ * @cred cred structure
+ * @flags flags passed to key_create_or_update function
+ * @create flag to indicate whether the key was created or updated
+ *
+ * IMA hook called when a new key is created or updated.
+ *
+ * On success return 0.
+ * Return appropriate error code on error
+ */
+int ima_post_key_create_or_update(struct key *keyring, struct key *key,
+				  const struct cred *cred,
+				  unsigned long flags, bool create)
+{
+	if (key->type != &key_type_asymmetric)
+		return 0;
+
+	return ima_measure_key(keyring, key);
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index a262e289615b..0da11a292f99 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -322,7 +322,12 @@ static struct ima_trusted_key_entry *ima_alloc_trusted_queue_entry(
 int ima_measure_key(struct key *keyring, struct key *key)
 {
 	int rc = 0;
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	struct ima_template_desc *template_desc = ima_template_desc_current();
+	int action;
 	struct ima_trusted_key_entry *entry = NULL;
+	const struct public_key *pk;
+	u32 secid;
 	enum ima_hooks func;
 	bool queued = false;
 
@@ -344,16 +349,43 @@ int ima_measure_key(struct key *keyring, struct key *key)
 
 	mutex_unlock(&ima_trusted_keys_mutex);
 
+	if ((rc == 0) && !queued) {
+		security_task_getsecid(current, &secid);
+		action = ima_get_action(NULL, current_cred(), secid, 0,
+					func, &pcr, &template_desc);
+		if (action & IMA_MEASURE) {
+			pk = key->payload.data[asym_crypto];
+			process_buffer_measurement(pk->key, pk->keylen,
+						   key->description,
+						   pcr, template_desc);
+		}
+	}
+
 	return rc;
 }
 
 void ima_measure_queued_trusted_keys(void)
 {
 	struct ima_trusted_key_entry *entry, *tmp;
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	struct ima_template_desc *template_desc = ima_template_desc_current();
+	int action;
+	u32 secid;
 
 	mutex_lock(&ima_trusted_keys_mutex);
 
 	list_for_each_entry_safe(entry, tmp, &ima_trusted_keys, list) {
+		security_task_getsecid(current, &secid);
+		action = ima_get_action(NULL, current_cred(), secid, 0,
+					entry->func, &pcr,
+					&template_desc);
+		if (action & IMA_MEASURE) {
+			process_buffer_measurement(entry->public_key,
+						   entry->public_key_len,
+						   entry->key_description,
+						   pcr,
+						   template_desc);
+		}
 		list_del(&entry->list);
 		ima_free_trusted_key_entry(entry);
 	}
-- 
2.17.1

