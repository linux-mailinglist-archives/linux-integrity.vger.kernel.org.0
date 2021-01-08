Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD152EEC32
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Jan 2021 05:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbhAHEIJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 23:08:09 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59072 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbhAHEIF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 23:08:05 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id CFB7F20B6C42;
        Thu,  7 Jan 2021 20:07:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFB7F20B6C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610078844;
        bh=1//phB4oDC0if4r5cArNbDu6FzSfpsU1LtpB80AJZy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MT5qUHW6JuMDQWHVh54Kmwa+8ugEsRgxcxNKVNMAQ4f891gk2xoe+AJ2/59nL6GdA
         Yph2vWe2F2KsJEpbQ/kI64h2C1C0tmiZXK9jz4+zql5mi8L+Jv7yOUguFJR+PnrNJ9
         oyabG1JSPJL7Yofi8nNi3SlhrCY2Vi/Nwl5g2fw4=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v10 3/8] IMA: define a hook to measure kernel integrity critical data
Date:   Thu,  7 Jan 2021 20:07:03 -0800
Message-Id: <20210108040708.8389-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA provides capabilities to measure file and buffer data.  However,
various data structures, policies, and states stored in kernel memory
also impact the integrity of the system.  Several kernel subsystems
contain such integrity critical data.  These kernel subsystems help
protect the integrity of the system.  Currently, IMA does not provide a
generic function for measuring kernel integrity critical data.
 
Define ima_measure_critical_data, a new IMA hook, to measure kernel
integrity critical data.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 include/linux/ima.h               |  7 +++++++
 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_api.c  |  2 +-
 security/integrity/ima/ima_main.c | 24 ++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index ac3d82f962f2..37a0727c1c31 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,6 +30,9 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
+extern void ima_measure_critical_data(const char *event_name,
+				      const void *buf, size_t buf_len,
+				      bool hash);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
@@ -122,6 +125,10 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 }
 
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
+
+static inline void ima_measure_critical_data(const char *event_name,
+					     const void *buf, size_t buf_len,
+					     bool hash) {}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 0b4634515839..aa312472c7c5 100644
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
index e76499b1ce78..1dd70dc68ffd 100644
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
index 494fb964497d..ef37307e79dd 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -913,6 +913,30 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	fdput(f);
 }
 
+/**
+ * ima_measure_critical_data - measure kernel integrity critical data
+ * @event_name: event name for the record in the IMA measurement list
+ * @buf: pointer to buffer data
+ * @buf_len: length of buffer data (in bytes)
+ * @hash: measure buffer data hash
+ *
+ * Measure data critical to the integrity of the kernel into the IMA log
+ * and extend the pcr.  Examples of critical data could be various data
+ * structures, policies, and states stored in kernel memory that can
+ * impact the integrity of the system.
+ */
+void ima_measure_critical_data(const char *event_name,
+			       const void *buf, size_t buf_len,
+			       bool hash)
+{
+	if (!event_name || !buf || !buf_len)
+		return;
+
+	process_buffer_measurement(NULL, buf, buf_len, event_name,
+				   CRITICAL_DATA, 0, NULL,
+				   hash);
+}
+
 static int __init init_ima(void)
 {
 	int error;
-- 
2.17.1

