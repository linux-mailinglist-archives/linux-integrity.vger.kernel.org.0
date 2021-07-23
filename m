Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050783D3719
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jul 2021 10:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhGWINC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jul 2021 04:13:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3461 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhGWIM7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jul 2021 04:12:59 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWN5C5QKLz6D8Vw;
        Fri, 23 Jul 2021 16:38:39 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 10:53:30 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>
CC:     <stephen.smalley.work@gmail.com>, <prsriva02@gmail.com>,
        <tusharsu@linux.microsoft.com>, <nramas@linux.microsoft.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 2/3] ima: Return int in the functions to measure a buffer
Date:   Fri, 23 Jul 2021 10:53:03 +0200
Message-ID: <20210723085304.1760138-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723085304.1760138-1-roberto.sassu@huawei.com>
References: <20210723085304.1760138-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima_measure_critical_data() and process_buffer_measurement() currently
don't return a result as, unlike appraisal-related functions, the result is
not used by callers to deny an operation. Measurement-related functions
instead rely on the audit subsystem to notify the system administrator when
an error occurs.

However, ima_measure_critical_data() and process_buffer_measurement() are a
special case, as these are the only functions that can return a buffer
measurement (for files, there is ima_file_hash()). In a subsequent patch,
they will be modified to return the calculated digest.

In preparation to return the result of the digest calculation, this patch
modifies the return type from void to int, and returns 0 if the buffer has
been successfully measured, a negative value otherwise.

Given that the result of the measurement is still not necessary, this patch
does not modify the behavior of existing callers by processing the returned
value. For those, the return value is ignored.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Acked-by: Paul Moore <paul@paul-moore.com> (for the SELinux bits)
---
 include/linux/ima.h               | 15 +++++++-----
 security/integrity/ima/ima.h      | 10 ++++----
 security/integrity/ima/ima_main.c | 40 ++++++++++++++++++-------------
 3 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 81e830d01ced..60492263aa64 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -35,10 +35,10 @@ extern void ima_post_path_mknod(struct user_namespace *mnt_userns,
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
-extern void ima_measure_critical_data(const char *event_label,
-				      const char *event_name,
-				      const void *buf, size_t buf_len,
-				      bool hash);
+extern int ima_measure_critical_data(const char *event_label,
+				     const char *event_name,
+				     const void *buf, size_t buf_len,
+				     bool hash);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
@@ -144,10 +144,13 @@ static inline int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size
 
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
 
-static inline void ima_measure_critical_data(const char *event_label,
+static inline int ima_measure_critical_data(const char *event_label,
 					     const char *event_name,
 					     const void *buf, size_t buf_len,
-					     bool hash) {}
+					     bool hash)
+{
+	return -ENOENT;
+}
 
 #endif /* CONFIG_IMA */
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f0e448ed1f9f..03db221324c3 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -264,11 +264,11 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
 			   struct ima_template_desc *template_desc);
-void process_buffer_measurement(struct user_namespace *mnt_userns,
-				struct inode *inode, const void *buf, int size,
-				const char *eventname, enum ima_hooks func,
-				int pcr, const char *func_data,
-				bool buf_hash);
+int process_buffer_measurement(struct user_namespace *mnt_userns,
+			       struct inode *inode, const void *buf, int size,
+			       const char *eventname, enum ima_hooks func,
+			       int pcr, const char *func_data,
+			       bool buf_hash);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8ef1fa357e0c..b512c06d8ee1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -827,7 +827,7 @@ int ima_post_load_data(char *buf, loff_t size,
 	return 0;
 }
 
-/*
+/**
  * process_buffer_measurement - Measure the buffer or the buffer data hash
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
@@ -840,12 +840,15 @@ int ima_post_load_data(char *buf, loff_t size,
  * @buf_hash: measure buffer data hash
  *
  * Based on policy, either the buffer data or buffer data hash is measured
+ *
+ * Return: 0 if the buffer has been successfully measured, a negative value
+ * otherwise.
  */
-void process_buffer_measurement(struct user_namespace *mnt_userns,
-				struct inode *inode, const void *buf, int size,
-				const char *eventname, enum ima_hooks func,
-				int pcr, const char *func_data,
-				bool buf_hash)
+int process_buffer_measurement(struct user_namespace *mnt_userns,
+			       struct inode *inode, const void *buf, int size,
+			       const char *eventname, enum ima_hooks func,
+			       int pcr, const char *func_data,
+			       bool buf_hash)
 {
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
@@ -867,7 +870,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 	u32 secid;
 
 	if (!ima_policy_flag)
-		return;
+		return -ENOENT;
 
 	template = ima_template_desc_buf();
 	if (!template) {
@@ -889,7 +892,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 					secid, 0, func, &pcr, &template,
 					func_data);
 		if (!(action & IMA_MEASURE))
-			return;
+			return -ENOENT;
 	}
 
 	if (!pcr)
@@ -937,7 +940,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 					func_measure_str(func),
 					audit_cause, ret, 0, ret);
 
-	return;
+	return ret;
 }
 
 /**
@@ -977,18 +980,21 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
  * and extend the pcr.  Examples of critical data could be various data
  * structures, policies, and states stored in kernel memory that can
  * impact the integrity of the system.
+ *
+ * Return: 0 if the buffer has been successfully measured, a negative value
+ * otherwise.
  */
-void ima_measure_critical_data(const char *event_label,
-			       const char *event_name,
-			       const void *buf, size_t buf_len,
-			       bool hash)
+int ima_measure_critical_data(const char *event_label,
+			      const char *event_name,
+			      const void *buf, size_t buf_len,
+			      bool hash)
 {
 	if (!event_name || !event_label || !buf || !buf_len)
-		return;
+		return -ENOPARAM;
 
-	process_buffer_measurement(&init_user_ns, NULL, buf, buf_len, event_name,
-				   CRITICAL_DATA, 0, event_label,
-				   hash);
+	return process_buffer_measurement(&init_user_ns, NULL, buf, buf_len,
+					  event_name, CRITICAL_DATA, 0,
+					  event_label, hash);
 }
 
 static int __init init_ima(void)
-- 
2.25.1

