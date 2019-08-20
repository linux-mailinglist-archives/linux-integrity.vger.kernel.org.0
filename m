Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979C195274
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2019 02:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfHTATQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 20:19:16 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:39172 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfHTATQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 20:19:16 -0400
Received: by mail-ua1-f73.google.com with SMTP id 43so546013uaj.6
        for <linux-integrity@vger.kernel.org>; Mon, 19 Aug 2019 17:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l0D0FijjHNavvE4x6KoSMcY6aVnPYpY2dpif/cNLitk=;
        b=Pbcszmfo0nBO9MridqaWaCmAvMTSKzWZF5bf08oJsft5Gw9UdsClZ/3l8pVt1WW3Om
         TeGXyUuWLHjajfOp9UAv1xzvhVCFEKDt2R6Hf7PPozGHpMUpP//3XuQkUqhZQu6yWFoc
         SD3i9b1jcaZZckls08n4PzLiiUYetxGJ9giY/QjFgDTVYN+AYAI5z4FRN0xNphj1z5BS
         8Y4fM5nAzyU3sAOr9QG9Z0qxuksHBXeIpeg2XkOp2JBO/xlZMbp1xjBpaBVrTrm1BbW3
         NincUSfhrlYLkkDB2M9Olx0VH03LJD82RbEe014R/lSjMxZcJylmUsPtdpN3ZNOHNslE
         wrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l0D0FijjHNavvE4x6KoSMcY6aVnPYpY2dpif/cNLitk=;
        b=rMljDXEhscQw0HTnO46VMrDNH1vr6OYinMsK5GrB8CxjDmNdtnVjJJKjjuG8rL5oDR
         TpPKsmYzCwBGmdBpngIoMXSq6LcScPpgnODTD7/8lLMjmvJ3N2F73hxh2Qnh8fLXsTjW
         lgHU+Re0Zwb6jAjr4rUDGoqppMq50KHlvS21XanJI2fs4RJEcOL23+B5LlyvUi1S7HkF
         h+4Xy9zmvuc3T0bZCw4QBr0eZp18rQQKektgSmRFKhdqD3yXiH2iZ2xJPhuQ4FWRV4DH
         +pAqqN/pIvNXajZrXfh7gnReOmuyZCtVZYzh39x6VWZoZDQNJ4Up4MIl/7V+86ENoSiV
         bGCg==
X-Gm-Message-State: APjAAAVLLVaUgWbIOl3HCF4JLxibU8e+txSKwYz+14Mk5ktj7asypb9T
        KiIh8qrUWxi5357cqQL5AF1fong70Zf8PXdNJBau5Q==
X-Google-Smtp-Source: APXvYqx2L3MW/1bgQUg45dA1Z91iTEEgqOs4v9WdbRnDoWq8eMf71SjwOalt9zG3ldR2tj+5WPs9XJ17SMP/l8HXZoR6rw==
X-Received: by 2002:a1f:7c0e:: with SMTP id x14mr9606134vkc.0.1566260355122;
 Mon, 19 Aug 2019 17:19:15 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:18:01 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-26-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 25/29] kexec: Allow kexec_file() with appropriate IMA
 policy when locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Systems in lockdown mode should block the kexec of untrusted kernels.
For x86 and ARM we can ensure that a kernel is trustworthy by validating
a PE signature, but this isn't possible on other architectures. On those
platforms we can use IMA digital signatures instead. Add a function to
determine whether IMA has or will verify signatures for a given event type,
and if so permit kexec_file() even if the kernel is otherwise locked down.
This is restricted to cases where CONFIG_INTEGRITY_TRUSTED_KEYRING is set
in order to prevent an attacker from loading additional keys at runtime.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 include/linux/ima.h                 |  9 ++++++
 kernel/kexec_file.c                 | 10 +++++-
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_main.c   |  2 +-
 security/integrity/ima/ima_policy.c | 50 +++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 00036d2f57c3..8e2f324fb901 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -129,4 +129,13 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 	return 0;
 }
 #endif /* CONFIG_IMA_APPRAISE */
+
+#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
+extern bool ima_appraise_signature(enum kernel_read_file_id func);
+#else
+static inline bool ima_appraise_signature(enum kernel_read_file_id func)
+{
+	return false;
+}
+#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
 #endif /* _LINUX_IMA_H */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 43109ef4d6bf..7f4a618fc8c1 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -208,7 +208,15 @@ kimage_validate_signature(struct kimage *image)
 			return ret;
 		}
 
-		return security_locked_down(LOCKDOWN_KEXEC);
+		/* If IMA is guaranteed to appraise a signature on the kexec
+		 * image, permit it even if the kernel is otherwise locked
+		 * down.
+		 */
+		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
+		    security_locked_down(LOCKDOWN_KEXEC))
+			return -EPERM;
+
+		return 0;
 
 		/* All other errors are fatal, including nomem, unparseable
 		 * signatures and signature check failures - even if signatures
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ca10917b5f89..874bd77d3b91 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -111,6 +111,8 @@ struct ima_kexec_hdr {
 	u64 count;
 };
 
+extern const int read_idmap[];
+
 #ifdef CONFIG_HAVE_IMA_KEXEC
 void ima_load_kexec_buffer(void);
 #else
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1cffda4412b7..1747bc7bcb60 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -469,7 +469,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	return 0;
 }
 
-static const int read_idmap[READING_MAX_ID] = {
+const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 7b53f2ca58e2..b8773f05f9da 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1339,3 +1339,53 @@ int ima_policy_show(struct seq_file *m, void *v)
 	return 0;
 }
 #endif	/* CONFIG_IMA_READ_POLICY */
+
+#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
+/*
+ * ima_appraise_signature: whether IMA will appraise a given function using
+ * an IMA digital signature. This is restricted to cases where the kernel
+ * has a set of built-in trusted keys in order to avoid an attacker simply
+ * loading additional keys.
+ */
+bool ima_appraise_signature(enum kernel_read_file_id id)
+{
+	struct ima_rule_entry *entry;
+	bool found = false;
+	enum ima_hooks func;
+
+	if (id >= READING_MAX_ID)
+		return false;
+
+	func = read_idmap[id] ?: FILE_CHECK;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, ima_rules, list) {
+		if (entry->action != APPRAISE)
+			continue;
+
+		/*
+		 * A generic entry will match, but otherwise require that it
+		 * match the func we're looking for
+		 */
+		if (entry->func && entry->func != func)
+			continue;
+
+		/*
+		 * We require this to be a digital signature, not a raw IMA
+		 * hash.
+		 */
+		if (entry->flags & IMA_DIGSIG_REQUIRED)
+			found = true;
+
+		/*
+		 * We've found a rule that matches, so break now even if it
+		 * didn't require a digital signature - a later rule that does
+		 * won't override it, so would be a false positive.
+		 */
+		break;
+	}
+
+	rcu_read_unlock();
+	return found;
+}
+#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
-- 
2.23.0.rc1.153.gdeed80330f-goog

