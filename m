Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D461124E3C6
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Aug 2020 01:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHUXMz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Aug 2020 19:12:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53768 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHUXMy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Aug 2020 19:12:54 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 758B720B4908;
        Fri, 21 Aug 2020 16:12:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 758B720B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598051571;
        bh=0K8yNmueQmmo4U8tBRXJdKpHRxXlmetPQ1bFKnh3sqU=;
        h=From:To:Cc:Subject:Date:From;
        b=YXil7rgLfCAvXYMuyITi2vqmWPESiwNvazHFlukuya1WXprhsXL0Ni4l7cjt9YVRO
         mUgrzII7lXLx7Wy0FvXIFBnc8fvC/4XjSeEw3Kxd3xtjV8929Za89tHqlaqlGfKd6F
         K+acZDXcQOdoNXpAgS4WlptzimPNBpCuRjuzbDRc=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IMA: Handle early boot data measurement
Date:   Fri, 21 Aug 2020 16:12:30 -0700
Message-Id: <20200821231230.20212-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current implementation of early boot measurement in
the IMA subsystem is very specific to asymmetric keys. It does not
handle early boot measurement of data from other subsystems such as
Linux Security Module (LSM), Device-Mapper, etc. As a result data,
provided by these subsystems during system boot are not measured by IMA.

Update the early boot key measurement to handle any early boot data.
Refactor the code from ima_queue_keys.c to a new file ima_queue_data.c.
Rename the kernel configuration CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS to
CONFIG_IMA_QUEUE_EARLY_BOOT_DATA so it can be used for enabling any
early boot data measurement. Since measurement of asymmetric keys is
the first consumer of early boot measurement, this kernel configuration
is enabled if IMA_MEASURE_ASYMMETRIC_KEYS and SYSTEM_TRUSTED_KEYRING are
both enabled.

Update the IMA hook ima_measure_critical_data() to utilize early boot
measurement support.

This patch is dependent on the following patch series:
	https://patchwork.kernel.org/patch/11709527/
	https://patchwork.kernel.org/patch/11730193/

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/Kconfig               |   2 +-
 security/integrity/ima/Makefile              |   2 +-
 security/integrity/ima/ima.h                 |  37 ++--
 security/integrity/ima/ima_asymmetric_keys.c |   7 +-
 security/integrity/ima/ima_init.c            |   2 +-
 security/integrity/ima/ima_main.c            |  10 +
 security/integrity/ima/ima_policy.c          |   2 +-
 security/integrity/ima/ima_queue_data.c      | 191 +++++++++++++++++++
 security/integrity/ima/ima_queue_keys.c      | 175 -----------------
 9 files changed, 231 insertions(+), 197 deletions(-)
 create mode 100644 security/integrity/ima/ima_queue_data.c
 delete mode 100644 security/integrity/ima/ima_queue_keys.c

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 080c53545ff0..bc2adab7bae2 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -322,7 +322,7 @@ config IMA_MEASURE_ASYMMETRIC_KEYS
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
 	default y
 
-config IMA_QUEUE_EARLY_BOOT_KEYS
+config IMA_QUEUE_EARLY_BOOT_DATA
 	bool
 	depends on IMA_MEASURE_ASYMMETRIC_KEYS
 	depends on SYSTEM_TRUSTED_KEYRING
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 67dabca670e2..6a0f9ef93bf0 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -13,4 +13,4 @@ ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
-ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_DATA) += ima_queue_data.o
\ No newline at end of file
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 00b84052c8f1..366d7cb5c22e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -228,29 +228,36 @@ extern const char *const func_tokens[];
 
 struct modsig;
 
-#ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
+#ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_DATA
 /*
  * To track keys that need to be measured.
  */
