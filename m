Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A66C3BB9EE
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 11:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhGEJMf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 05:12:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3359 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhGEJMd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 05:12:33 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GJKPG66SHz6M4Gx;
        Mon,  5 Jul 2021 16:59:14 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 11:09:54 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>
CC:     <stephen.smalley.work@gmail.com>, <prsriva02@gmail.com>,
        <tusharsu@linux.microsoft.com>, <nramas@linux.microsoft.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 3/3] ima: Add digest and digest_len params to the functions to measure a buffer
Date:   Mon, 5 Jul 2021 11:09:22 +0200
Message-ID: <20210705090922.3321178-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210705090922.3321178-1-roberto.sassu@huawei.com>
References: <20210705090922.3321178-1-roberto.sassu@huawei.com>
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

This patch adds the 'digest' and 'digest_len' parameters to
ima_measure_critical_data() and process_buffer_measurement(), so that
callers can get the digest of the passed buffer.

These functions calculate the digest even if there is no suitable rule in
the IMA policy and, in this case, they simply return 1 before generating a
new measurement entry.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/ima.h                          |  5 +--
 security/integrity/ima/ima.h                 |  2 +-
 security/integrity/ima/ima_appraise.c        |  2 +-
 security/integrity/ima/ima_asymmetric_keys.c |  2 +-
 security/integrity/ima/ima_init.c            |  3 +-
 security/integrity/ima/ima_main.c            | 36 ++++++++++++++------
 security/integrity/ima/ima_queue_keys.c      |  2 +-
 security/selinux/ima.c                       |  6 ++--
 8 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 60492263aa64..b6ab66a546ae 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -38,7 +38,7 @@ extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
 extern int ima_measure_critical_data(const char *event_label,
 				     const char *event_name,
 				     const void *buf, size_t buf_len,
-				     bool hash);
+				     bool hash, u8 *digest, size_t digest_len);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
@@ -147,7 +147,8 @@ static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {
 static inline int ima_measure_critical_data(const char *event_label,
 					     const char *event_name,
 					     const void *buf, size_t buf_len,
-					     bool hash)
+					     bool hash, u8 *digest,
+					     size_t digest_len)
 {
 	return -ENOENT;
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 03db221324c3..2f4c20b16ad7 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -268,7 +268,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
 			       int pcr, const char *func_data,
-			       bool buf_hash);
+			       bool buf_hash, u8 *digest, size_t digest_len);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ef9dcfce45d4..63bec42c353f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -357,7 +357,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
 			process_buffer_measurement(&init_user_ns, NULL, digest, digestsize,
 						   "blacklisted-hash", NONE,
-						   pcr, NULL, false);
+						   pcr, NULL, false, NULL, 0);
 	}
 
 	return rc;
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index c985418698a4..f6aa0b47a772 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -62,5 +62,5 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 */
 	process_buffer_measurement(&init_user_ns, NULL, payload, payload_len,
 				   keyring->description, KEY_CHECK, 0,
-				   keyring->description, false);
+				   keyring->description, false, NULL, 0);
 }
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5076a7d9d23e..b26fa67476b4 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -154,7 +154,8 @@ int __init ima_init(void)
 	ima_init_key_queue();
 
 	ima_measure_critical_data("kernel_info", "kernel_version",
-				  UTS_RELEASE, strlen(UTS_RELEASE), false);
+				  UTS_RELEASE, strlen(UTS_RELEASE), false,
+				  NULL, 0);
 
 	return rc;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index b512c06d8ee1..360266da5a10 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -838,17 +838,20 @@ int ima_post_load_data(char *buf, loff_t size,
  * @pcr: pcr to extend the measurement
  * @func_data: func specific data, may be NULL
  * @buf_hash: measure buffer data hash
+ * @digest: buffer digest will be written to
+ * @digest_len: buffer length
  *
  * Based on policy, either the buffer data or buffer data hash is measured
  *
- * Return: 0 if the buffer has been successfully measured, a negative value
- * otherwise.
+ * Return: 0 if the buffer has been successfully measured, 1 if the digest
+ * has been written to the passed location but not added to a measurement entry,
+ * a negative value otherwise.
  */
 int process_buffer_measurement(struct user_namespace *mnt_userns,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
 			       int pcr, const char *func_data,
-			       bool buf_hash)
+			       bool buf_hash, u8 *digest, size_t digest_len)
 {
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
@@ -869,7 +872,10 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 	int action = 0;
 	u32 secid;
 
-	if (!ima_policy_flag)
+	if (digest && digest_len < digest_hash_len)
+		return -EINVAL;
+
+	if (!ima_policy_flag && !digest)
 		return -ENOENT;
 
 	template = ima_template_desc_buf();
@@ -891,7 +897,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 		action = ima_get_action(mnt_userns, inode, current_cred(),
 					secid, 0, func, &pcr, &template,
 					func_data);
-		if (!(action & IMA_MEASURE))
+		if (!(action & IMA_MEASURE) && !digest)
 			return -ENOENT;
 	}
 
