Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC521A53F
	for <lists+linux-integrity@lfdr.de>; Sat, 11 May 2019 00:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfEJWcp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 May 2019 18:32:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40738 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfEJWco (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 May 2019 18:32:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so3651115pgl.7;
        Fri, 10 May 2019 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FwAAmLcH+s5ZzGkBypF7IB+h+fV8RUi6+x5FryDeaRc=;
        b=MyFxBNbTJrklt27JHMuc+0WhAdVJDIiI5IiSQpqka7kY0+fxvNU84XhesVwLavjwq/
         BF4HY+mlb0aJADPjrIccRFtwQoTRDSZHWrmE6INSqxTtyKa4rOhSQWGdCBRHFzowYwoM
         rpmCA+a7idxqHBMlMBsvI0WiiYz3Q48FftD4UGuhTAGPXlnh0k4YzbdGbimZeNfC1gUZ
         e1WpKX+5yGqOR4GttOAPcx144W3uvmdFabj4xUCZhCMtqcKaexYRDy1qFp4b7VUbpQaR
         lMfYeLS2lxFmK3hLcL/NdVFl/uNFutoKqK7ESO+2aPbOAjKkl/e9e9ac+sl/3gZGGP8+
         v0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwAAmLcH+s5ZzGkBypF7IB+h+fV8RUi6+x5FryDeaRc=;
        b=CQbfQZocZcvG+WePFU0hOpm/BUkHDu+/Fjci6GfPk2SuSwmudi76K4Xh0yoLPVBnoe
         6mtUHd11H+//zldfd933kDkVyRT9Xr4H/xUYScXUBJo++aKl8RaHvPgL8w+HRBCNv+zs
         mprGLvAoelDwNzJwFqYd3l9a6oaLmL4Cz4remlVS1mKiZigp+AHikWW6RGmQdeqkjavM
         C5we2AIGW9ENu++sTQwYGpoCHxr1WtfgrGPykMTjWwrataAhDwGyt1R1YS9BC/y092S3
         iRbt4vjAL6XjzKEIR8GONBwyPB88q0bcVzt+Bl27yiRwgh/ht9v9laxcWoO08fH35hUP
         xpiQ==
X-Gm-Message-State: APjAAAUB9Zf4gKfMSc60fnoYqfUXVkwLRkztm/bQWlMT3Grx2tZ//wmV
        ohs9y2yYCcqwKLBWoWyRehZ939EHODw=
X-Google-Smtp-Source: APXvYqzVLJu1V/2EbPQSqCzR7Yj0gGXxFJiNpPJtQQ8NSNw0uKze8oqqLB6phaX4KdLvqqelNG8VpA==
X-Received: by 2002:aa7:9a8c:: with SMTP id w12mr17308029pfi.187.1557527563161;
        Fri, 10 May 2019 15:32:43 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:a:1d1b:db59:93e9:eab5])
        by smtp.gmail.com with ESMTPSA id g72sm16907374pfg.63.2019.05.10.15.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:32:42 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        prsriva@microsoft.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 1/3 v5] add a new ima hook and policy to measure the cmdline
Date:   Fri, 10 May 2019 15:32:26 -0700
Message-Id: <20190510223228.9966-2-prsriva02@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510223228.9966-1-prsriva02@gmail.com>
References: <20190510223228.9966-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

For this reason, this patch adds support for measuring these
parameters during kexec. To achive this, a new ima policy and
hook id, defined KEXEC_CMDLINE and ima_kexec_cmdline respectively,
are added.

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 Documentation/ABI/testing/ima_policy |  1 +
 include/linux/ima.h                  |  2 +
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_api.c     |  1 +
 security/integrity/ima/ima_main.c    | 84 ++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c  |  9 +++
 6 files changed, 98 insertions(+)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 74c6702de74e..62e7cd687e9c 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,6 +29,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
+				[KEXEC_CMDLINE]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/include/linux/ima.h b/include/linux/ima.h
index dc12fbcf484c..2e2c77280be8 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -26,6 +26,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
+extern void ima_kexec_cmdline(const void *buf, int size);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -92,6 +93,7 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 	return;
 }
 
+static inline void ima_kexec_cmdline(const void *buf, int size) {}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..226a26d8de09 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -184,6 +184,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_KERNEL_CHECK)	\
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
+	hook(KEXEC_CMDLINE)		\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c7505fb122d4..800d965232e5 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -169,6 +169,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
+ *	| KEXEC_CMDLINE
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..1d186bda25fe 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -576,6 +576,90 @@ int ima_load_data(enum kernel_load_data_id id)
 	return 0;
 }
 
+/*
+ * process_buffer_measurement - Measure the buffer passed to ima log.
+ * (Instead of using the file hash use the buffer hash).
+ * @buf - The buffer that needs to be added to the log
+ * @size - size of buffer(in bytes)
+ * @eventname - event name to be used for buffer.
+ *
+ * The buffer passed is added to the ima log.
+ *
+ * On success return 0.
+ * On error cases surface errors from ima calls.
+ */
+static int process_buffer_measurement(const void *buf, int size,
+				const char *eventname, const struct cred *cred,
+				u32 secid)
+{
+	int ret = 0;
+	struct ima_template_entry *entry = NULL;
+	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
+	struct ima_event_data event_data = {iint, NULL, NULL,
+						NULL, 0, NULL};
+	struct {
+		struct ima_digest_data hdr;
+		char digest[IMA_MAX_DIGEST_SIZE];
+	} hash;
+	int violation = 0;
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	int action = 0;
+
+	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr);
+	if (!(action & IMA_AUDIT) && !(action & IMA_MEASURE))
+		goto out;
+
+	memset(iint, 0, sizeof(*iint));
+	memset(&hash, 0, sizeof(hash));
+
+	event_data.filename = eventname;
+
+	iint->ima_hash = &hash.hdr;
+	iint->ima_hash->algo = ima_hash_algo;
+	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
+
+	ret = ima_calc_buffer_hash(buf, size, iint->ima_hash);
+	if (ret < 0)
+		goto out;
+
+	ret = ima_alloc_init_template(&event_data, &entry);
+	if (ret < 0)
+		goto out;
+
+	if (action & IMA_MEASURE)
+		ret = ima_store_template(entry, violation, NULL, buf, pcr);
+
+	if (action & IMA_AUDIT)
+		ima_audit_measurement(iint, event_data.filename);
+
+	if (ret < 0) {
+		ima_free_template_entry(entry);
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+/**
+ * ima_kexec_cmdline - based on policy, store kexec cmdline args
+ * @buf: pointer to buffer
+ * @size: size of buffer
+ *
+ * Buffers can only be measured, not appraised.
+ */
+void ima_kexec_cmdline(const void *buf, int size)
+{
+	u32 secid;
+
+	if (buf && size != 0) {
+		security_task_getsecid(current, &secid);
+		process_buffer_measurement(buf, size, "kexec-cmdline",
+				current_cred(), secid);
+	}
+}
+
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0cc323f948f..413e5921b248 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -291,6 +291,13 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
+	/* only incase of KEXEC_CMDLINE, inode is NULL */
+	if (func == KEXEC_CMDLINE) {
+		if ((rule->flags & IMA_FUNC) &&
+			(rule->func == func) && (!inode))
+			return true;
+		return false;
+	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
 		return false;
@@ -869,6 +876,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = KEXEC_INITRAMFS_CHECK;
 			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
 				entry->func = POLICY_CHECK;
+			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
+				entry->func = KEXEC_CMDLINE;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.20.1

