Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D515623C2BA
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 02:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHEAnt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 20:43:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38378 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgHEAnh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 20:43:37 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3F4BF20B490D;
        Tue,  4 Aug 2020 17:43:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F4BF20B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596588216;
        bh=rlps7OqHhVGVD16ISs6BovnL28JviBxRVRibNHIIlhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkoWPIfviFKFKawhpIfi3Z0VTFwBIeRTLMjgHwOPbQOk9cGhVQbZVV50rddIvqkTF
         uPPMe/vuKYHv63XDDif27JgryMYYxrW/z1rPqbO3E8Ma4kCh50wTKXYPtfRv0nIlUu
         ZCJwQiGJN8qTBRIBKXUYX2zROhTAUpMPEnXuzEys=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] IMA: Define IMA hooks to measure LSM state and policy
Date:   Tue,  4 Aug 2020 17:43:29 -0700
Message-Id: <20200805004331.20652-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200805004331.20652-1-nramas@linux.microsoft.com>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA subsystem needs to define IMA hooks that the security modules can
call to measure state and policy data.

Define two new IMA hooks, namely ima_lsm_state() and ima_lsm_policy(),
that the security modules can call to measure LSM state and LSM policy
respectively. Return the status of the measurement operation from these
two IMA hooks.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 include/linux/ima.h               | 14 +++++++++
 security/integrity/ima/ima.h      |  6 ++--
 security/integrity/ima/ima_main.c | 50 ++++++++++++++++++++++++++-----
 3 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index d15100de6cdd..442ca0dce3c8 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -26,6 +26,10 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
+extern int ima_measure_lsm_state(const char *lsm_event_name, const void *buf,
+				 int size);
+extern int ima_measure_lsm_policy(const char *lsm_event_name, const void *buf,
+				  int size);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -104,6 +108,16 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 }
 
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
+static inline int ima_measure_lsm_state(const char *lsm_event_name,
+					const void *buf, int size)
+{
+	return -EOPNOTSUPP;
+}
+static inline int ima_measure_lsm_policy(const char *lsm_event_name,
+					 const void *buf, int size)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 1b5f4b2f17d0..8ed9f5e1dd40 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -267,9 +267,9 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
 			   struct ima_template_desc *template_desc);
-void process_buffer_measurement(struct inode *inode, const void *buf, int size,
-				const char *eventname, enum ima_hooks func,
-				int pcr, const char *keyring);
+int process_buffer_measurement(struct inode *inode, const void *buf, int size,
+			       const char *eventname, enum ima_hooks func,
+			       int pcr, const char *keyring);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8a91711ca79b..74d421e40c8f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -736,9 +736,9 @@ int ima_load_data(enum kernel_load_data_id id)
  *
  * Based on policy, the buffer is measured into the ima log.
  */
-void process_buffer_measurement(struct inode *inode, const void *buf, int size,
-				const char *eventname, enum ima_hooks func,
-				int pcr, const char *keyring)
+int process_buffer_measurement(struct inode *inode, const void *buf, int size,
+			       const char *eventname, enum ima_hooks func,
+			       int pcr, const char *keyring)
 {
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
@@ -758,7 +758,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	u32 secid;
 
 	if (!ima_policy_flag)
-		return;
+		return 0;
 
 	/*
 	 * Both LSM hooks and auxilary based buffer measurements are
@@ -772,7 +772,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 		action = ima_get_action(inode, current_cred(), secid, 0, func,
 					&pcr, &template, keyring);
 		if (!(action & IMA_MEASURE))
-			return;
+			return 0;
 	}
 
 	if (!pcr)
@@ -787,7 +787,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 			pr_err("template %s init failed, result: %d\n",
 			       (strlen(template->name) ?
 				template->name : template->fmt), ret);
-			return;
+			return ret;
 		}
 	}
 
@@ -819,7 +819,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 					func_measure_str(func),
 					audit_cause, ret, 0, ret);
 
-	return;
+	return ret;
 }
 
 /**
@@ -846,6 +846,42 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	fdput(f);
 }
 
+/**
+ * ima_measure_lsm_state - measure LSM specific state
+ * @lsm_event_name: LSM event
+ * @buf: pointer to buffer containing LSM specific state
+ * @size: Number of bytes in buf
+ *
+ * Buffers can only be measured, not appraised.
+ */
+int ima_measure_lsm_state(const char *lsm_event_name, const void *buf,
+			  int size)
+{
+	if (!lsm_event_name || !buf || !size)
+		return -EINVAL;
+
+	return process_buffer_measurement(NULL, buf, size, lsm_event_name,
+					  LSM_STATE, 0, NULL);
+}
+
+/**
+ * ima_measure_lsm_policy - measure LSM specific policy
+ * @lsm_event_name: LSM event
+ * @buf: pointer to buffer containing LSM specific policy
+ * @size: Number of bytes in buf
+ *
+ * Buffers can only be measured, not appraised.
+ */
+int ima_measure_lsm_policy(const char *lsm_event_name, const void *buf,
+			   int size)
+{
+	if (!lsm_event_name || !buf || !size)
+		return -EINVAL;
+
+	return process_buffer_measurement(NULL, buf, size, lsm_event_name,
+					  LSM_POLICY, 0, NULL);
+}
+
 static int __init init_ima(void)
 {
 	int error;
-- 
2.27.0

