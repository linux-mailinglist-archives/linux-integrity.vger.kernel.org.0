Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105F42D4AD8
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Dec 2020 20:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbgLITrE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Dec 2020 14:47:04 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47476 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387878AbgLITnG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Dec 2020 14:43:06 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id F40A620B7187;
        Wed,  9 Dec 2020 11:42:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F40A620B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607542944;
        bh=LMWnZCiY5cIy755ozh0nv0ZfFVIOc+VpzHbc2Bru8eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+DZsKu0vi8vkKKXH+CH+0qc6r6uN7UcEE8N7i9U/L4XKXoVLja0+kRyR1MUHvsji
         UQSlmIAMBosDI9CE58BW31jqI0A+lvzw8k63fVYLih9oax8T+4k5BsHl693y9ratxt
         5wlHfJGIgDKriT+C6DsQzC+kgqTDHyaUrPl8VzMs=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v7 3/8] IMA: define a hook to measure kernel integrity critical data
Date:   Wed,  9 Dec 2020 11:42:07 -0800
Message-Id: <20201209194212.5131-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
References: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA provides capabilities to measure file data, and in-memory buffer
data. However, various data structures, policies, and states
stored in kernel memory also impact the integrity of the system.
Several kernel subsystems contain such integrity critical data. These
kernel subsystems help protect the integrity of a device. Currently,
IMA does not provide a generic function for kernel subsystems to measure
their integrity critical data.
 
Define a new IMA hook - ima_measure_critical_data to measure kernel
integrity critical data.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  2 +-
 include/linux/ima.h                  |  6 +++++
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_api.c     |  2 +-
 security/integrity/ima/ima_main.c    | 36 ++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c  |  2 ++
 6 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index e35263f97fc1..6ec7daa87cba 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -32,7 +32,7 @@ Description:
 			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK]MODULE_CHECK]
 			        [FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
-				[KEXEC_CMDLINE] [KEY_CHECK]
+				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/include/linux/ima.h b/include/linux/ima.h
index ac3d82f962f2..675f54db6264 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,6 +30,9 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
+extern void ima_measure_critical_data(const char *event_name,
+				      const void *buf, int buf_len,
+				      bool measure_buf_hash);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
@@ -122,6 +125,9 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 }
 
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
+static inline void ima_measure_critical_data(const char *event_name,
+					     const void *buf, int buf_len,
+					     bool measure_buf_hash) {}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index fa3044a7539f..7d9deda6a8b3 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -201,6 +201,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	hook(POLICY_CHECK, policy)			\
 	hook(KEXEC_CMDLINE, kexec_cmdline)		\
 	hook(KEY_CHECK, key)				\
+	hook(CRITICAL_DATA, critical_data)		\
 	hook(MAX_CHECK, none)
 
 #define __ima_hook_enumify(ENUM, str)	ENUM,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index af218babd198..9917e1730cb6 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -176,7 +176,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
- *	| KEXEC_CMDLINE | KEY_CHECK
+ *	| KEXEC_CMDLINE | KEY_CHECK | CRITICAL_DATA
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 03aad13e9e70..ae59f4a4dd70 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -922,6 +922,42 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	fdput(f);
 }
 
+/**
+ * ima_measure_critical_data - measure kernel integrity critical data
+ * @event_name: event name to be used for the buffer entry
+ * @buf: pointer to buffer containing data to measure
+ * @buf_len: length of buffer(in bytes)
+ * @measure_buf_hash: measure buffer hash
+ *
+ * Measure the kernel subsystem data, critical to the integrity of the kernel,
+ * into the IMA log and extend the @pcr.
+ *
+ * Use @event_name to describe the state/buffer data change.
+ * Examples of critical data (buf) could be kernel in-memory r/o structures,
+ * hash of the memory structures, or data that represents subsystem state
+ * change.
+ *
+ * If @measure_buf_hash is set to true - measure hash of the buffer data,
+ * else measure the buffer data itself.
+ * measure_buf_hash can be used to save space, if the data being measured
+ * is too large.
+ *
+ * The data (buf) can only be measured, not appraised.
+ */
+void ima_measure_critical_data(const char *event_name,
+			       const void *buf, int buf_len,
+			       bool measure_buf_hash)
+{
+	if (!event_name || !buf || !buf_len) {
+		pr_err("Invalid arguments passed to %s().\n", __func__);
+		return;
+	}
+
+	process_buffer_measurement(NULL, buf, buf_len, event_name,
+				   CRITICAL_DATA, 0, NULL,
+				   measure_buf_hash);
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 25419c7ff50b..2a0c0603626e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1251,6 +1251,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else if (IS_ENABLED(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) &&
 				 strcmp(args[0].from, "KEY_CHECK") == 0)
 				entry->func = KEY_CHECK;
+			else if (strcmp(args[0].from, "CRITICAL_DATA") == 0)
+				entry->func = CRITICAL_DATA;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.17.1

