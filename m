Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 118C5EA8AA
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 02:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfJaBTo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Oct 2019 21:19:44 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34490 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfJaBTS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Oct 2019 21:19:18 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 07E9520B4909;
        Wed, 30 Oct 2019 18:19:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 07E9520B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572484758;
        bh=OmpAzjnJ/nj/UbF+W79M2ah1WZCUvBkzqdH43tv+ZxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOBkoTcyx9A1UVXfYeuGsU1IDnsUhOMbwjGSQ650wPYPEMm0Unq2X5uZY0/KvhLcK
         cnNZhWYNaZIAUzXLHcvmxJF5YBs2E3o8phnGAvXJBYdYzvrtABb2AM/IWwWF8dU6MJ
         WKzzEi4dSMaMmHCUfF7IDS+crZg2idoKBaL/KELI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
Subject: [PATCH v3 9/9] KEYS: Call the IMA hook to measure key when a new key is created or an existing key is updated
Date:   Wed, 30 Oct 2019 18:19:10 -0700
Message-Id: <20191031011910.2574-10-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

key_create_or_update function needs to call the IMA hook to measure
the key when a new key is created or an existing key is updated.

This patch adds the call to the IMA hook from key_create_or_update
function.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/ima.h | 7 +++++++
 security/keys/key.c | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index a20ad398d260..f085f1c6ef34 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -24,6 +24,9 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_kexec_cmdline(const void *buf, int size);
+extern void ima_post_key_create_or_update(struct key *keyring,
+					  struct key *key,
+					  unsigned long flags, bool create);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -91,6 +94,10 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 }
 
 static inline void ima_kexec_cmdline(const void *buf, int size) {}
+static inline void ima_post_key_create_or_update(struct key *keyring,
+						 struct key *key,
+						 unsigned long flags,
+						 bool create) {}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/keys/key.c b/security/keys/key.c
index 764f4c57913e..7c39054d8da6 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/workqueue.h>
 #include <linux/random.h>
+#include <linux/ima.h>
 #include <linux/err.h>
 #include "internal.h"
 
@@ -936,6 +937,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	/* let the ima module know about the created key. */
+	ima_post_key_create_or_update(keyring, key, flags, true);
+
 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
 
 error_link_end:
@@ -965,6 +969,11 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	}
 
 	key_ref = __key_update(key_ref, &prep);
+	if (!IS_ERR(key_ref)) {
+		/* let the ima module know about the updated key. */
+		ima_post_key_create_or_update(keyring, key, flags, false);
+	}
+
 	goto error_free_prep;
 }
 EXPORT_SYMBOL(key_create_or_update);
-- 
2.17.1