@@ -922,6 +928,12 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 		event_data.buf_len = digest_hash_len;
 	}
 
+	if (digest)
+		memcpy(digest, iint.ima_hash->digest, digest_hash_len);
+
+	if (!ima_policy_flag || (func && !(action & IMA_MEASURE)))
+		return 1;
+
 	ret = ima_alloc_init_template(&event_data, &entry, template);
 	if (ret < 0) {
 		audit_cause = "alloc_entry";
@@ -964,7 +976,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 
 	process_buffer_measurement(file_mnt_user_ns(f.file), file_inode(f.file),
 				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
-				   NULL, false);
+				   NULL, false, NULL, 0);
 	fdput(f);
 }
 
@@ -975,26 +987,30 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
  * @buf: pointer to buffer data
  * @buf_len: length of buffer data (in bytes)
  * @hash: measure buffer data hash
+ * @digest: buffer digest will be written to
+ * @digest_len: buffer length
  *
  * Measure data critical to the integrity of the kernel into the IMA log
  * and extend the pcr.  Examples of critical data could be various data
  * structures, policies, and states stored in kernel memory that can
  * impact the integrity of the system.
  *
- * Return: 0 if the buffer has been successfully measured, a negative value
- * otherwise.
+ * Return: 0 if the buffer has been successfully measured, 1 if the digest
+ * has been written to the passed location but not added to a measurement entry,
+ * a negative value otherwise.
  */
 int ima_measure_critical_data(const char *event_label,
 			      const char *event_name,
 			      const void *buf, size_t buf_len,
-			      bool hash)
+			      bool hash, u8 *digest, size_t digest_len)
 {
 	if (!event_name || !event_label || !buf || !buf_len)
 		return -ENOPARAM;
 
 	return process_buffer_measurement(&init_user_ns, NULL, buf, buf_len,
 					  event_name, CRITICAL_DATA, 0,
-					  event_label, hash);
+					  event_label, hash, digest,
+					  digest_len);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index 979ef6c71f3d..93056c03bf5a 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -165,7 +165,7 @@ void ima_process_queued_keys(void)
 						   entry->keyring_name,
 						   KEY_CHECK, 0,
 						   entry->keyring_name,
-						   false);
+						   false, NULL, 0);
 		list_del(&entry->list);
 		ima_free_key_entry(entry);
 	}
diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index 34d421861bfc..727c4e43219d 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -86,7 +86,8 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
 	}
 
 	ima_measure_critical_data("selinux", "selinux-state",
-				  state_str, strlen(state_str), false);
+				  state_str, strlen(state_str), false,
+				  NULL, 0);
 
 	kfree(state_str);
 
@@ -103,7 +104,8 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
 	}
 
 	ima_measure_critical_data("selinux", "selinux-policy-hash",
-				  policy, policy_len, true);
+				  policy, policy_len, true,
+				  NULL, 0);
 
 	vfree(policy);
 }
-- 
2.25.1

