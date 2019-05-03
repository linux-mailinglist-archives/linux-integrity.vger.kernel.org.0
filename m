Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7FD1357F
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2019 00:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfECWZb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 May 2019 18:25:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34731 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECWZb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 May 2019 18:25:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so3571440pfd.1;
        Fri, 03 May 2019 15:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BaAl3T5YxfM/1JfpIAfuXV3CrS6GA7YYTHBIDImU8Hc=;
        b=knPPgJFejR41jK8dhVk9qE/92sGnk8eZjxSD9NN5rgRiP+FJi4piT4/0cLw/YAebF2
         m2XYeD7n3E0+TXUH3WfT5DKvx19Zt6fe5nHpV6gSFTEuh7l+pb78CqlTFNxN8jbzTJO9
         jiO+A0R5GqLF5mGkW66Yvb9Tj7JwytQI9IxJTA4pu/0uAxWDOcAMbQZcdKmOJiHW4LJW
         q1Fw+Pw7WpCunouucgT9aZ5bntBotUe1fwBKr55jCrOxcMnEv+C/v5X3V+0K26yD/YSl
         7z0oEwD42xB2B24zoQewy7hZr+a39jz+lV2NxehPEZhdtZIQea76UH8dLb0dkkZQgSDj
         LOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BaAl3T5YxfM/1JfpIAfuXV3CrS6GA7YYTHBIDImU8Hc=;
        b=KRbIEFIaiVjLajIDcFO7s/5QG+sf7teaadt2ak1QfBUO55KsxJSnQ/cnroGJVved9O
         bVux4ey0g6kMfHI8BOcOh+gQmMRSh91hfw43PbBGitA0F55SnjWvjOy1UDVf+0d2XinJ
         C2i/9inGwnF/g7dbAj7x5eZghgMz8sKVoqUNYbe/dssUe9wefN9T9hb8tCrhjMIA3jfG
         tSIFENk/UL2AyIs6W1UtcFtDo3c9EoULNRxDXsDB9Z9MVWrZn1vvKoPJKIriNnHYzafo
         GAmC7B8X+UXf/AthkUpkamqZJzvvshlDjkAcHwyruqYLb48DONekzl34dP/tLLIlFzjC
         LiEw==
X-Gm-Message-State: APjAAAU8muaOCtDbyfxsrpTf6dErXD51oq2Io1oAnot06G7a5fZKbWET
        J7Sdp9U6FoyJlrzRF+NfanHSbarkjzI=
X-Google-Smtp-Source: APXvYqwUTrc4HbPUugEtms1cvz9SLMSlkIWqH4NUyCDeW6d8TPNwjR3Y1kBce6jiyflIkAC2HInpzw==
X-Received: by 2002:a65:654c:: with SMTP id a12mr13974588pgw.101.1556922329882;
        Fri, 03 May 2019 15:25:29 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:b:3170:1a6b:a13a:7ff])
        by smtp.gmail.com with ESMTPSA id j22sm4314337pfi.139.2019.05.03.15.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:25:28 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        nayna@linux.ibm.com, nramas@microsoft.com, prsriva@microsoft.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 1/5 v4] added a new ima policy func buffer_check, and ima hook to measure the buffer hash into ima
Date:   Fri,  3 May 2019 15:25:19 -0700
Message-Id: <20190503222523.6294-2-prsriva02@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503222523.6294-1-prsriva02@gmail.com>
References: <20190503222523.6294-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

This change adds a new ima policy func buffer_check, and ima hook to
 measure the buffer hash into ima log.

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 Documentation/ABI/testing/ima_policy |  1 +
 include/linux/ima.h                  |  5 ++
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_api.c     |  1 +
 security/integrity/ima/ima_main.c    | 89 ++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c  |  8 +++
 6 files changed, 105 insertions(+)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 74c6702de74e..12cfe3ff2dea 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,6 +29,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
+				[BUFFER_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/include/linux/ima.h b/include/linux/ima.h
index dc12fbcf484c..f0abade74707 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -26,6 +26,8 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
+extern void ima_buffer_check(const void *buff, int size,
+				const char *eventname);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -92,6 +94,9 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 	return;
 }
 
+static inline void ima_buffer_check(const void *buff, int size,
+		const char *eventname)
+{}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..de70df132575 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -184,6 +184,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_KERNEL_CHECK)	\
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
+	hook(BUFFER_CHECK)		\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c7505fb122d4..cb3f67b366f1 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -169,6 +169,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
+ *	| BUFFER_CHECK
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..3db3f3966ac7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -576,6 +576,95 @@ int ima_load_data(enum kernel_load_data_id id)
 	return 0;
 }
 
+/*
+ * process_buffer_measurement - Measure the buffer passed to ima log.
+ * (Instead of using the file hash the buffer hash is used).
+ * @buff - The buffer that needs to be added to the log
+ * @size - size of buffer(in bytes)
+ * @eventname - this is eventname used for the various buffers
+ * that can be measured.
+ *
+ * The buffer passed is added to the ima logs.
+ * If the sig template is used, then the sig field contains the buffer.
+ *
+ * On success return 0.
+ * On error cases surface errors from ima calls.
+ */
+static int process_buffer_measurement(const void *buff, int size,
+				const char *eventname, const struct cred *cred,
+				u32 secid)
+{
+	int ret = -EINVAL;
+	struct ima_template_entry *entry = NULL;
+	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
+	struct ima_event_data event_data = {iint, NULL, NULL,
+					    NULL, 0, NULL};
+	struct {
+		struct ima_digest_data hdr;
+		char digest[IMA_MAX_DIGEST_SIZE];
+	} hash;
+	int violation = 0;
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+
+	if (!buff || size ==  0 || !eventname)
+		goto err_out;
+
+	if (ima_get_action(NULL, cred, secid, 0, BUFFER_CHECK, &pcr)
+		!= IMA_MEASURE)
+		goto err_out;
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
+	ret = ima_calc_buffer_hash(buff, size, iint->ima_hash);
+	if (ret < 0)
+		goto err_out;
+
+	ret = ima_alloc_init_template(&event_data, &entry);
+	if (ret < 0)
+		goto err_out;
+
+	ret = ima_store_template(entry, violation, NULL,
+					buff, pcr);
+	if (ret < 0) {
+		ima_free_template_entry(entry);
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	pr_err("Error in adding buffer measure: %d\n", ret);
+	return ret;
+}
+
+/**
+ * ima_buffer_check - based on policy, collect & store buffer measurement
+ * @buf: pointer to buffer
+ * @size: size of buffer
+ * @eventname: event name identifier
+ *
+ * Buffers can only be measured, not appraised.  The buffer identifier
+ * is used as the measurement list entry name (eg. boot_cmdline).
+ */
+void ima_buffer_check(const void *buf, int size, const char *eventname)
+{
+	u32 secid;
+
+	if (buf && size != 0 && eventname) {
+		security_task_getsecid(current, &secid);
+		process_buffer_measurement(buf, size, eventname,
+				current_cred(), secid);
+	}
+}
+
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0cc323f948f..b12551ed191c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -291,6 +291,12 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
+	// Incase of BUFFER_CHECK, Inode is NULL
+	if (!inode) {
+		if ((rule->flags & IMA_FUNC) && (rule->func == func))
+			return true;
+		return false;
+	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
 		return false;
@@ -869,6 +875,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = KEXEC_INITRAMFS_CHECK;
 			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
 				entry->func = POLICY_CHECK;
+			else if (strcmp(args[0].from, "BUFFER_CHECK") == 0)
+				entry->func = BUFFER_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.20.1

