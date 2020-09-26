Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD28E279A81
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Sep 2020 17:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgIZPw3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 26 Sep 2020 11:52:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54134 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbgIZPwZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 26 Sep 2020 11:52:25 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9366B2089F02;
        Sat, 26 Sep 2020 08:52:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9366B2089F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601135544;
        bh=4CxztS3xYrQ7EIhdx4psfcFPgeMST4qcZn0Rwd2tpzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDEntAkACl4E+d1FTOltvjuZDwEY2Mw81/v4FG+oyzpAfyO4FtI0lUt/skq07vlui
         WCtwSAs/atHSrPuiFgX/CTar625lMJni/b00buzAdLij8DQFtnLaGhbbD1Tfn3zhKk
         pbwCtGorf99TjfJzAUnKMKpGSS9cZWQHpgSfzyyI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] IMA: Support measurement of generic data during early
Date:   Sat, 26 Sep 2020 08:52:18 -0700
Message-Id: <20200926155219.5561-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926155219.5561-1-nramas@linux.microsoft.com>
References: <20200926155219.5561-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently, early boot measurement of data is specific to key
measurement. To make it generic to handle any early boot data
measurement, additional arguments need to be saved in the queue
for deferred processing. The arguments include the IMA hook func,
data specific to the given func, and a boolean flag to determine
if we need to measure the given payload or the hash of the payload.

Add new fields to ima_data_entry struct to pass additional data for
the deferred handling of queued data. Update the queue functions to
handle the new data saved in the ima_data_entry struct.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h                 |  6 ++++-
 security/integrity/ima/ima_asymmetric_keys.c |  3 ++-
 security/integrity/ima/ima_queue_data.c      | 28 ++++++++++++++------
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c5de937dc201..e99e5e0db720 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -265,11 +265,15 @@ struct ima_data_entry {
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
 
 /* LIM API function definitions */
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
index 88dfa7b439fd..4871ed3af436 100644
--- a/security/integrity/ima/ima_queue_data.c
+++ b/security/integrity/ima/ima_queue_data.c
@@ -69,6 +69,7 @@ static void ima_free_data_entry(struct ima_data_entry *entry)
 
 	kvfree(entry->payload);
 	kfree(entry->event_name);
+	kfree(entry->event_data);
 	kfree(entry);
 }
 
@@ -83,7 +84,10 @@ static void *ima_kvmemdup(const void *src, size_t len)
 
 static struct ima_data_entry *ima_alloc_data_entry(const char *event_name,
 						   const void *payload,
-						   size_t payload_len)
+						   size_t payload_len,
+						   const char *event_data,
+						   enum ima_hooks func,
+						   bool measure_payload_hash)
 {
 	struct ima_data_entry *entry;
 
@@ -97,9 +101,15 @@ static struct ima_data_entry *ima_alloc_data_entry(const char *event_name,
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
@@ -107,19 +117,21 @@ static struct ima_data_entry *ima_alloc_data_entry(const char *event_name,
 
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
 
@@ -174,9 +186,9 @@ void ima_process_queued_data(void)
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

