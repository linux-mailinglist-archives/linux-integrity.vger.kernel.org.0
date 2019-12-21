Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4278912867C
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Dec 2019 02:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLUBxC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Dec 2019 20:53:02 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40984 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfLUBxC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Dec 2019 20:53:02 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id D22042010BB8;
        Fri, 20 Dec 2019 17:53:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D22042010BB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576893180;
        bh=cuOPS1a1SFW5TXYIhfieprlMSuE6xnpflHJl+P5ctaQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Ynno/VYSsvUIVj7ESD83j+56qW9ak6JHZ2rNaIdEbggIh/v3r8xS9zarEF6PojO81
         YNIGLi/P2xYYiVrRFJBGDzp+rbwwCS4w6YUnUD0zPVhYEaJ8f9D8a980o+y2g0z2k4
         nrh+svRjjI6ZtUXjA2+vhpJew8W/tiKZUQcyhQVw=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH] IMA: Defined timer to process queued keys
Date:   Fri, 20 Dec 2019 17:52:56 -0800
Message-Id: <20191221015256.2775-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

keys queued for measurement should still be processed even if
a custom IMA policy was not loaded. Otherwise, the keys will
remain queued forever consuming kernel memory.

This patch defines a timer to handle the above scenario. The timer
is setup to expire 5 minutes after IMA initialization is completed.

If a custom IMA policy is loaded before the timer expires, the timer
is removed and any queued keys are processed. But if a custom policy
was not loaded, on timer expiration any queued keys are processed.

On timer expiration the keys are still processed. This will enable
keys to be measured in case the built-in IMA policy defines a key
measurement rule.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h                 |  2 ++
 security/integrity/ima/ima_asymmetric_keys.c | 34 ++++++++++++++++++++
 security/integrity/ima/ima_init.c            |  8 ++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 97f8a4078483..c483215a9ee5 100644
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
 #endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
 
 /* LIM API function definitions */
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 4124f10ff0c2..92a7dcdf39a0 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/timer.h>
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
@@ -26,6 +27,34 @@ static bool ima_process_keys;
 static DEFINE_MUTEX(ima_keys_mutex);
 static LIST_HEAD(ima_keys);
 
+/*
+ * If custom IMA policy is not loaded then keys queued up
+ * for measurement should be freed. This timer is used
+ * for handling this scenario.
+ */
+static long ima_key_queue_timeout = 300000; /* 5 Minutes */
+static struct timer_list ima_key_queue_timer;
+
+/*
+ * This timer callback function processes keys that may still be
+ * queued up in case custom IMA policy was not loaded.
+ */
+static void ima_timer_handler(struct timer_list *timer)
+{
+	ima_process_queued_keys();
+}
+
+/*
+ * This function sets up a timer to process queued keys in case
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
@@ -120,6 +149,11 @@ void ima_process_queued_keys(void)
 	if (!process)
 		return;
 
+	/*
+	 * Timer is no longer needed since queued keys will be processed now.
+	 */
+	del_timer(&ima_key_queue_timer);
+
 	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
 		process_buffer_measurement(entry->payload, entry->payload_len,
 					   entry->keyring_name, KEY_CHECK, 0,
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

