Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9765023C
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2019 08:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfFXGYv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jun 2019 02:24:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43630 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfFXGYu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jun 2019 02:24:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so6883566pfg.10;
        Sun, 23 Jun 2019 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HN5YV7Qd60ZchgjEv31k3P0Qt+jZVdCRyjf0E8NQ2IU=;
        b=ew5JlFz78/vAGM1p3EWka0Sw90/OUAbwMN8yHBT2ow1tdSdzGppSon0kLy2UbkHfy7
         MWUzPBmOwbyQPN0QnAOEFS/peTDPD6kPWDl78wYXXem+V39cNUkmV9Q6b5XINUsMSd02
         zUVbrawiSb+dpjpKXBR05ZSpyTuAgIpnHDDvp0KBRi3YFytxhcNvasxF4B9/kpvEaC9i
         fcC2Va8vDhpoSM5O/XJxTNj6Xarzy8//Xe46M8BCxrw1or+84Q0MJAZlMYZkTNeE3CJF
         0+e9GNAZ/t4CR/WhyGyvcVxAOOeQq8vtbtyQgT3QZfvgdePKkPYDkd4HretCPclFhKXq
         knAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HN5YV7Qd60ZchgjEv31k3P0Qt+jZVdCRyjf0E8NQ2IU=;
        b=dnEGC7wtvWa2u9QvUsxb5AQxq8i9CqLZkpYUF7UGZHC6hYWELJlhpEXK51TteD7il9
         FwzxzHkJc24ihW7RWptjwuPDYVEJMm+WRppnTNZkYPBFlRQiQMKAZ8IdFnx8fkTZBFKc
         cHCo9Gv5FqvZG1mNPjoaqITiVfd9QfSlVnqbffA+CzKpS+nPn0emS4+ZYSvfVmTvavlU
         kbbjtw2alCi1yf0PbHw2yhlRhJpBWmgNql2myNb4LFicTrlDYv8LO4/mOUpM+OikjHyo
         2OESfFA1zE4663d5W1sOCw5poJOQh6bQldJPcoXXkP5hXRrfe921/1zKRwJsYpTp3kOU
         RX+g==
X-Gm-Message-State: APjAAAWyGo9ltBmZuyRQBlmpQxIRqtaP6rNghunfIphPFy2EB77dHBIn
        v6lHSwYT/R/CQwNlSBFXrGP+28N2
X-Google-Smtp-Source: APXvYqwwqJxH6lHL8DCu/LqNlnM/FPDDRO1LQPR261ZvI/iFdxKmufP+WZFYBeuQy4r8fn3Qb4FVgw==
X-Received: by 2002:a63:c10d:: with SMTP id w13mr30892813pgf.28.1561357489701;
        Sun, 23 Jun 2019 23:24:49 -0700 (PDT)
Received: from prsriva-ThinkPad-P50s.hsd1.wa.comcast.net ([2601:602:9c01:c794:e00a:1dbc:5f62:b8ea])
        by smtp.gmail.com with ESMTPSA id 191sm2641620pfu.177.2019.06.23.23.24.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 23:24:49 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH V10 1/3] IMA: Define a new hook to measure the kexec boot command line arguments
Date:   Sun, 23 Jun 2019 23:23:29 -0700
Message-Id: <20190624062331.388-2-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624062331.388-1-prsriva02@gmail.com>
References: <20190624062331.388-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently during soft reboot(kexec_file_load) boot command line
arguments are not measured. Define hooks needed to measure kexec
command line arguments during soft reboot(kexec_file_load).

- A new ima hook ima_kexec_cmdline is defined to be called by the
kexec code.
- A new function process_buffer_measurement is defined to measure
the buffer hash into the IMA measurement list.
- A new func policy KEXEC_CMDLINE is defined to control the
 measurement.[Suggested by Mimi]

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 Documentation/ABI/testing/ima_policy |  1 +
 include/linux/ima.h                  |  2 +
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_api.c     |  1 +
 security/integrity/ima/ima_main.c    | 72 ++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c  |  7 +++
 6 files changed, 84 insertions(+)

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
index e7b9ea7732d9..bdca641f9e51 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -190,6 +190,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_KERNEL_CHECK)	\
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
+	hook(KEXEC_CMDLINE)		\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c0cf4bcfc82f..d426d4d1fe04 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -178,6 +178,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
+ *	| KEXEC_CMDLINE
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a7e7e2d7224c..2507bee1b762 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -609,6 +609,78 @@ int ima_load_data(enum kernel_load_data_id id)
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
+				       const char *eventname,
+				       const struct cred *cred, u32 secid)
+{
+	int ret = 0;
+	struct ima_template_entry *entry = NULL;
+	struct integrity_iint_cache iint = {};
+	struct ima_event_data event_data = {.iint = &iint,
+					    .filename = eventname};
+	struct ima_template_desc *template_desc = NULL;
+	struct {
+		struct ima_digest_data hdr;
+		char digest[IMA_MAX_DIGEST_SIZE];
+	} hash = {};
+	int violation = 0;
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	int action = 0;
+
+	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
+				&template_desc);
+	if (!(action & IMA_MEASURE))
+		return;
+
+	iint.ima_hash = &hash.hdr;
+	iint.ima_hash->algo = ima_hash_algo;
+	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
+
+	ret = ima_calc_buffer_hash(buf, size, iint.ima_hash);
+	if (ret < 0)
+		goto out;
+
+	ret = ima_alloc_init_template(&event_data, &entry, template_desc);
+	if (ret < 0)
+		goto out;
+
+	ret = ima_store_template(entry, violation, NULL, buf, pcr);
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
+					   current_cred(), secid);
+	}
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 98c289559079..a3058b03a955 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -374,6 +374,11 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
+	if (func == KEXEC_CMDLINE) {
+		if ((rule->flags & IMA_FUNC) && (rule->func == func))
+			return true;
+		return false;
+	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
 		return false;
@@ -956,6 +961,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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

