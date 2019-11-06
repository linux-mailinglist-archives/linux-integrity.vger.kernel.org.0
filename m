Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D683F1DFD
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2019 20:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfKFTB3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 14:01:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36192 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732279AbfKFTB3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 14:01:29 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9F2D020B4908;
        Wed,  6 Nov 2019 11:01:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F2D020B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573066887;
        bh=3KLwpY5WMSeoDc50Cu89wwg2YWMqHdF3aIcDS9t248o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LyIJrdjrjZCdWOhfDfWtmkxfgWlY5ab9yKEg/JEa3uR2FJVJBGfuXXopPKPFDV5xL
         lXYwiPzRx66BTFc8keXivQGE8NE1gM8WPtwG4EWsOkrCns+WPLLkH7NkBjo0kOSZvB
         JXCbXJrxNMoGfyqJMST0IwMHZ68+SMUot+Y4cyIs=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/10] IMA: Defined functions to queue and dequeue keys for measurement
Date:   Wed,  6 Nov 2019 11:01:14 -0800
Message-Id: <20191106190116.2578-9-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106190116.2578-1-nramas@linux.microsoft.com>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A key can be measured right away only if IMA is initialized.
Otherwise, the key should be queued up and processed when IMA
initialization is completed.

This patch defines functions to queue and dequeue keys for
measurement and a config to enable these functions.
These functions are defined in a new file namely
ima_asymmetric_keys.c

Note that currently IMA subsystem can be enabled without
enabling KEYS subsystem.

Adding support for measuring asymmetric keys in IMA requires KEYS
subsystem to be enabled. To handle this dependency a new config
namely CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS has been added. Enabling
this config requires the following configs to be enabled:
    CONFIG_IMA, CONFIG_KEYS, CONFIG_ASYMMETRIC_KEY_TYPE, and
    CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE.

The new file ima_asymmetric_keys.c is built only if
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is enabled.

