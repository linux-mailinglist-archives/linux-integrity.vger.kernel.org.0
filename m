Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108BD232A93
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 05:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgG3Dri (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jul 2020 23:47:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53460 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbgG3Drc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jul 2020 23:47:32 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1E7F920B490D;
        Wed, 29 Jul 2020 20:47:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E7F920B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596080850;
        bh=yfGubZlNtjI/82phQqsNVjrHC1uPxSZK0j1rcb7s0yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEuKmEAqHlsrOQCZrB43UhK4m1Y+K+uQmqHr7AAvtDfeI01hfw2/ZfVyd8ASSXdeX
         uXqlmZKLsB7V7qx73biHU7179G9OYfz6rD6xiqcTNhUf1x6i3KRpJG2UOxxvnpZ463
         TCy0Xc5q6oWxL/d3zEAm8zcbwleuue1Gs1hIQnV4=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] IMA: Handle early boot data measurement
Date:   Wed, 29 Jul 2020 20:47:24 -0700
Message-Id: <20200730034724.3298-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730034724.3298-1-nramas@linux.microsoft.com>
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current implementation of early boot measurement in
the IMA subsystem is very specific to asymmetric keys. It does not
handle measurement of other data such as Linux Security Module (LSM)
data. Since most security modules are initialized very early in
the boot cycle, data provided by those modules are not measured
by IMA. Any other subsystem that initializes early in the boot cycle
and needs IMA to measure their data would suffer from the same issue.

Update the early boot key measurement to handle any early boot data.
Change the kernel configuration CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS to
CONFIG_IMA_QUEUE_EARLY_BOOT_DATA so it can be used for enabling
early boot data measurement. Change this new configuration to support
SECURITY subsystem in addition to KEYS subsystem, which is currently
supported. This can be extended to include more subsystems in the future
by updating this kernel configuration.

Update LSM hooks namely ima_measure_lsm_state() and ima_measure_lsm_policy
to utilize early boot measurement support.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/Kconfig               |   5 +-
 security/integrity/ima/Makefile              |   2 +-
 security/integrity/ima/ima.h                 |  37 ++--
 security/integrity/ima/ima_asymmetric_keys.c |   6 +-
 security/integrity/ima/ima_init.c            |   2 +-
 security/integrity/ima/ima_main.c            |  22 ++-
 security/integrity/ima/ima_policy.c          |   2 +-
 security/integrity/ima/ima_queue_data.c      | 175 +++++++++++++++++++
 security/integrity/ima/ima_queue_keys.c      | 174 ------------------
 9 files changed, 223 insertions(+), 202 deletions(-)
 create mode 100644 security/integrity/ima/ima_queue_data.c
 delete mode 100644 security/integrity/ima/ima_queue_keys.c

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 080c53545ff0..86cba844f73c 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -322,10 +322,9 @@ config IMA_MEASURE_ASYMMETRIC_KEYS
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
 	default y
 
-config IMA_QUEUE_EARLY_BOOT_KEYS
+config IMA_QUEUE_EARLY_BOOT_DATA
 	bool
-	depends on IMA_MEASURE_ASYMMETRIC_KEYS
-	depends on SYSTEM_TRUSTED_KEYRING
+	depends on SECURITY || (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRING)
 	default y
 
 config IMA_SECURE_AND_OR_TRUSTED_BOOT
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 67dabca670e2..cbbbc9848d2f 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -13,4 +13,4 @@ ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
-ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_DATA) += ima_queue_data.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 8ed9f5e1dd40..ebe4d9bb2f2b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -229,29 +229,34 @@ extern const char *const func_tokens[];
 
 struct modsig;
 
-#ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
+#ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_DATA
 /*
- * To track keys that need to be measured.
+ * To track data that needs to be measured.
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
+		    enum ima_hooks func);
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
+				  enum ima_hooks func) { return false; }
+static inline void ima_process_queued_data(void) {}
+#endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_DATA */
 
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 1c68c500c26f..8f8431f8b096 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -37,8 +37,10 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (!payload || (payload_len == 0))
 		return;
 
