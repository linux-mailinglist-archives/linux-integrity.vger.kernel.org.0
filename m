Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D222411B929
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 17:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfLKQrQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 11:47:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38750 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbfLKQrP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 11:47:15 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2B92B20B71AC;
        Wed, 11 Dec 2019 08:47:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B92B20B71AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576082835;
        bh=nJOpj8xmyQDqyMlHgauXRE3bYtNed5ivmN6opmcD2aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8flkqISTlizdcIHt2/GuUCNxtc4k3nVMWZyrDUgot6B3TB6QYNirjD3/NQOhreB0
         aaQjObbI2PFbIqpOI8ZZSM3K7x7fc84RdwgxC42GNZM9rZfn31tlSYGWvXcuAe76jZ
         KQIikOPXeRj/Aj7pA+F7pOL2cUNkUraoQkBkvajk=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v11 3/6] IMA: Define an IMA hook to measure keys
Date:   Wed, 11 Dec 2019 08:47:04 -0800
Message-Id: <20191211164707.4698-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211164707.4698-1-nramas@linux.microsoft.com>
References: <20191211164707.4698-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Measure asymmetric keys used for verifying file signatures,
certificates, etc.

This patch defines a new IMA hook namely ima_post_key_create_or_update()
to measure the payload used to create a new asymmetric key or
update an existing asymmetric key.

Asymmetric key structure is defined only when
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is defined. Since the IMA hook
measures asymmetric keys, the IMA hook is defined in a new file namely
ima_asymmetric_keys.c which is built only if
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is defined.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/Makefile              |  1 +
 security/integrity/ima/ima_asymmetric_keys.c | 52 ++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 security/integrity/ima/ima_asymmetric_keys.c

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 31d57cdf2421..207a0a9eb72c 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -12,3 +12,4 @@ ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
+obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += ima_asymmetric_keys.o
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
new file mode 100644
index 000000000000..994d89d58af9
--- /dev/null
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * File: ima_asymmetric_keys.c
+ *       Defines an IMA hook to measure asymmetric keys on key
+ *       create or update.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <keys/asymmetric-type.h>
+#include "ima.h"
+
+/**
+ * ima_post_key_create_or_update - measure asymmetric keys
+ * @keyring: keyring to which the key is linked to
+ * @key: created or updated key
+ * @payload: The data used to instantiate or update the key.
+ * @payload_len: The length of @payload.
+ * @flags: key flags
+ * @create: flag indicating whether the key was created or updated
+ *
+ * Keys can only be measured, not appraised.
+ * The payload data used to instantiate or update the key is measured.
+ */
+void ima_post_key_create_or_update(struct key *keyring, struct key *key,
+				   const void *payload, size_t payload_len,
+				   unsigned long flags, bool create)
+{
+	/* Only asymmetric keys are handled by this hook. */
+	if (key->type != &key_type_asymmetric)
+		return;
+
+	if (!payload || (payload_len == 0))
+		return;
+
+	/*
+	 * keyring->description points to the name of the keyring
+	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
+	 * which the given key is linked to.
+	 *
+	 * The name of the keyring is passed in the "eventname"
+	 * parameter to process_buffer_measurement() and is set
+	 * in the "eventname" field in ima_event_data for
+	 * the key measurement IMA event.
+	 */
+	process_buffer_measurement(payload, payload_len,
+				   keyring->description, KEY_CHECK, 0);
+}
-- 
2.17.1

