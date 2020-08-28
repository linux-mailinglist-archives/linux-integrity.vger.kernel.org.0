Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDFE2552CA
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 03:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgH1B5Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 21:57:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38488 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgH1B5V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 21:57:21 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id BF96F20C27C2;
        Thu, 27 Aug 2020 18:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF96F20C27C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598579840;
        bh=nzyuBFV9kqZh5RxX8gM1RD80E78BulBKErd8/nU8wOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQ8CgstekmkhlgT3EHBgPitdAENMOLwat19paNBoRTiLk5rVm55zMx1m01d9hTdhI
         iqt1GFyGT8SoNc101UZkyHNbF4+BrMoMQKP356gnOcNe5F0opgu6YbtVb7Vqe/vVPc
         Ikyd8fsnAJGd6hpVVItcvTckgrkzPxvL68YLrMAA=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v3 5/6] IMA: add hook to measure critical data from kernel components
Date:   Thu, 27 Aug 2020 18:57:03 -0700
Message-Id: <20200828015704.6629-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently, IMA does not provide a generic function for kernel components
to measure their data. A generic function provided by IMA would
enable various parts of the kernel with easier and faster on-boarding to
use IMA infrastructure, would avoid code duplication, and consistent
usage of IMA policy "critical_kernel_data_sources" across the kernel.

Add a new IMA func CRITICAL_DATA and a corresponding IMA hook
ima_measure_critical_data() to support measuring various critical kernel
components. Limit the measurement to the components that are specified
in the IMA policy - CRITICAL_DATA+critical_kernel_data_sources.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  8 ++++++-
 include/linux/ima.h                  | 11 +++++++++
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_api.c     |  2 +-
 security/integrity/ima/ima_main.c    | 24 ++++++++++++++++++++
 security/integrity/ima/ima_policy.c  | 34 ++++++++++++++++++++++++----
 6 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 7ccdc1964e29..36d9cee9704d 100644
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
@@ -51,6 +51,8 @@ Description:
 			critical_kernel_data_sources:= list of kernel
 			components (eg, selinux|apparmor|dm-crypt) that
 			contain data critical to the security of the kernel.
+			Only valid when action is "measure" and func is
+			CRITICAL_DATA.
 
 		default policy:
 			# PROC_SUPER_MAGIC
@@ -128,3 +130,7 @@ Description:
 		keys added to .builtin_trusted_keys or .ima keyring:
 
 			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
+
+		Example of measure rule using CRITICAL_DATA to measure critical data
+
+			measure func=CRITICAL_DATA critical_kernel_data_sources=selinux|apparmor|dm-crypt
diff --git a/include/linux/ima.h b/include/linux/ima.h
index d15100de6cdd..136fc02580db 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -26,6 +26,10 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
+extern int ima_measure_critical_data(const char *event_name,
+				     const char *event_data_source,
+				     const void *buf, int buf_len,
+				     bool measure_buf_hash);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -104,6 +108,13 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 }
 
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
+static inline int ima_measure_critical_data(const char *event_name,
+					    const char *event_data_source,
+					    const void *buf, int buf_len,
+					    bool measure_buf_hash)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ba332de8ed0b..00b84052c8f1 100644
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
index 52cbbc1f7ea2..a889bf40cb7e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -869,6 +869,30 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	fdput(f);
 }
 
+/**
+ * ima_measure_critical_data - measure critical data
+ * @event_name: name for the given data
+ * @event_data_source: name of the event data source
+ * @buf: pointer to buffer containing data to measure
+ * @buf_len: length of buffer(in bytes)
+ * @measure_buf_hash: if set to true - will measure hash of the buf,
+ *                    instead of buf
+ *
+ * Buffers can only be measured, not appraised.
+ */
+int ima_measure_critical_data(const char *event_name,
+			      const char *event_data_source,
+			      const void *buf, int buf_len,
+			      bool measure_buf_hash)
+{
+	if (!event_name || !event_data_source || !buf || !buf_len)
+		return -EINVAL;
+
+	return process_buffer_measurement(NULL, buf, buf_len, event_name,
+					  CRITICAL_DATA, 0, event_data_source,
+					  measure_buf_hash);
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c8a044705347..0c5202c1f26e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -510,14 +510,23 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func == KEY_CHECK) {
-		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
-		       ima_match_rule_data(rule, rule->keyrings, func_data,
-					   true, cred);
-	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
 		return false;
+
+	switch (func) {
+	case KEY_CHECK:
+		return ((rule->func == func) &&
+			ima_match_rule_data(rule, rule->keyrings,
+					    func_data, true, cred));
+	case CRITICAL_DATA:
+		return ((rule->func == func) &&
+			ima_match_rule_data(rule, rule->data_sources,
+					    func_data, false, cred));
+	default:
+		break;
+	}
+
 	if ((rule->flags & IMA_MASK) &&
 	    (rule->mask != mask && func != POST_SETATTR))
 		return false;
@@ -1113,6 +1122,19 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (ima_rule_contains_lsm_cond(entry))
 			return false;
 
+		break;
+	case CRITICAL_DATA:
+		if (entry->action & ~(MEASURE | DONT_MEASURE))
+			return false;
+
+		if (!(entry->flags & IMA_DATA_SOURCES) ||
+		    (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
+		    IMA_DATA_SOURCES)))
+			return false;
+
+		if (ima_rule_contains_lsm_cond(entry))
+			return false;
+
 		break;
 	default:
 		return false;
@@ -1245,6 +1267,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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