This config is turned off by default.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/Kconfig               |  14 ++
 security/integrity/ima/Makefile              |   1 +
 security/integrity/ima/ima.h                 |  24 ++++
 security/integrity/ima/ima_asymmetric_keys.c | 136 +++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 security/integrity/ima/ima_asymmetric_keys.c

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 838476d780e5..c6d14884bc19 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -310,3 +310,17 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+config IMA_MEASURE_ASYMMETRIC_KEYS
+	bool "Enable measuring asymmetric keys on key create or update"
+	depends on IMA
+	depends on KEYS
+	depends on ASYMMETRIC_KEY_TYPE
+	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	default n
+	help
+	   This option enables measuring asymmetric keys when
+	   the key is created or updated. Additionally, IMA policy
+	   needs to be configured to either measure keys linked to
+	   any keyring or only measure keys linked to the keyrings
+	   specified in the IMA policy through the keyrings= option.
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 31d57cdf2421..3e9d0ad68c7b 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -12,3 +12,4 @@ ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
+obj-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6a86daa62c5b..872883520ea6 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -206,6 +206,30 @@ extern const char *const func_tokens[];
 
 struct modsig;
 
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
+/*
+ * To track keys that need to be measured.
+ */
+struct ima_measure_key_entry {
+	struct list_head list;
+	void *public_key;
+	u32  public_key_len;
+	char *keyring_name;
+};
+
+int ima_queue_or_process_key_for_measurement(struct key *keyring,
+					     struct key *key);
+void ima_measure_queued_keys(void);
+#else
+static inline int ima_queue_or_process_key_for_measurement(
+					     struct key *keyring,
+					     struct key *key)
+{
+	return 0;
+}
+static inline void ima_measure_queued_keys(void) {}
+#endif /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
new file mode 100644
index 000000000000..fa3d9bf8fcbe
--- /dev/null
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * File: ima_asymmetric_keys.c
+ *       Queue and de-queue functions for measuring asymmetric keys.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <crypto/public_key.h>
+#include <keys/asymmetric-type.h>
+#include "ima.h"
+
+/*
+ * To synchronize access to the list of keys that need to be measured
+ */
+static DEFINE_MUTEX(ima_measure_keys_mutex);
+static LIST_HEAD(ima_measure_keys);
+
+static void ima_free_measure_key_entry(struct ima_measure_key_entry *entry)
+{
+	if (entry != NULL) {
+		if (entry->public_key != NULL)
+			kzfree(entry->public_key);
+		if (entry->keyring_name != NULL)
+			kzfree(entry->keyring_name);
+		kzfree(entry);
+	}
+}
+
+static struct ima_measure_key_entry *ima_alloc_measure_key_entry(
+	struct key *keyring,
+	struct key *key)
+{
+	int rc = 0;
+	const struct public_key *pk;
+	size_t keyring_name_len;
+	struct ima_measure_key_entry *entry = NULL;
+
+	pk = key->payload.data[asym_crypto];
+	keyring_name_len = strlen(keyring->description) + 1;
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (entry != NULL) {
+		entry->public_key = kzalloc(pk->keylen, GFP_KERNEL);
+		entry->keyring_name =
+			kzalloc(keyring_name_len, GFP_KERNEL);
+	}
+
+	if ((entry == NULL) || (entry->public_key == NULL) ||
+	    (entry->keyring_name == NULL)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	strcpy(entry->keyring_name, keyring->description);
+	memcpy(entry->public_key, pk->key, pk->keylen);
+	entry->public_key_len = pk->keylen;
+	rc = 0;
+
+out:
+	if (rc) {
+		ima_free_measure_key_entry(entry);
+		entry = NULL;
+	}
+
+	return entry;
+}
+
+int ima_queue_or_process_key_for_measurement(struct key *keyring,
+					     struct key *key)
+{
+	int rc = 0;
+	struct ima_measure_key_entry *entry = NULL;
+	const struct public_key *pk;
+
+	if (key->type != &key_type_asymmetric)
+		return 0;
+
+	mutex_lock(&ima_measure_keys_mutex);
+
+	if (ima_initialized) {
+		/*
+		 * keyring->description points to the name of the keyring
+		 * (such as ".builtin_trusted_keys", ".ima", etc.) to
+		 * which the given key is linked to.
+		 *
+		 * The name of the keyring is passed in the "eventname"
+		 * parameter to process_buffer_measurement() and is set
+		 * in the "eventname" field in ima_event_data for
+		 * the key measurement IMA event.
+		 *
+		 * The name of the keyring is also passed in the "keyring"
+		 * parameter to process_buffer_measurement() to check
+		 * if the IMA policy is configured to measure a key linked
+		 * to the given keyring.
+		 */
+		pk = key->payload.data[asym_crypto];
+		process_buffer_measurement(pk->key, pk->keylen,
+					   keyring->description,
+					   KEYRING_CHECK, 0,
+					   keyring->description);
+	} else {
+		entry = ima_alloc_measure_key_entry(keyring, key);
+		if (entry != NULL) {
+			INIT_LIST_HEAD(&entry->list);
+			list_add_tail(&entry->list, &ima_measure_keys);
+		} else
+			rc = -ENOMEM;
+	}
+
+	mutex_unlock(&ima_measure_keys_mutex);
+
+	return rc;
+}
+
+void ima_measure_queued_keys(void)
+{
+	struct ima_measure_key_entry *entry, *tmp;
+
+	mutex_lock(&ima_measure_keys_mutex);
+
+	list_for_each_entry_safe(entry, tmp, &ima_measure_keys, list) {
+		process_buffer_measurement(entry->public_key,
+					   entry->public_key_len,
+					   entry->keyring_name,
+					   KEYRING_CHECK, 0,
+					   entry->keyring_name);
+		list_del(&entry->list);
+		ima_free_measure_key_entry(entry);
+	}
+
+	mutex_unlock(&ima_measure_keys_mutex);
+}
-- 
2.17.1