-struct ima_key_entry {
+struct ima_data_entry {
 	struct list_head list;
 	void *payload;
 	size_t payload_len;
-	char *keyring_name;
+	const char *event_name;
+	const char *event_data;
+	enum ima_hooks func;
+	bool measure_payload_hash;
 };
-void ima_init_key_queue(void);
-bool ima_should_queue_key(void);
-bool ima_queue_key(struct key *keyring, const void *payload,
-		   size_t payload_len);
-void ima_process_queued_keys(void);
+void ima_init_data_queue(void);
+bool ima_should_queue_data(void);
+bool ima_queue_data(const char *event_name, const void *payload,
+		    size_t payload_len, const char *event_data,
+		    enum ima_hooks func, bool measure_payload_hash);
+void ima_process_queued_data(void);
 #else
-static inline void ima_init_key_queue(void) {}
-static inline bool ima_should_queue_key(void) { return false; }
-static inline bool ima_queue_key(struct key *keyring,
-				 const void *payload,
-				 size_t payload_len) { return false; }
-static inline void ima_process_queued_keys(void) {}
-#endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS */
+static inline void ima_init_data_queue(void) {}
+static inline bool ima_should_queue_data(void) { return false; }
+static inline bool ima_queue_data(const char *event_name,
+				  const void *payload,
+				  size_t payload_len,
+				  const char *event_data,
+				  enum ima_hooks func,
+				  bool measure_payload_hash) { return false; }
+static inline void ima_process_queued_data(void) {}
+#endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_DATA */
 
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index a74095793936..65423754765f 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -37,9 +37,10 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (!payload || (payload_len == 0))
 		return;
 
-	if (ima_should_queue_key())
-		queued = ima_queue_key(keyring, payload, payload_len);
-
+	if (ima_should_queue_data())
+		queued = ima_queue_data(keyring->description, payload,
+					payload_len, keyring->description,
+					KEY_CHECK, false);
 	if (queued)
 		return;
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 4902fe7bd570..892894bf4af3 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -145,7 +145,7 @@ int __init ima_init(void)
 	if (rc != 0)
 		return rc;
 
-	ima_init_key_queue();
+	ima_init_data_queue();
 
 	return rc;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5db6dc3d45aa..728557662903 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -885,9 +885,19 @@ int ima_measure_critical_data(const char *event_name,
 			      const void *buf, int buf_len,
 			      bool measure_buf_hash)
 {
+	bool queued = false;
+
 	if (!event_name || !event_data_source || !buf || !buf_len)
 		return -EINVAL;
 
+	if (ima_should_queue_data())
+		queued = ima_queue_data(event_name, buf, buf_len,
+					event_data_source, CRITICAL_DATA,
+					measure_buf_hash);
+
+	if (queued)
+		return 0;
+
 	return process_buffer_measurement(NULL, buf, buf_len, event_name,
 					  CRITICAL_DATA, 0, event_data_source,
 					  measure_buf_hash);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 59058ce7906b..f4f095ae6f8f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -906,7 +906,7 @@ void ima_update_policy(void)
 	ima_update_policy_flag();
 
 	/* Custom IMA policy has been loaded */
-	ima_process_queued_keys();
+	ima_process_queued_data();
 }
 
 /* Keep the enumeration in sync with the policy_tokens! */
diff --git a/security/integrity/ima/ima_queue_data.c b/security/integrity/ima/ima_queue_data.c
new file mode 100644
index 000000000000..d466ee742377
--- /dev/null
+++ b/security/integrity/ima/ima_queue_data.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * File: ima_queue_data.c
+ *       Enables deferred processing of data
+ */
+
+#include <linux/workqueue.h>
+#include "ima.h"
+
+/*
+ * Flag to indicate whether data can be processed
+ * right away or should be queued for processing later.
+ */
+static bool ima_process_data;
+
+/*
+ * To synchronize access to the list of data that need to be measured
+ */
+static DEFINE_MUTEX(ima_data_lock);
+static LIST_HEAD(ima_queued_data);
+
+/*
+ * If custom IMA policy is not loaded then data queued up
+ * for measurement should be freed. This worker is used
+ * for handling this scenario.
+ */
+static long ima_data_queue_timeout = 300000; /* 5 Minutes */
+static void ima_data_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(ima_data_delayed_work, ima_data_handler);
+static bool timer_expired;
+
+/*
+ * This worker function frees data that may still be
+ * queued up in case custom IMA policy was not loaded.
+ */
+static void ima_data_handler(struct work_struct *work)
+{
+	timer_expired = true;
+	ima_process_queued_data();
+}
+
+/*
+ * This function sets up a worker to free queued data in case
+ * custom IMA policy was never loaded.
+ */
+void ima_init_data_queue(void)
+{
+	schedule_delayed_work(&ima_data_delayed_work,
+			      msecs_to_jiffies(ima_data_queue_timeout));
+}
+
+static void ima_free_data_entry(struct ima_data_entry *entry)
+{
+	if (!entry)
+		return;
+
+	kvfree(entry->payload);
+	kfree(entry->event_name);
+	kfree(entry->event_data);
+	kfree(entry);
+}
+
+static void *ima_kvmemdup(const void *src, size_t len)
+{
+	void *p = kvmalloc(len, GFP_KERNEL);
+
+	if (p)
+		memcpy(p, src, len);
+	return p;
+}
+
+static struct ima_data_entry *ima_alloc_data_entry(const char *event_name,
+						   const void *payload,
+						   size_t payload_len,
+						   const char *event_data,
+						   enum ima_hooks func,
+						   bool measure_payload_hash)
+{
+	struct ima_data_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		goto out;
+
+	/*
+	 * Payload size may exceed the limit supported by kmalloc.
+	 * So use kvmalloc instead.
+	 */
+	entry->payload = ima_kvmemdup(payload, payload_len);
+	entry->event_name = kstrdup(event_name, GFP_KERNEL);
+	if (event_data)
+		entry->event_data = kstrdup(event_data, GFP_KERNEL);
+
+	entry->payload_len = payload_len;
+	entry->func = func;
+	entry->measure_payload_hash = measure_payload_hash;
+
+	if (!entry->payload || !entry->event_name ||
+		(event_data && !entry->event_data))
+		goto out;
+
+	INIT_LIST_HEAD(&entry->list);
+	return entry;
+
+out:
+	integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL,
+				event_name, func_measure_str(func),
+				"ENOMEM", -ENOMEM, 0, -ENOMEM);
+	ima_free_data_entry(entry);
+	return NULL;
+}
+
+bool ima_queue_data(const char *event_name, const void *payload,
+		    size_t payload_len, const char *event_data,
+		    enum ima_hooks func, bool measure_payload_hash)
+{
+	bool queued = false;
+	struct ima_data_entry *entry;
+
+	entry = ima_alloc_data_entry(event_name, payload, payload_len,
+				     event_data, func, measure_payload_hash);
+	if (!entry)
+		return false;
+
+	mutex_lock(&ima_data_lock);
+	if (!ima_process_data) {
+		list_add_tail(&entry->list, &ima_queued_data);
+		queued = true;
+	}
+	mutex_unlock(&ima_data_lock);
+
+	if (!queued)
+		ima_free_data_entry(entry);
+
+	return queued;
+}
+
+/*
+ * ima_process_queued_data() - process data queued for measurement
+ *
+ * This function sets ima_process_data to true and processes queued data.
+ * From here on data will be processed right away (not queued).
+ */
+void ima_process_queued_data(void)
+{
+	struct ima_data_entry *entry, *tmp;
+	bool process = false;
+
+	if (ima_process_data)
+		return;
+
+	/*
+	 * Since ima_process_data is set to true, any new data will be
+	 * processed immediately and not be queued to ima_queued_data list.
+	 * First one setting the ima_process_data flag to true will
+	 * process the queued data.
+	 */
+	mutex_lock(&ima_data_lock);
+	if (!ima_process_data) {
+		ima_process_data = true;
+		process = true;
+	}
+	mutex_unlock(&ima_data_lock);
+
+	if (!process)
+		return;
+
+	if (!timer_expired)
+		cancel_delayed_work_sync(&ima_data_delayed_work);
+
+	list_for_each_entry_safe(entry, tmp, &ima_queued_data, list) {
+		if (!timer_expired)
+			process_buffer_measurement(NULL, entry->payload,
+						   entry->payload_len,
+						   entry->event_name,
+						   entry->func, 0,
+						   entry->event_data,
+						   entry->measure_payload_hash);
+		list_del(&entry->list);
+		ima_free_data_entry(entry);
+	}
+}
+
+inline bool ima_should_queue_data(void)
+{
+	return !ima_process_data;
+}
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
deleted file mode 100644
index c2f2ad34f9b7..000000000000
--- a/security/integrity/ima/ima_queue_keys.c
+++ /dev/null
@@ -1,175 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2019 Microsoft Corporation
- *
- * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
- *
- * File: ima_queue_keys.c
- *       Enables deferred processing of keys
- */
-
-#include <linux/workqueue.h>
-#include <keys/asymmetric-type.h>
-#include "ima.h"
-
-/*
- * Flag to indicate whether a key can be processed
- * right away or should be queued for processing later.
- */
-static bool ima_process_keys;
-
-/*
- * To synchronize access to the list of keys that need to be measured
- */
-static DEFINE_MUTEX(ima_keys_lock);
-static LIST_HEAD(ima_keys);
-
-/*
- * If custom IMA policy is not loaded then keys queued up
- * for measurement should be freed. This worker is used
- * for handling this scenario.
- */
-static long ima_key_queue_timeout = 300000; /* 5 Minutes */
-static void ima_keys_handler(struct work_struct *work);
-static DECLARE_DELAYED_WORK(ima_keys_delayed_work, ima_keys_handler);
-static bool timer_expired;
-
-/*
- * This worker function frees keys that may still be
- * queued up in case custom IMA policy was not loaded.
- */
-static void ima_keys_handler(struct work_struct *work)
-{
-	timer_expired = true;
-	ima_process_queued_keys();
-}
-
-/*
- * This function sets up a worker to free queued keys in case
- * custom IMA policy was never loaded.
- */
-void ima_init_key_queue(void)
-{
-	schedule_delayed_work(&ima_keys_delayed_work,
-			      msecs_to_jiffies(ima_key_queue_timeout));
-}
-
-static void ima_free_key_entry(struct ima_key_entry *entry)
-{
-	if (entry) {
-		kfree(entry->payload);
-		kfree(entry->keyring_name);
-		kfree(entry);
-	}
-}
-
-static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
-						 const void *payload,
-						 size_t payload_len)
-{
-	int rc = 0;
-	const char *audit_cause = "ENOMEM";
-	struct ima_key_entry *entry;
-
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-	if (entry) {
-		entry->payload = kmemdup(payload, payload_len, GFP_KERNEL);
-		entry->keyring_name = kstrdup(keyring->description,
-					      GFP_KERNEL);
-		entry->payload_len = payload_len;
-	}
-
-	if ((entry == NULL) || (entry->payload == NULL) ||
-	    (entry->keyring_name == NULL)) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	INIT_LIST_HEAD(&entry->list);
-
-out:
-	if (rc) {
-		integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL,
-					keyring->description,
-					func_measure_str(KEY_CHECK),
-					audit_cause, rc, 0, rc);
-		ima_free_key_entry(entry);
-		entry = NULL;
-	}
-
-	return entry;
-}
-
-bool ima_queue_key(struct key *keyring, const void *payload,
-		   size_t payload_len)
-{
-	bool queued = false;
-	struct ima_key_entry *entry;
-
-	entry = ima_alloc_key_entry(keyring, payload, payload_len);
-	if (!entry)
-		return false;
-
-	mutex_lock(&ima_keys_lock);
-	if (!ima_process_keys) {
-		list_add_tail(&entry->list, &ima_keys);
-		queued = true;
-	}
-	mutex_unlock(&ima_keys_lock);
-
-	if (!queued)
-		ima_free_key_entry(entry);
-
-	return queued;
-}
-
-/*
- * ima_process_queued_keys() - process keys queued for measurement
- *
- * This function sets ima_process_keys to true and processes queued keys.
- * From here on keys will be processed right away (not queued).
- */
-void ima_process_queued_keys(void)
-{
-	struct ima_key_entry *entry, *tmp;
-	bool process = false;
-
-	if (ima_process_keys)
-		return;
-
-	/*
-	 * Since ima_process_keys is set to true, any new key will be
-	 * processed immediately and not be queued to ima_keys list.
-	 * First one setting the ima_process_keys flag to true will
-	 * process the queued keys.
-	 */
-	mutex_lock(&ima_keys_lock);
-	if (!ima_process_keys) {
-		ima_process_keys = true;
-		process = true;
-	}
-	mutex_unlock(&ima_keys_lock);
-
-	if (!process)
-		return;
-
-	if (!timer_expired)
-		cancel_delayed_work_sync(&ima_keys_delayed_work);
-
-	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
-		if (!timer_expired)
-			process_buffer_measurement(NULL, entry->payload,
-						   entry->payload_len,
-						   entry->keyring_name,
-						   KEY_CHECK, 0,
-						   entry->keyring_name,
-						   false);
-		list_del(&entry->list);
-		ima_free_key_entry(entry);
-	}
-}
-
-inline bool ima_should_queue_key(void)
-{
-	return !ima_process_keys;
-}
-- 
2.28.0

