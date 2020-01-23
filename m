Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD92B146058
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2020 02:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAWBcN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jan 2020 20:32:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55872 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWBcN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jan 2020 20:32:13 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9384320B4798;
        Wed, 22 Jan 2020 17:32:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9384320B4798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579743131;
        bh=vhWNJFcZ1lKSjddLmIJo2O1KjzBodPswRirIh7RqTkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouEXrAVl9gdJWmOKL++Nqz2rODK3lb/0oUugvQ8cMFybmZKw5nokV6QC2wYJGcycA
         VErAoDMDvIYqRWglGP50d9bCDrg643zbXvsC8X/9EIRprhvLewPnpC+IOQUHv55U21
         4DwE/Xoojmls4f59gBvp3z3NLpAXyRabo9/3URWI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v9 1/3] IMA: Define workqueue for early boot key measurements
Date:   Wed, 22 Jan 2020 17:32:04 -0800
Message-Id: <20200123013206.8499-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123013206.8499-1-nramas@linux.microsoft.com>
References: <20200123013206.8499-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Measuring keys requires a custom IMA policy to be loaded.
Keys created or updated before a custom IMA policy is loaded should
be queued and the keys should be processed after a custom policy
is loaded.

This patch defines workqueue for queuing keys when a custom IMA policy
has not yet been loaded. An intermediate Kconfig boolean option namely
IMA_QUEUE_EARLY_BOOT_KEYS is used to declare the workqueue functions.

A flag namely ima_process_keys is used to check if the key should be
queued or should be processed immediately.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/Kconfig          |   5 +
 security/integrity/ima/Makefile         |   1 +
 security/integrity/ima/ima.h            |  22 ++++
 security/integrity/ima/ima_queue_keys.c | 137 ++++++++++++++++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 security/integrity/ima/ima_queue_keys.c

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 6bec78eeeae8..711ff10fa36e 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -317,3 +317,8 @@ config IMA_MEASURE_ASYMMETRIC_KEYS
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
 	default y
 
+config IMA_QUEUE_EARLY_BOOT_KEYS
+	bool
+	depends on IMA_MEASURE_ASYMMETRIC_KEYS
+	depends on SYSTEM_TRUSTED_KEYRING
+	default y
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 3e9d0ad68c7b..064a256f8725 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -13,3 +13,4 @@ ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 obj-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
+obj-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f06238e41a7c..905ed2f7f778 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -205,6 +205,28 @@ extern const char *const func_tokens[];
 
 struct modsig;
 
+#ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
+/*
+ * To track keys that need to be measured.
+ */
+struct ima_key_entry {
+	struct list_head list;
+	void *payload;
+	size_t payload_len;
+	char *keyring_name;
+};
+bool ima_should_queue_key(void);
+bool ima_queue_key(struct key *keyring, const void *payload,
+		   size_t payload_len);
+void ima_process_queued_keys(void);
+#else
+static inline bool ima_should_queue_key(void) { return false; }
+static inline bool ima_queue_key(struct key *keyring,
+				 const void *payload,
+				 size_t payload_len) { return false; }
+static inline void ima_process_queued_keys(void) {}
+#endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS */
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
new file mode 100644
index 000000000000..9b561f2b86db
--- /dev/null
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * File: ima_queue_keys.c
+ *       Enables deferred processing of keys
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <keys/asymmetric-type.h>
+#include "ima.h"
+
+/*
+ * Flag to indicate whether a key can be processed
+ * right away or should be queued for processing later.
+ */
+static bool ima_process_keys;
+
+/*
+ * To synchronize access to the list of keys that need to be measured
+ */
+static DEFINE_MUTEX(ima_keys_lock);
+static LIST_HEAD(ima_keys);
+
+static void ima_free_key_entry(struct ima_key_entry *entry)
+{
+	if (entry) {
+		kfree(entry->payload);
+		kfree(entry->keyring_name);
+		kfree(entry);
+	}
+}
+
+static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
+						 const void *payload,
+						 size_t payload_len)
+{
+	int rc = 0;
+	struct ima_key_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (entry) {
+		entry->payload = kmemdup(payload, payload_len, GFP_KERNEL);
+		entry->keyring_name = kstrdup(keyring->description,
+					      GFP_KERNEL);
+		entry->payload_len = payload_len;
+	}
+
+	if ((entry == NULL) || (entry->payload == NULL) ||
+	    (entry->keyring_name == NULL)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&entry->list);
+
+out:
+	if (rc) {
+		ima_free_key_entry(entry);
+		entry = NULL;
+	}
+
+	return entry;
+}
+
+bool ima_queue_key(struct key *keyring, const void *payload,
+		   size_t payload_len)
+{
+	bool queued = false;
+	struct ima_key_entry *entry;
+
+	entry = ima_alloc_key_entry(keyring, payload, payload_len);
+	if (!entry)
+		return false;
+
+	mutex_lock(&ima_keys_lock);
+	if (!ima_process_keys) {
+		list_add_tail(&entry->list, &ima_keys);
+		queued = true;
+	}
+	mutex_unlock(&ima_keys_lock);
+
+	if (!queued)
+		ima_free_key_entry(entry);
+
+	return queued;
+}
+
+/*
+ * ima_process_queued_keys() - process keys queued for measurement
+ *
+ * This function sets ima_process_keys to true and processes queued keys.
+ * From here on keys will be processed right away (not queued).
+ */
+void ima_process_queued_keys(void)
+{
+	struct ima_key_entry *entry, *tmp;
+	bool process = false;
+
+	if (ima_process_keys)
+		return;
+
+	/*
+	 * Since ima_process_keys is set to true, any new key will be
+	 * processed immediately and not be queued to ima_keys list.
+	 * First one setting the ima_process_keys flag to true will
+	 * process the queued keys.
+	 */
+	mutex_lock(&ima_keys_lock);
+	if (!ima_process_keys) {
+		ima_process_keys = true;
+		process = true;
+	}
+	mutex_unlock(&ima_keys_lock);
+
+	if (!process)
+		return;
+
+
+	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
+		process_buffer_measurement(entry->payload,
+					   entry->payload_len,
+					   entry->keyring_name,
+					   KEY_CHECK, 0,
+					   entry->keyring_name);
+		list_del(&entry->list);
+		ima_free_key_entry(entry);
+	}
+}
+
+inline bool ima_should_queue_key(void)
+{
+	return !ima_process_keys;
+}
-- 
2.17.1

