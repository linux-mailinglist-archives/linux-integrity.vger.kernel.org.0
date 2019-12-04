Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8FA1137C3
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2019 23:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfLDWli (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Dec 2019 17:41:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50164 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbfLDWli (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Dec 2019 17:41:38 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id A1E1620B371E;
        Wed,  4 Dec 2019 14:41:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1E1620B371E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575499297;
        bh=xcEW1XwmfmUqNILSNIKCMPh/1lYTBQkm7M1N6MJsBow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9k3EYMIYj/RUI1JZdSZxFtszTjm2Ioet3XjNzY1l9RsX2/YkqSRqzFAHWbToVCtq
         eUyPKpnzLp51/95GDKiPBa6VXeakfIpwCkjj8EoZPyYbFFezj7XiEz0bRFZi+Lf/Pl
         r+yfU7CmLi6Hw5vU1mSh2LWmu/buWEIyP/EUIZ2A=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v10 4/6] KEYS: Call the IMA hook to measure keys
Date:   Wed,  4 Dec 2019 14:41:29 -0800
Message-Id: <20191204224131.3384-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191204224131.3384-1-nramas@linux.microsoft.com>
References: <20191204224131.3384-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Call the IMA hook from key_create_or_update() function to measure
the payload when a new key is created or an existing key is updated.

This patch adds the call to the IMA hook from key_create_or_update()
function to measure the key on key create or update.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/ima.h | 14 ++++++++++++++
 security/keys/key.c | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 6d904754d858..3b89136bc218 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -101,6 +101,20 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 {}
 #endif
 
+#if defined(CONFIG_IMA) && defined(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
+extern void ima_post_key_create_or_update(struct key *keyring,
+					  struct key *key,
+					  const void *payload, size_t plen,
+					  unsigned long flags, bool create);
+#else
+static inline void ima_post_key_create_or_update(struct key *keyring,
+						 struct key *key,
+						 const void *payload,
+						 size_t plen,
+						 unsigned long flags,
+						 bool create) {}
+#endif  /* CONFIG_IMA && CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
+
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct dentry *dentry);
diff --git a/security/keys/key.c b/security/keys/key.c
index 764f4c57913e..718bf7217420 100644
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
 
+	ima_post_key_create_or_update(keyring, key, payload, plen,
+				      flags, true);
+
 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
 
 error_link_end:
@@ -965,6 +969,12 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	}
 
 	key_ref = __key_update(key_ref, &prep);
+
+	if (!IS_ERR(key_ref))
+		ima_post_key_create_or_update(keyring, key,
+					      payload, plen,
+					      flags, false);
+
 	goto error_free_prep;
 }
 EXPORT_SYMBOL(key_create_or_update);
-- 
2.17.1

