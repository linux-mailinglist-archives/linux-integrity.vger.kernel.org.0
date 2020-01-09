Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A419135197
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jan 2020 03:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgAICoE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jan 2020 21:44:04 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55050 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgAICoD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jan 2020 21:44:03 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1E93220B479D;
        Wed,  8 Jan 2020 18:44:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E93220B479D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578537843;
        bh=59YyHVNcW/QdFRQ8i/3QqqsbF0Ns+ie/nKbZAKZnaZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7Kl3zdZeFLZztO2dX1GYPwdNYFQhmX1U4YOogH4NuHdt4wtC1/2B8KcfnVb7Ju2a
         LBGyKLlw5Hfqea+OA5FAUo7toQGgS/1sRaUGennmSihmpACSZmmgZUp6URNBhNL8Vq
         mSWPN0e6rbS047N1rS68GdQnZck3o+ogJZ8WJDJw=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, arnd@arndb.de, matthewgarrett@google.com,
        sashal@kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v8 3/3] IMA: Defined timer to free queued keys
Date:   Wed,  8 Jan 2020 18:43:59 -0800
Message-Id: <20200109024359.3410-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109024359.3410-1-nramas@linux.microsoft.com>
References: <20200109024359.3410-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

keys queued for measurement should be freed if a custom IMA policy
was not loaded. Otherwise, the keys will remain queued forever
consuming kernel memory.

This patch defines a timer to handle the above scenario. The timer
is setup to expire 5 minutes after IMA initialization is completed.

If a custom IMA policy is loaded before the timer expires, the timer
is removed and any queued keys are processed for measurement.
But if a custom policy was not loaded, on timer expiration
queued keys are just freed.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: kernel test robot <rong.a.chen@intel.com> # sleeping
function called from invalid context
Reported-by: kbuild test robot <lkp@intel.com> # redefinition of
ima_init_key_queue() function.
---
 security/integrity/ima/ima.h                 |  2 +
 security/integrity/ima/ima_asymmetric_keys.c | 42 ++++++++++++++++++--
 security/integrity/ima/ima_init.c            |  8 +++-
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c7fdf3d66b98..6bb3152b3e24 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -216,8 +216,10 @@ struct ima_key_entry {
 	char *keyring_name;
 };
 void ima_process_queued_keys(void);
+void ima_init_key_queue(void);
 #else
 static inline void ima_process_queued_keys(void) {}
+static inline void ima_init_key_queue(void) {}
 #endif /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
 
 /* LIM API function definitions */
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index eb71cbf224c1..d1fa1706e03f 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/timer.h>
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
@@ -26,6 +27,36 @@ static bool ima_process_keys;
 static DEFINE_SPINLOCK(ima_keys_lock);
 static LIST_HEAD(ima_keys);
 
+/*
+ * If custom IMA policy is not loaded then keys queued up
+ * for measurement should be freed. This timer is used
+ * for handling this scenario.
+ */
+static long ima_key_queue_timeout = 300000; /* 5 Minutes */
+static struct timer_list ima_key_queue_timer;
+static bool timer_expired;
+
+/*
+ * This timer callback function frees keys that may still be
+ * queued up in case custom IMA policy was not loaded.
+ */
+static void ima_timer_handler(struct timer_list *timer)
+{
+	timer_expired = true;
+	ima_process_queued_keys();
+}
+
+/*
+ * This function sets up a timer to free queued keys in case
+ * custom IMA policy was never loaded.
+ */
+void ima_init_key_queue(void)
+{
+	timer_setup(&ima_key_queue_timer, ima_timer_handler, 0);
+	mod_timer(&ima_key_queue_timer,
+		  jiffies + msecs_to_jiffies(ima_key_queue_timeout));
+}
+
 static void ima_free_key_entry(struct ima_key_entry *entry)
 {
 	if (entry) {
@@ -120,10 +151,15 @@ void ima_process_queued_keys(void)
 	if (!process)
 		return;
 
+	del_timer(&ima_key_queue_timer);
+
 	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
-		process_buffer_measurement(entry->payload, entry->payload_len,
-					   entry->keyring_name, KEY_CHECK, 0,
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
-- 
2.17.1

