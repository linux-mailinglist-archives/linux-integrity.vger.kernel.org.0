Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97349244E4
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2019 02:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfEUAGw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 May 2019 20:06:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45941 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfEUAGw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 May 2019 20:06:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id i21so7545314pgi.12;
        Mon, 20 May 2019 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U/AtKdH1X5etutLrjMupbicBsqHo7eOYlc1fu2CjeOg=;
        b=Wxlxe5ooDvuYSuuaz4UPFjxn8yUh3iBe3vONjM43XTHb1v6RTzCxD23y4Dx4q8DljS
         gfXGBmSCE7fDIWCJQKvMhu+mORKiah/YKrWjoH6Yp6ESNhgd9ev0rpU+5oIzUmZl8O1p
         xXzywFGHaRPZsDEeecS1KAPbu2LXydQ67kmoeJ2eQWTdGy7K9OxKDvyB+ZYn/n7Wj4dX
         9V8BLb3B7hA4BWmln3KtOEe898JpIx97NF+SUiaNPX3D6ab91cU41Fqqnf2wlKNzzShb
         2m85hmR0EVoK+/jS/nvg9OUEVFnj17uHeYAE5pJqjdVXsgevjCVHvqCau/X6i1Lsa0Sm
         2aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U/AtKdH1X5etutLrjMupbicBsqHo7eOYlc1fu2CjeOg=;
        b=PYgSuRGjdOn/XlSTBhWeqMWrrDZnwqKhvx4aFU/asM90NRzu1cfM1OEYEbKbyng/Ns
         RfRPDOhLe+a5MmzVLeCDA6Pw/D/aoX9LEV963ixhAWRFUYSiMQtndKWScQOzikMgwJot
         7QuA7BcFPMHpEt1mBCPh+dHnxPzVP587ERbdnAFoWoFk018x1Nf1R19kOwbUDIA6B7Qa
         5mRkR9bbpqni/a85Ql5D+J3vlxteADXPgHAVhzGjjpL2QG07BtBFw2fF0La5GKJC4sZX
         vxI4Pp2vheGOgetig7OfBRgRjltl4TLLnzcl7EAT9vaocwTmnP1uXt9mMg/xo6Eg74Mx
         1W+A==
X-Gm-Message-State: APjAAAVWZfMxY1oP7dWUHXV/Eei1h3XzLig0McazJCDo9skKBd2JZah6
        be4R/qADH5PaRowGpH2o+g1eVkFAiW/wqg==
X-Google-Smtp-Source: APXvYqyNo4YpyKICOFtq2BuyOdLZylHnTR8DKr/rFxHJRd5iL1ZE/eKeu5Q1lo5+ctPfSdpfKHVasA==
X-Received: by 2002:a62:128a:: with SMTP id 10mr82715681pfs.225.1558397210961;
        Mon, 20 May 2019 17:06:50 -0700 (PDT)
Received: from prsriva-Precision-Tower-5810.corp.microsoft.com ([2001:4898:80e8:1:e5e3:4312:180a:c25e])
        by smtp.gmail.com with ESMTPSA id i16sm5939149pfd.100.2019.05.20.17.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 17:06:50 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mjg59@google.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        vgoyal@redhat.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH v6 1/3] Add a new ima hook ima_kexec_cmdline to measure cmdline args
Date:   Mon, 20 May 2019 17:06:43 -0700
Message-Id: <20190521000645.16227-2-prsriva02@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521000645.16227-1-prsriva02@gmail.com>
References: <20190521000645.16227-1-prsriva02@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently during kexec_file_load(soft reboot) the cmdline args
passed are not measured and the PCR values are not reset.
This results in the new kernel to assume a secure boot was
followed. The boot args used to launch the new kernel need to be
measured and carried over to the next kernel to be used for
attestation. IMA supports only measuring files, no functionality
exists to measure a buffer(kexec cmdline).

This change adds a new functionality to measure buffers
process_buffer_measurement which uses the hash of the buffer
instead of file hash to add an entry in the ima log.
A new ima hook ima_kexec_cmdline is also defined which calls
into process_buffer_measurement to add the kexec_cmdline args
to the log.

A new policy KEXEC_CMDLINE is also defined to control measuring the
kexec_cmdline buffer.
This patch only adds IMA_MEASURE as a supported functionality.

- A new ima hook ima_kexec_cmdline is defined to be called by the
kexec code.
- A new function process_buffer_measurement is defined to measure
the buffer hash into the ima log.
- A new func policy KEXEC_CMDLINE is defined to control the measurement.

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
index 357edd140c09..a88c28918a63 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -576,6 +576,83 @@ int ima_load_data(enum kernel_load_data_id id)
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
+	ret = ima_alloc_init_template(&event_data, &entry);
+	if (ret < 0)
+		goto out;
+
+	if (action & IMA_MEASURE)
+		ret = ima_store_template(entry, violation, NULL, buf, pcr);
+
+	if (ret < 0) {
+		ima_free_template_entry(entry);
+	}
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
2.17.1

