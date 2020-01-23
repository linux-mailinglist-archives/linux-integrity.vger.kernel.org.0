Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F3114605A
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2020 02:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgAWBcN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jan 2020 20:32:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55890 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgAWBcN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jan 2020 20:32:13 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id DCF4D20B479A;
        Wed, 22 Jan 2020 17:32:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCF4D20B479A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579743131;
        bh=/nY96uoMJp5UFNLYIHALLqmSHnbOJjuKRmMufwC67lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLJGHieEUym6AsETnkXTh8AQeVB67Um1sblhLxphFyGzN8N417Wue0Rj48P0vu1CH
         VWBOUTWlFpste+bRKvIwW9q5iPWYK2LUZwUjGTlOjuuv6Px+WcWVnOlwADzr6dVwqm
         XVhhIn4H9wM0JZhuAJ98YaQSxTFEAfuUwK9kQaNQ=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v9 3/3] IMA: Defined delayed workqueue to free the queued keys
Date:   Wed, 22 Jan 2020 17:32:06 -0800
Message-Id: <20200123013206.8499-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123013206.8499-1-nramas@linux.microsoft.com>
References: <20200123013206.8499-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keys queued for measurement should be freed if a custom IMA policy
was not loaded. Otherwise, the keys will remain queued forever
consuming kernel memory.

This patch defines a delayed workqueue to handle the above scenario.
The workqueue handler is setup to execute 5 minutes after IMA
initialization is completed.

If a custom IMA policy is loaded before the workqueue handler is
scheduled to execute, the workqueue task is cancelled and any queued keys
are processed for measurement. But if a custom policy was not loaded then
the queued keys are just freed when the delayed workqueue handler is run.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: kernel test robot <rong.a.chen@intel.com> # sleeping
function called from invalid context
Reported-by: kbuild test robot <lkp@intel.com> # redefinition of
ima_init_key_queue() function.
---
 security/integrity/ima/ima.h            |  2 ++
 security/integrity/ima/ima_init.c       |  8 ++++-
 security/integrity/ima/ima_queue_keys.c | 44 ++++++++++++++++++++++---
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 905ed2f7f778..64317d95363e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -215,11 +215,13 @@ struct ima_key_entry {
 	size_t payload_len;
 	char *keyring_name;
 };
+void ima_init_key_queue(void);
 bool ima_should_queue_key(void);
 bool ima_queue_key(struct key *keyring, const void *payload,
 		   size_t payload_len);
 void ima_process_queued_keys(void);
 #else
+static inline void ima_init_key_queue(void) {}
 static inline bool ima_should_queue_key(void) { return false; }
 static inline bool ima_queue_key(struct key *keyring,
 				 const void *payload,
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5d55ade5f3b9..195cb4079b2b 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -131,5 +131,11 @@ int __init ima_init(void)
 
 	ima_init_policy();
 
-	return ima_fs_init();
+	rc = ima_fs_init();
+	if (rc != 0)
+		return rc;
+
+	ima_init_key_queue();
+
+	return rc;
 }
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index 9b561f2b86db..c87c72299191 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/workqueue.h>
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
@@ -25,6 +26,36 @@ static bool ima_process_keys;
 static DEFINE_MUTEX(ima_keys_lock);
 static LIST_HEAD(ima_keys);
 
+/*
+ * If custom IMA policy is not loaded then keys queued up
+ * for measurement should be freed. This worker is used
+ * for handling this scenario.
+ */
+static long ima_key_queue_timeout = 300000; /* 5 Minutes */
+static void ima_keys_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(ima_keys_delayed_work, ima_keys_handler);
+static bool timer_expired;
+
+/*
+ * This worker function frees keys that may still be
+ * queued up in case custom IMA policy was not loaded.
+ */
+static void ima_keys_handler(struct work_struct *work)
+{
+	timer_expired = true;
+	ima_process_queued_keys();
+}
+
+/*
+ * This function sets up a worker to free queued keys in case
+ * custom IMA policy was never loaded.
+ */
+void ima_init_key_queue(void)
+{
+	schedule_delayed_work(&ima_keys_delayed_work,
+			      msecs_to_jiffies(ima_key_queue_timeout));
+}
+
 static void ima_free_key_entry(struct ima_key_entry *entry)
 {
 	if (entry) {
@@ -119,13 +150,16 @@ void ima_process_queued_keys(void)
 	if (!process)
 		return;
 
+	if (!timer_expired)
+		cancel_delayed_work_sync(&ima_keys_delayed_work);
 
 	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
-		process_buffer_measurement(entry->payload,
-					   entry->payload_len,
-					   entry->keyring_name,
-					   KEY_CHECK, 0,
-					   entry->keyring_name);
+		if (!timer_expired)
+			process_buffer_measurement(entry->payload,
+						   entry->payload_len,
+						   entry->keyring_name,
+						   KEY_CHECK, 0,
+						   entry->keyring_name);
 		list_del(&entry->list);
 		ima_free_key_entry(entry);
 	}
-- 
2.17.1

