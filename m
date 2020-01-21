Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7561714432A
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jan 2020 18:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUR2e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jan 2020 12:28:34 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56564 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUR2e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jan 2020 12:28:34 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9297920B4798;
        Tue, 21 Jan 2020 09:28:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9297920B4798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579627713;
        bh=Yrzpkvb87TbXLvF9TfCIuBMOL56A/1WZiADnLtuAVf4=;
        h=From:To:Cc:Subject:Date:From;
        b=rpybvopkl+F0IZf7mLfyeDg5aeqQ1l1WbjT924CGZqpvc2RopdEIY6sFCtGvnd6Zo
         u0nwMqv4trWmeJz5tGTxoJQ8UMzkWmEaJWwy8mMwWCODikEf6KEW8kvJj6kbPewS0q
         L+U4Z6+8UOArHu24c0vRXec2Rz1EnXH8ajn5yeTo=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IMA: Use delayed work to free queued keys
Date:   Tue, 21 Jan 2020 09:28:29 -0800
Message-Id: <20200121172829.15152-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A timer is used to free queued keys if a custom IMA policy is not
loaded within 5 minutes after IMA subsystem is initialized. Timer
handler is called in interrupt context. Due to this a spinlock has
to be used to synchronize access to critical section. A mutex cannot
be used since a mutex can sleep.

This patch uses a delayed work to free queued keys. Since a delayed
work handler is called in process context a mutex can be used.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Fixes: 8f5d2d06f217 ("IMA: Defined timer to free queued keys")
---
 security/integrity/ima/ima_asymmetric_keys.c | 33 ++++++++++----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 381f51708e7b..fa1bdd54a9ff 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -11,7 +11,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
@@ -24,37 +24,37 @@ static bool ima_process_keys;
 /*
  * To synchronize access to the list of keys that need to be measured
  */
-static DEFINE_SPINLOCK(ima_keys_lock);
+static DEFINE_MUTEX(ima_keys_lock);
 static LIST_HEAD(ima_keys);
 
 /*
  * If custom IMA policy is not loaded then keys queued up
- * for measurement should be freed. This timer is used
+ * for measurement should be freed. This worker is used
  * for handling this scenario.
  */
 static long ima_key_queue_timeout = 300000; /* 5 Minutes */
-static struct timer_list ima_key_queue_timer;
+static void ima_keys_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(ima_keys_delayed_work, ima_keys_handler);
 static bool timer_expired;
 
 /*
- * This timer callback function frees keys that may still be
+ * This worker function frees keys that may still be
  * queued up in case custom IMA policy was not loaded.
  */
-static void ima_timer_handler(struct timer_list *timer)
+static void ima_keys_handler(struct work_struct *work)
 {
 	timer_expired = true;
 	ima_process_queued_keys();
 }
 
 /*
- * This function sets up a timer to free queued keys in case
+ * This function sets up a worker to free queued keys in case
  * custom IMA policy was never loaded.
  */
 void ima_init_key_queue(void)
 {
-	timer_setup(&ima_key_queue_timer, ima_timer_handler, 0);
-	mod_timer(&ima_key_queue_timer,
-		  jiffies + msecs_to_jiffies(ima_key_queue_timeout));
+	schedule_delayed_work(&ima_keys_delayed_work,
+			      msecs_to_jiffies(ima_key_queue_timeout));
 }
 
 static void ima_free_key_entry(struct ima_key_entry *entry)
@@ -103,18 +103,17 @@ static bool ima_queue_key(struct key *keyring, const void *payload,
 {
 	bool queued = false;
 	struct ima_key_entry *entry;
-	unsigned long flags;
 
 	entry = ima_alloc_key_entry(keyring, payload, payload_len);
 	if (!entry)
 		return false;
 
-	spin_lock_irqsave(&ima_keys_lock, flags);
+	mutex_lock(&ima_keys_lock);
 	if (!ima_process_keys) {
 		list_add_tail(&entry->list, &ima_keys);
 		queued = true;
 	}
-	spin_unlock_irqrestore(&ima_keys_lock, flags);
+	mutex_unlock(&ima_keys_lock);
 
 	if (!queued)
 		ima_free_key_entry(entry);
@@ -132,7 +131,6 @@ void ima_process_queued_keys(void)
 {
 	struct ima_key_entry *entry, *tmp;
 	bool process = false;
-	unsigned long flags;
 
 	if (ima_process_keys)
 		return;
@@ -143,17 +141,18 @@ void ima_process_queued_keys(void)
 	 * First one setting the ima_process_keys flag to true will
 	 * process the queued keys.
 	 */
-	spin_lock_irqsave(&ima_keys_lock, flags);
+	mutex_lock(&ima_keys_lock);
 	if (!ima_process_keys) {
 		ima_process_keys = true;
 		process = true;
 	}
-	spin_unlock_irqrestore(&ima_keys_lock, flags);
+	mutex_unlock(&ima_keys_lock);
 
 	if (!process)
 		return;
 
-	del_timer(&ima_key_queue_timer);
+	if (!timer_expired)
+		cancel_delayed_work_sync(&ima_keys_delayed_work);
 
 	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
 		if (!timer_expired)
-- 
2.17.1