-	if (ima_should_queue_key())
-		queued = ima_queue_key(keyring, payload, payload_len);
+	if (ima_should_queue_data())
+		queued = ima_queue_data(keyring->description, payload,
+					payload_len, keyring->description,
+					KEY_CHECK);
 
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
index 74d421e40c8f..1c4e140964df 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -846,6 +846,22 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	fdput(f);
 }
 
+static int ima_measure_lsm_data(const char *event_name,
+				const void *buf, int size,
+				enum ima_hooks func)
+{
+	bool queued = false;
+
+	if (ima_should_queue_data())
+		queued = ima_queue_data(event_name, buf, size, NULL, func);
+
+	if (queued)
+		return 0;
+
+	return process_buffer_measurement(NULL, buf, size, event_name, func,
+					  0, NULL);
+}
+
 /**
  * ima_measure_lsm_state - measure LSM specific state
  * @lsm_event_name: LSM event
@@ -860,8 +876,7 @@ int ima_measure_lsm_state(const char *lsm_event_name, const void *buf,
 	if (!lsm_event_name || !buf || !size)
 		return -EINVAL;
 
-	return process_buffer_measurement(NULL, buf, size, lsm_event_name,
-					  LSM_STATE, 0, NULL);
+	return ima_measure_lsm_data(lsm_event_name, buf, size, LSM_STATE);
 }
 
 /**
@@ -878,8 +893,7 @@ int ima_measure_lsm_policy(const char *lsm_event_name, const void *buf,
 	if (!lsm_event_name || !buf || !size)
 		return -EINVAL;
 
-	return process_buffer_measurement(NULL, buf, size, lsm_event_name,
-					  LSM_POLICY, 0, NULL);
+	return ima_measure_lsm_data(lsm_event_name, buf, size, LSM_POLICY);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a0f5c39d9084..a8bfbca894ff 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -836,7 +836,7 @@ void ima_update_policy(void)
 	ima_update_policy_flag();
 
 	/* Custom IMA policy has been loaded */
-	ima_process_queued_keys();
+	ima_process_queued_data();
 }
 
 /* Keep the enumeration in sync with the policy_tokens! */
diff --git a/security/integrity/ima/ima_queue_data.c b/security/integrity/ima/ima_queue_data.c
new file mode 100644
index 000000000000..5eabd025ac2b
--- /dev/null
+++ b/security/integrity/ima/ima_queue_data.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * File: ima_queue_data.c
+ *       Enables deferred processing of data to be measured
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
+	kfree(entry->payload);
+	kfree(entry->event_name);
+	kfree(entry->event_data);
+	kfree(entry);
+}
+
+static struct ima_data_entry *ima_alloc_data_entry(const char *event_name,
+						   const void *payload,
+						   size_t payload_len,
+						   const char *event_data,
+						   enum ima_hooks func)
+{
+	struct ima_data_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		goto out;
+
+	entry->payload = kmemdup(payload, payload_len, GFP_KERNEL);
+	entry->event_name = kstrdup(event_name, GFP_KERNEL);
+	if (event_data)
+		entry->event_data = kstrdup(event_data, GFP_KERNEL);
+
+	entry->payload_len = payload_len;
+	entry->func = func;
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
+		    enum ima_hooks func)
+{
+	bool queued = false;
+	struct ima_data_entry *entry;
+
+	entry = ima_alloc_data_entry(event_name, payload, payload_len,
+				     event_data, func);
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
+						   entry->event_data);
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
index 69a8626a35c0..000000000000
--- a/security/integrity/ima/ima_queue_keys.c
+++ /dev/null
@@ -1,174 +0,0 @@
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
-						   entry->keyring_name);
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
2.27.0

