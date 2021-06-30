Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83903B84E7
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbhF3OT0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 10:19:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3335 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbhF3OTX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 10:19:23 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GFNS327nkz6K9Fv;
        Wed, 30 Jun 2021 22:06:27 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:16:51 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>
CC:     <stephen.smalley.work@gmail.com>, <prsriva02@gmail.com>,
        <tusharsu@linux.microsoft.com>, <nramas@linux.microsoft.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 3/3] ima: Add digest parameter to the functions to measure a buffer
Date:   Wed, 30 Jun 2021 16:16:35 +0200
Message-ID: <20210630141635.2862222-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210630141635.2862222-1-roberto.sassu@huawei.com>
References: <20210630141635.2862222-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch adds the 'digest' parameter to ima_measure_critical_data() and
process_buffer_measurement(), so that callers can get the digest of the
passed buffer.

These functions calculate the digest even if there is no suitable rule in
the IMA policy and, in this case, they simply return 1 before generating a
new measurement entry.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/ima.h                          |  4 +--
 security/integrity/ima/ima.h                 |  2 +-
 security/integrity/ima/ima_appraise.c        |  2 +-
 security/integrity/ima/ima_asymmetric_keys.c |  2 +-
 security/integrity/ima/ima_init.c            |  2 +-
 security/integrity/ima/ima_main.c            | 31 +++++++++++++-------
 security/integrity/ima/ima_queue_keys.c      |  2 +-
 security/selinux/ima.c                       |  4 +--
 8 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 60492263aa64..7a1a1f97b4ea 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -38,7 +38,7 @@ extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
 extern int ima_measure_critical_data(const char *event_label,
 				     const char *event_name,
 				     const void *buf, size_t buf_len,
-				     bool hash);
+				     bool hash, u8 *digest);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
@@ -147,7 +147,7 @@ static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {
 static inline int ima_measure_critical_data(const char *event_label,
 					     const char *event_name,
 					     const void *buf, size_t buf_len,
-					     bool hash)
+					     bool hash, u8 *digest)
 {
 	return -ENOENT;
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 03db221324c3..ec803bafa6cc 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -268,7 +268,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
 			       int pcr, const char *func_data,
-			       bool buf_hash);
+			       bool buf_hash, u8 *digest);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 275a2377743f..05f3b1186a41 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -359,7 +359,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 			process_rc = process_buffer_measurement(&init_user_ns,
 						   NULL, digest, digestsize,
 						   "blacklisted-hash", NONE,
-						   pcr, NULL, false);
+						   pcr, NULL, false, NULL);
 	}
 
 	return rc;
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 910367cdd920..a0f7e2dbb9db 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -64,5 +64,5 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	ret = process_buffer_measurement(&init_user_ns, NULL,
 				   payload, payload_len,
 				   keyring->description, KEY_CHECK, 0,
-				   keyring->description, false);
+				   keyring->description, false, NULL);
 }
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 6790eea88db8..0dd22e7752f5 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -156,7 +156,7 @@ int __init ima_init(void)
 
 	measure_rc = ima_measure_critical_data("kernel_info", "kernel_version",
 					       UTS_RELEASE, strlen(UTS_RELEASE),
-					       false);
+					       false, NULL);
 
 	return rc;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 45e048899b2f..a222e7f7b537 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -838,17 +838,19 @@ int ima_post_load_data(char *buf, loff_t size,
  * @pcr: pcr to extend the measurement
  * @func_data: func specific data, may be NULL
  * @buf_hash: measure buffer data hash
+ * @digest: buffer digest will be written to
  *
  * Based on policy, either the buffer data or buffer data hash is measured
  *
- * Returns 0 if the buffer has been successfully measured, a negative value
- * otherwise.
+ * Returns 0 if the buffer has been successfully measured, 1 if the digest
+ * has been written to the passed location but not added to a measurement entry,
+ * a negative value otherwise.
  */
 int process_buffer_measurement(struct user_namespace *mnt_userns,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
 			       int pcr, const char *func_data,
-			       bool buf_hash)
+			       bool buf_hash, u8 *digest)
 {
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
@@ -869,7 +871,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 	int action = 0;
 	u32 secid;
 
-	if (!ima_policy_flag)
+	if (!ima_policy_flag && !digest)
 		return -ENOENT;
 
 	template = ima_template_desc_buf();
@@ -891,7 +893,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 		action = ima_get_action(mnt_userns, inode, current_cred(),
 					secid, 0, func, &pcr, &template,
 					func_data);
-		if (!(action & IMA_MEASURE))
+		if (!(action & IMA_MEASURE) && !digest)
 			return -ENOENT;
 	}
 
@@ -922,6 +924,13 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 		event_data.buf_len = digest_hash_len;
 	}
 
+	if (digest)
+		memcpy(digest, iint.ima_hash->digest,
+		       hash_digest_size[ima_hash_algo]);
+
+	if (!ima_policy_flag || (func && !(action & IMA_MEASURE)))
+		return 1;
+
 	ret = ima_alloc_init_template(&event_data, &entry, template);
 	if (ret < 0) {
 		audit_cause = "alloc_entry";
@@ -966,7 +975,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	ret = process_buffer_measurement(file_mnt_user_ns(f.file),
 					 file_inode(f.file), buf, size,
 					 "kexec-cmdline", KEXEC_CMDLINE, 0,
-					 NULL, false);
+					 NULL, false, NULL);
 	fdput(f);
 }
 
@@ -977,26 +986,28 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
  * @buf: pointer to buffer data
  * @buf_len: length of buffer data (in bytes)
  * @hash: measure buffer data hash
+ * @digest: buffer digest will be written to
  *
  * Measure data critical to the integrity of the kernel into the IMA log
  * and extend the pcr.  Examples of critical data could be various data
  * structures, policies, and states stored in kernel memory that can
  * impact the integrity of the system.
  *
- * Returns 0 if the buffer has been successfully measured, a negative value
- * otherwise.
+ * Returns 0 if the buffer has been successfully measured, 1 if the digest
+ * has been written to the passed location but not added to a measurement entry,
+ * a negative value otherwise.
  */
 int ima_measure_critical_data(const char *event_label,
 			      const char *event_name,
 			      const void *buf, size_t buf_len,
-			      bool hash)
+			      bool hash, u8 *digest)
 {
 	if (!event_name || !event_label || !buf || !buf_len)
 		return -ENOPARAM;
 
 	return process_buffer_measurement(&init_user_ns, NULL, buf, buf_len,
 					  event_name, CRITICAL_DATA, 0,
-					  event_label, hash);
+					  event_label, hash, digest);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index e3047ce64f39..ac00a4778a91 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -166,7 +166,7 @@ void ima_process_queued_keys(void)
 							 entry->keyring_name,
 							 KEY_CHECK, 0,
 							 entry->keyring_name,
-							 false);
+							 false, NULL);
 		list_del(&entry->list);
 		ima_free_key_entry(entry);
 	}
diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index 4db9fa211638..96bd7ead8081 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -88,7 +88,7 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
 
 	measure_rc = ima_measure_critical_data("selinux", "selinux-state",
 					       state_str, strlen(state_str),
-					       false);
+					       false, NULL);
 
 	kfree(state_str);
 
@@ -105,7 +105,7 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
 	}
 
 	measure_rc = ima_measure_critical_data("selinux", "selinux-policy-hash",
-					       policy, policy_len, true);
+					       policy, policy_len, true, NULL);
 
 	vfree(policy);
 }
-- 
2.25.1

