Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF05132FB2
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2020 20:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAGTnz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jan 2020 14:43:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34212 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbgAGTnz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jan 2020 14:43:55 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id A6CBD20B479A;
        Tue,  7 Jan 2020 11:43:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6CBD20B479A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578426234;
        bh=yA5LFjSLBWVUP9TbZOq+D/2tmitmwjc/aS91KwfLW6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZLFFRMIhtrM0dtheX1wT/8OLGYBWwcScPXgBiIpgLm2I0onLHlwuo5o5p7jJmIxql
         N0wLB85js/eg5T/7HST8Ui+ZZS1wROO7siJsssn5EVcAU4lGe6mMDTIcuvoj0wkkQW
         MjMJDkjJ9BMG+iaevZLcLUUzy/JiE4T6iBkX7/I4=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH 2/4] KEYS: Call the IMA hook to measure keys
Date:   Tue,  7 Jan 2020 11:43:48 -0800
Message-Id: <20200107194350.3782-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107194350.3782-1-nramas@linux.microsoft.com>
References: <20200107194350.3782-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Call the IMA hook from key_create_or_update() function to measure
the payload when a new key is created or an existing key is updated.

This patch adds the call to the IMA hook from key_create_or_update()
function to measure the key on key create or update.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reported-by: kbuild test robot <lkp@intel.com> # ima_asymmetric_keys.c
is built as a kernel module when it is actually not.
Fixes: cb1aa3823c92 ("KEYS: Call the IMA hook to measure keys")
---
 include/linux/ima.h | 14 ++++++++++++++
 security/keys/key.c | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 6d904754d858..f4644c54f648 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -101,6 +101,20 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 {}
 #endif
 
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
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
+#endif  /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
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

