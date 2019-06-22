Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC634F274
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Jun 2019 02:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfFVAFH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Jun 2019 20:05:07 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45959 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfFVAFF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Jun 2019 20:05:05 -0400
Received: by mail-pg1-f202.google.com with SMTP id k2so4989978pga.12
        for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2019 17:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TMklhc9+XfiI8L3K2AutSbeZaJ7HLQ2HsXG+mlV/TZs=;
        b=p7vfmYbicP0O5OJzjFHdr94n1dC4CJO8yX/92U2d2BTbbGPpuy00yXNd9NLehfmCFV
         5XqqdDRq+j7IDKg4ECOxaLzyDNdD8IRWnSj4RlJg+fnqujjgDyfVtsIJ9EOZPvHQpXUF
         rFQ6bRCqsV8oHm1TLKJCR1V5tdwwsJJaH3HL1oCf+hG2ILKmD0gxGnsJmF9ggXD1qJsP
         dyX+p6/3+RHtCJNz5ZK7L9Ir/FRDlefa1IqIXWmOpCGGurVyGN5/+sfdEvh3UMqC2Utp
         4zkAY8boj/uZNoZnDEBzHHNWlw88TuW2EXhkMlcVLRtlhNAVlAt/WOZPPBD7NHwAMiy5
         zcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TMklhc9+XfiI8L3K2AutSbeZaJ7HLQ2HsXG+mlV/TZs=;
        b=JVLZclUU8pxgMRgNoDJWhE/PNE+tD7/Ynmt0VPQgpQY1g68RVtDv2476gYQIqvEV7Q
         mE8Kpbl5C4MRNUncyEfO6YIC6jwY00l2MF/tlHIfL+PhN7X8TPSFZqt3FPc3xCOf/tBO
         JC3OylwsaUOakM0eTIWdA6qXcxV/r7GtroczDEzHP1pH1uAlzXAWL8gnobagdfIbgWfD
         Hm/wZdGdxrfEh4harESrgBgUDfS5Tx373mHrnLRTEAdHCZD/ijILEV3r5zVXnyqP3mE8
         u32E4UXDYfy2NIAaJzl2NHLjHwBL3MVNJEDZT1+6Ob1OFRip8o95xQxYS7VMaeQiKipR
         x7pw==
X-Gm-Message-State: APjAAAXrjiax+DybliGfliJ5mhgV1/GHpCL/nMCDQxqOx211wBvns7nZ
        v8wqcrmCIk5ARz22mFL51HgNJtOT3w20gtlOLWNaaw==
X-Google-Smtp-Source: APXvYqyiFQ+2Cd5OSyAvJhYhgYOd8VHPKVlHOgHk3dAwEgc6MxZt9cRi1sgqABuTYgGBeTygjlYiJdOudBsv5yQQd+2tYg==
X-Received: by 2002:a63:2258:: with SMTP id t24mr12689918pgm.236.1561161904729;
 Fri, 21 Jun 2019 17:05:04 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:54 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-26-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 25/29] kexec: Allow kexec_file() with appropriate IMA
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
---
 include/linux/ima.h                 |  9 ++++++
 kernel/kexec_file.c                 | 11 +++++--
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_main.c   |  2 +-
 security/integrity/ima/ima_policy.c | 50 +++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 3 deletions(-)

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
index 27adb4312b03..539d0ca855bc 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -237,8 +237,15 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			goto out;
 		}
 
-		ret = security_locked_down(LOCKDOWN_KEXEC);
-		if (ret)
+		ret = 0;
+
+		/* If IMA is guaranteed to appraise a signature on the kexec
+		 * image, permit it even if the kernel is otherwise locked
+		 * down.
+		 */
+		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
+		    security_locked_down(LOCKDOWN_KEXEC)) {
+			ret = -EPERM;
 			goto out;
 
 		break;
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

