Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313D82A2226
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Nov 2020 23:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgKAW06 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 1 Nov 2020 17:26:58 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42006 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgKAW0j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Nov 2020 17:26:39 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id D7A1220B36E7;
        Sun,  1 Nov 2020 14:26:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7A1220B36E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604269597;
        bh=ykK8xizKxPwawSU0A4Yf3HkpQD34UbP8niKQC8VOGaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTDqpbD++mQJd8/E7aT0dnt2AQTzITTdMcq7LW1EN4i/YdIN8St6OTkU6Kf70hIoy
         PpT/KJ0/y4/K2j02b2C92JJkJlAKiWqnG3EdiEfsHHcm5fWQdKLQFkpMIqOmG5y4kY
         +gzhDMFOjHT7Cb7I4qF8FtHwUKmIuAUtXLkg+jg0=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v5 3/7] IMA: add hook to measure critical data
Date:   Sun,  1 Nov 2020 14:26:22 -0800
Message-Id: <20201101222626.6111-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently, IMA does not provide a generic function for kernel subsystems
to measure their critical data. Examples of critical data in this context
could be kernel in-memory r/o structures, hash of the memory structures,
or data that represents a linux kernel subsystem state change. The 
critical data, if accidentally or maliciously altered, can compromise
the integrity of the system.

A generic function provided by IMA to measure critical data would enable
various subsystems with easier and faster on-boarding to use IMA
infrastructure and would also avoid code duplication.

Add a new IMA func CRITICAL_DATA and a corresponding IMA hook
ima_measure_critical_data() to support measuring critical data for 
various kernel subsystems. 

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  2 +-
 include/linux/ima.h                  |  8 ++++++
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_api.c     |  2 +-
 security/integrity/ima/ima_main.c    | 38 ++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c  |  2 ++
 6 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index cd572912c593..3de6c774c37e 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,7 +29,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
-				[KEXEC_CMDLINE] [KEY_CHECK]
+				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8fa7bcfb2da2..60ba073f1575 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,6 +30,10 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
+extern void ima_measure_critical_data(const char *event_data_source,
+				      const char *event_name,
+				      const void *buf, int buf_len,
+				      bool measure_buf_hash);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -116,6 +120,10 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 }
 
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
+static inline void ima_measure_critical_data(const char *event_data_source,
+					     const char *event_name,
+					     const void *buf, int buf_len,
+					     bool measure_buf_hash) {}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 0f77e0b697a3..c1acf88e1b5d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -200,6 +200,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
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
index 4485d87c0aa5..6e1b11dcba53 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -921,6 +921,44 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	fdput(f);
 }
 
+/**
+ * ima_measure_critical_data - measure kernel subsystem data
+ * critical to integrity of the kernel
+ * @event_data_source: name of the data source being measured;
+ * typically it should be the name of the kernel subsystem that is sending
+ * the data for measurement
+ * @event_name: name of an event from the kernel subsystem that is sending
+ * the data for measurement
+ * @buf: pointer to buffer containing data to measure
+ * @buf_len: length of buffer(in bytes)
+ * @measure_buf_hash: if set to true - will measure hash of the buf,
+ *                    instead of buf
+ *
+ * A given kernel subsystem (event_data_source) may send
+ * data (buf) to be measured when the data or the subsystem state changes.
+ * The state/data change can be described by event_name.
+ * Examples of critical data (buf) could be kernel in-memory r/o structures,
+ * hash of the memory structures, or data that represents subsystem
+ * state change.
+ * measure_buf_hash can be used to save space, if the data being measured
+ * is too large.
+ * The data (buf) can only be measured, not appraised.
+ */
+void ima_measure_critical_data(const char *event_data_source,
+			       const char *event_name,
+			       const void *buf, int buf_len,
+			       bool measure_buf_hash)
+{
+	if (!event_name || !event_data_source || !buf || !buf_len) {
+		pr_err("Invalid arguments passed to %s().\n", __func__);
+		return;
+	}
+
+	process_buffer_measurement(NULL, buf, buf_len, event_name,
+				   CRITICAL_DATA, 0, event_data_source,
+				   measure_buf_hash);
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 4edc9be62048..f48e82450fe1 100644
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

