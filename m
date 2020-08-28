Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD3B255E62
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 18:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgH1QA7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 12:00:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44752 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgH1QAe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 12:00:34 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id C8D502056538;
        Fri, 28 Aug 2020 09:00:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8D502056538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598630433;
        bh=OVsLX7cMAA0hODgZXzEJKAhHMWh2W75uRXiZplng/RA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNbbYAAwii8KuAcqgAiF25AQ3u/kPK8agQQzs+mt5pjjEqfKgZ47yZJuySB7b57QA
         mkOM+7RZiihu2s3WaE8wixAIGbCIqPI/Pq9zyHDjQSNPC0MTyA8N6IiRskwJ/QKN/z
         iPs7AHJF7n6mu/faxDbl330zdOqKGTrmkmrIW3DU=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] IMA: Support measurement of generic data during early boot
Date:   Fri, 28 Aug 2020 09:00:20 -0700
Message-Id: <20200828160021.11537-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200828160021.11537-1-nramas@linux.microsoft.com>
References: <20200828160021.11537-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Early boot measurement of data is currently very specific to key
measurement. To make it generic to handle any early boot data
measurement, additional arguments need to be saved in the queue
for deferred processing. This includes the IMA hook func,
data specific to the given func, and a boolean flag to indicate
whether the given payload needs to be measured or a hash of
the payload needs to be measured.

Add new fields to ima_data_entry struct to pass additional data for
the deferred handling of queued data. Update the queue functions to
handle the new data saved in the ima_data_entry struct.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h                 | 11 ++++++--
 security/integrity/ima/ima_asymmetric_keys.c |  3 ++-
 security/integrity/ima/ima_queue_data.c      | 28 ++++++++++++++------
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 872a06821c98..422fe833037d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -266,18 +266,25 @@ struct ima_data_entry {
 	void *payload;
 	size_t payload_len;
 	const char *event_name;
+	const char *event_data;
+	enum ima_hooks func;
+	bool measure_payload_hash;
 };
 void ima_init_data_queue(void);
 bool ima_should_queue_data(void);
 bool ima_queue_data(const char *event_name, const void *payload,
-		    size_t payload_len);
+		    size_t payload_len, const char *event_data,
+		    enum ima_hooks func, bool measure_payload_hash);
 void ima_process_queued_data(void);
 #else
 static inline void ima_init_data_queue(void) {}
 static inline bool ima_should_queue_data(void) { return false; }
 static inline bool ima_queue_data(const char *event_name,
 				  const void *payload,
-				  size_t payload_len) { return false; }
+				  size_t payload_len,
+				  const char *event_data,
+				  enum ima_hooks func,
+				  bool measure_payload_hash) { return false; }
 static inline void ima_process_queued_data(void) {}
 #endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_DATA */
 
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index d91fddec5ae8..65423754765f 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -39,7 +39,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 
 	if (ima_should_queue_data())
 		queued = ima_queue_data(keyring->description, payload,
-					payload_len);
+					payload_len, keyring->description,
+					KEY_CHECK, false);
 	if (queued)
 		return;
 
diff --git a/security/integrity/ima/ima_queue_data.c b/security/integrity/ima/ima_queue_data.c
index 563e26f66180..d466ee742377 100644
--- a/security/integrity/ima/ima_queue_data.c
+++ b/security/integrity/ima/ima_queue_data.c
@@ -60,6 +60,7 @@ static void ima_free_data_entry(struct ima_data_entry *entry)
 
 	kvfree(entry->payload);
 	kfree(entry->event_name);
+	kfree(entry->event_data);
 	kfree(entry);
 }
 
@@ -74,7 +75,10 @@ static void *ima_kvmemdup(const void *src, size_t len)
 
 static struct ima_data_entry *ima_alloc_data_entry(const char *event_name,
 						   const void *payload,
-						   size_t payload_len)
+						   size_t payload_len,
+						   const char *event_data,
+						   enum ima_hooks func,
+						   bool measure_payload_hash)
 {
 	struct ima_data_entry *entry;
 
@@ -88,9 +92,15 @@ static struct ima_data_entry *ima_alloc_data_entry(const char *event_name,
 	 */
 	entry->payload = ima_kvmemdup(payload, payload_len);
 	entry->event_name = kstrdup(event_name, GFP_KERNEL);
+	if (event_data)
+		entry->event_data = kstrdup(event_data, GFP_KERNEL);
+
 	entry->payload_len = payload_len;
+	entry->func = func;
+	entry->measure_payload_hash = measure_payload_hash;
 
-	if (!entry->payload || !entry->event_name)
+	if (!entry->payload || !entry->event_name ||
+		(event_data && !entry->event_data))
 		goto out;
 
 	INIT_LIST_HEAD(&entry->list);
@@ -98,19 +108,21 @@ static struct ima_data_entry *ima_alloc_data_entry(const char *event_name,
 
 out:
 	integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL,
-				event_name, func_measure_str(KEY_CHECK),
+				event_name, func_measure_str(func),
 				"ENOMEM", -ENOMEM, 0, -ENOMEM);
 	ima_free_data_entry(entry);
 	return NULL;
 }
 
 bool ima_queue_data(const char *event_name, const void *payload,
-		    size_t payload_len)
+		    size_t payload_len, const char *event_data,
+		    enum ima_hooks func, bool measure_payload_hash)
 {
 	bool queued = false;
 	struct ima_data_entry *entry;
 
-	entry = ima_alloc_data_entry(event_name, payload, payload_len);
+	entry = ima_alloc_data_entry(event_name, payload, payload_len,
+				     event_data, func, measure_payload_hash);
 	if (!entry)
 		return false;
 
@@ -165,9 +177,9 @@ void ima_process_queued_data(void)
 			process_buffer_measurement(NULL, entry->payload,
 						   entry->payload_len,
 						   entry->event_name,
-						   KEY_CHECK, 0,
-						   entry->event_name,
-						   false);
+						   entry->func, 0,
+						   entry->event_data,
+						   entry->measure_payload_hash);
 		list_del(&entry->list);
 		ima_free_data_entry(entry);
 	}
-- 
2.28.0

