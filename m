Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459DCFBE2B
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 04:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKNDMT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 22:12:19 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48454 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfKNDMK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 22:12:10 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.159.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5FBDC20B4904;
        Wed, 13 Nov 2019 19:12:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FBDC20B4904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573701129;
        bh=DcjuEGpDue6hzcYPER7yA0s/bwWCNqk95yOKVyIqy7s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sxfYy0ZM+8fA3PgmgbpQ+/pxtjIdIbWB6zXljPg8GkIpFpgv3vsTWz8RWY7cXe8WX
         K/8A/1JXdEWTEDKkDsqz2eCRQdpTWv6wjI6UNyLdTPTOhjZuQBAGZMFIOJ12XlT1b9
         3OR2lpoCCxNYpVP4Tg8+cw7Rhfiqj2z7w2xDAaBo=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/5] IMA: Define an IMA hook to measure keys
Date:   Wed, 13 Nov 2019 19:11:59 -0800
Message-Id: <20191114031202.18012-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191114031202.18012-1-nramas@linux.microsoft.com>
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Measure asymmetric keys used for verifying file signatures,
certificates, etc.

This patch defines a new IMA hook namely ima_post_key_create_or_update()
to measure asymmetric keys.

The IMA hook is defined in a new file namely ima_asymmetric_keys.c
which is built only if CONFIG_KEYS is enabled.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/Makefile              |  1 +
 security/integrity/ima/ima_asymmetric_keys.c | 51 ++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 security/integrity/ima/ima_asymmetric_keys.c

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 31d57cdf2421..3c796664be8a 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -12,3 +12,4 @@ ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
+obj-$(CONFIG_KEYS) += ima_asymmetric_keys.o
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
new file mode 100644
index 000000000000..f6884641a622
--- /dev/null
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -0,0 +1,51 @@
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
+#include <crypto/public_key.h>
+#include <keys/asymmetric-type.h>
+#include "ima.h"
+
+/**
+ * ima_post_key_create_or_update - measure asymmetric keys
+ * @keyring: keyring to which the key is linked to
+ * @key: created or updated key
+ * @flags: key flags
+ * @create: flag indicating whether the key was created or updated
+ *
+ * Keys can only be measured, not appraised.
+ */
+void ima_post_key_create_or_update(struct key *keyring, struct key *key,
+				   unsigned long flags, bool create)
+{
+	const struct public_key *pk;
+
+	/* Only asymmetric keys are handled by this hook. */
+	if (key->type != &key_type_asymmetric)
+		return;
+
+	/* Get the public_key of the given asymmetric key to measure. */
+	pk = key->payload.data[asym_crypto];
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
+	process_buffer_measurement(pk->key, pk->keylen,
+				   keyring->description, KEY_CHECK, 0);
+}
-- 
2.17.1

