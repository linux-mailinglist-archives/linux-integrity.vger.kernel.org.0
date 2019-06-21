Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA94DE7E
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2019 03:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfFUBU5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Jun 2019 21:20:57 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:49119 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfFUBUy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:54 -0400
Received: by mail-qt1-f201.google.com with SMTP id z5so6079088qth.15
        for <linux-integrity@vger.kernel.org>; Thu, 20 Jun 2019 18:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hI61hPrGDQuqCDhatsEmznys0LPDvrfd2WbVsV7UPlg=;
        b=J1p1myPry3G2fUhRn1sffqnju98JLVJqNUMbfDNOtphQZpXO3fpYpw/a4lbjBPniQb
         aCTgIafzreRY8icd+M+H+5cvzIqfukazZO6CGeR31o5OzYs+jov87odip1NwcsZjGekc
         lxQPdPdYK28zE4AaDuIVFTMRGVrO6c663/NEihelit38tv6umY5YEpfVMaAX4jJVND8D
         4vnCD09qfgMnawFajy6vOuk62JBU1Wgm9LvvtbxEsgneHJflqoPqpUjz6v/cAeqaZI/j
         l43OJ6g+icDETdpMEk7IBVtMzENAytYUYP+FXyw0wtAhkJyzb1kGCWOpPrUBm07JNpnB
         6HJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hI61hPrGDQuqCDhatsEmznys0LPDvrfd2WbVsV7UPlg=;
        b=HzDCN8SIF/KY3O+7xn9sE0QiRzbiub4NqQ7rGf1BTNXTHLTNrkka2YfCTFwLpKjyra
         Xf5vJIcNeEPWO7xpodUt52Nx2G3X28EcyZQ4ju2eBirsLVugy7m6iLck+8i5Ky9DcBRu
         OtuNE9gfDDTWkqIg0b+Fq8CmgSc1JnnfXJWuxuSKcxqXZfK8nO6GTk/P+4gkHs9rNXu0
         7WEPQJ+lO5Zaktc3tqhzXuuXoo71nh0QXL7IpN/Qn4UYrYciB4tP98+LW16rvOE/Jb5+
         3fIEFMVo6F9Oi5KOZFvmfg1i7+gBNUsj6WZnK3ZDbAq4QEpI7m23hWzkEvfPysttR0H7
         M8Cw==
X-Gm-Message-State: APjAAAWKIFaL//fDQC6OwOGqsorMmktP/dvomhJzWCK1tYvYnkULQlCG
        KVSBayKj20wFxQv3Mixj8JTi2oJ6RmuFiburl6GzYg==
X-Google-Smtp-Source: APXvYqw9ks+4ahlKFd17q9x+JwDgQJiHAxvS1dKlBQiL6Fz1/eyLbP0EfwI4hRqIAQo2QMxUg8hlItNkr7/+o3bkavZvGg==
X-Received: by 2002:a0c:b010:: with SMTP id k16mr42793207qvc.170.1561080052987;
 Thu, 20 Jun 2019 18:20:52 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:37 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-27-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 26/30] kexec: Allow kexec_file() with appropriate IMA
 policy when locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
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
---
 include/linux/ima.h                 |  9 ++++++
 kernel/kexec_file.c                 |  7 +++-
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_main.c   |  2 +-
 security/integrity/ima/ima_policy.c | 50 +++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index dc12fbcf484c..c30954acc660 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -132,4 +132,13 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
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
index 455f4fc794f3..8134da6573c6 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -240,7 +240,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 
 		ret = 0;
 
-		if (security_is_locked_down(LOCKDOWN_KEXEC)) {
+		/* If IMA is guaranteed to appraise a signature on the kexec
+		 * image, permit it even if the kernel is otherwise locked
+		 * down.
+		 */
+		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
+		    security_is_locked_down(LOCKDOWN_KEXEC)) {
 			ret = -EPERM;
 			goto out;
 		}
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..3bc62062cfe8 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -115,6 +115,8 @@ struct ima_kexec_hdr {
 	u64 count;
 };
 
+extern const int read_idmap[];
+
 #ifdef CONFIG_HAVE_IMA_KEXEC
 void ima_load_kexec_buffer(void);
 #else
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..927fe889201a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -473,7 +473,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	return 0;
 }
 
-static const int read_idmap[READING_MAX_ID] = {
+const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0cc323f948f..8784449918e2 100644
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
2.22.0.410.gd8fdbe21b5-goog

