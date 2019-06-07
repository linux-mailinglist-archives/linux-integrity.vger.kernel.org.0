Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABBE38217
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 02:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfFGAYB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jun 2019 20:24:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32914 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfFGAYB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 20:24:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so175791pgv.0;
        Thu, 06 Jun 2019 17:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hckSLCeKIoVXacDaHtL22Ml1ZlZHnr9jEMcdvvjf21A=;
        b=V2BrLf52zYKJtKuhz9EPieT3mUwYCTvb3g3eRnfwEv9utmNgsUgY7+UuX2BISQxb0l
         sVaX2RY1IGXJSRkxvyw4s5zr9gjMue8YQfxVq7vivBPM1j7DO1DYa5BpU2BbUBoX88vw
         UAgUB6tafTZAjXB5RPmFQ7UNhFrGfbFPAA7f5KHf02oqYy8K+hDkwG6RWTdvTv5ylC5L
         QWTIHbZtX4BWa5HUvrV3R/o7d5mR9NInZJx0QyHNX723Z/Yr2RiaglvzrFWQlfnUcVHR
         EqcI8C3KVMBk2Sb8R2PR2SmZ7cBQT8VPeTrRFe9RhD4AF+gMZoAc+3TGq2VoEWryXoaJ
         NwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hckSLCeKIoVXacDaHtL22Ml1ZlZHnr9jEMcdvvjf21A=;
        b=WM3ihONmLu0nxQmo95pR5AhbWLzASUScaK56X1Kjy5DeuzLl/jLBVaRD7HOWWaXq+b
         9FIqlBGJWO6MBEENGnKkl1/Hevuzx7RoCWIAJqP0/MwS9OZGcxgD1AfGiRt4tLIxHfuJ
         1MUDeJ3utwv3r64R8v7cGvTzzIdJ6Kv2yj8yfEnbhyoDz/Q4LFxjKRb0oTQxi2bjcGZ7
         7Y77G7i0N5OUEWhYEYaGvaOXW7TtRP1VIORL/bxYMfJIRqnRvtiBF3GJvK5XVAvOkJeY
         OnsCYz2vryGzoO+BuIwwadZb1uNnj6n413G4W+z1vtetO7yAwnUFLhlbvFTPiobt8kFC
         wGhA==
X-Gm-Message-State: APjAAAVoLuuuf0TeQt0ZPNruN1w7ioYorNiCIOuEsp7j8oa8VM3akEnb
        HyUGKKhS9FVIXpxA07jjiAp6i5CL
X-Google-Smtp-Source: APXvYqxi7sHr8OXL/S7kcw7Tew3717zgBGZg5pnkMk0Bfl6VD1x2nwijHrWAmYRjDv3YotxhJF5pdg==
X-Received: by 2002:a63:ff0c:: with SMTP id k12mr461445pgi.32.1559867040014;
        Thu, 06 Jun 2019 17:24:00 -0700 (PDT)
Received: from localhost.localdomain ([167.220.98.69])
        by smtp.gmail.com with ESMTPSA id o13sm324179pfh.23.2019.06.06.17.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 17:23:59 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH v7 1/3] Add a new ima hook ima_kexec_cmdline to measure cmdline args
Date:   Thu,  6 Jun 2019 17:23:28 -0700
Message-Id: <20190607002330.2999-2-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190607002330.2999-1-prsriva02@gmail.com>
References: <20190607002330.2999-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch adds support in ima to measure kexec cmdline args
during soft reboot kexec_file_load.

- A new ima hook ima_kexec_cmdline is defined to be called by the
kexec code.
- A new function process_buffer_measurement is defined to measure
the buffer hash into the ima log.
- A new func policy KEXEC_CMDLINE is defined to control the
 measurement.[Suggested by Mimi]

Hash computation can be tested using
sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements | 
  grep  kexec-cmdline | cut -d' ' -f 6 | xxd -r -p | sha256sum

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 Documentation/ABI/testing/ima_policy |  1 +
 include/linux/ima.h                  |  2 +
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_api.c     |  1 +
 security/integrity/ima/ima_main.c    | 77 ++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c  |  9 ++++
 6 files changed, 91 insertions(+)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index b383c1763610..fc376a323908 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -28,6 +28,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
+				[KEXEC_CMDLINE]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/include/linux/ima.h b/include/linux/ima.h
index fd9f7cf4cdf5..b42f5a006042 100644
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
index 18b48a6d0b80..a4ad1270bffa 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -185,6 +185,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_KERNEL_CHECK)	\
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
+	hook(KEXEC_CMDLINE)		\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 78eb11c7ac07..ea7d8cbf712f 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -176,6 +176,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
+ *	| KEXEC_CMDLINE
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index af341a80118f..e4f301381ffb 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -605,6 +605,83 @@ int ima_load_data(enum kernel_load_data_id id)
 	return 0;
 }
 
+/*
+ * process_buffer_measurement - Measure the buffer to ima log.
+ * @buf: pointer to the buffer that needs to be added to the log.
+ * @size: size of buffer(in bytes).
+ * @eventname: event name to be used for the buffer entry.
+ * @cred: a pointer to a credentials structure for user validation.
+ * @secid: the secid of the task to be validated.
+ *
+ * Based on policy, the buffer is measured into the ima log.
+ */
+static void process_buffer_measurement(const void *buf, int size,
+				const char *eventname, const struct cred *cred,
+				u32 secid)
+{
+	int ret = 0;
+	struct ima_template_entry *entry = NULL;
+	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
+	struct ima_event_data event_data = {.iint = iint};
+	struct ima_template_desc *template_desc = NULL;
+	struct {
+		struct ima_digest_data hdr;
+		char digest[IMA_MAX_DIGEST_SIZE];
+	} hash;
+	int violation = 0;
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	int action = 0;
+
+	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
+					&template_desc);
+	if (!(action & IMA_MEASURE))
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
+	ret = ima_alloc_init_template(&event_data, &entry, template_desc);
+	if (ret < 0)
+		goto out;
+
+	if (action & IMA_MEASURE)
+		ret = ima_store_template(entry, violation, NULL, buf, pcr);
+
+	if (ret < 0)
+		ima_free_template_entry(entry);
+
+out:
+	return;
+}
+
+/**
+ * ima_kexec_cmdline - measure kexec cmdline boot args
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
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fd9b01881d17..98e351e13557 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -292,6 +292,13 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
@@ -880,6 +887,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = KEXEC_INITRAMFS_CHECK;
 			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
 				entry->func = POLICY_CHECK;
+			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
+				entry->func = KEXEC_CMDLINE;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.19.1

