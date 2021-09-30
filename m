Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A78A41D926
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 13:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350592AbhI3L5a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 07:57:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3895 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350549AbhI3L53 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 07:57:29 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HKs7R6v0Bz67Yp1;
        Thu, 30 Sep 2021 19:52:51 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 13:55:45 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 1/7] integrity: Change type of IMA rule-related flags to u64
Date:   Thu, 30 Sep 2021 13:55:27 +0200
Message-ID: <20210930115533.878169-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210930115533.878169-1-roberto.sassu@huawei.com>
References: <20210930115533.878169-1-roberto.sassu@huawei.com>
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

Change the type of the flags member of integrity_iint_cache and
ima_rule_entry, and the type of return value of ima_match_policy() and
ima_get_action() to u64 to make room for more flags.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h        |  4 +-
 security/integrity/ima/ima_api.c    |  2 +-
 security/integrity/ima/ima_main.c   |  3 +-
 security/integrity/ima/ima_policy.c |  6 +--
 security/integrity/integrity.h      | 60 ++++++++++++++---------------
 5 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d01ca3566aec..cde2e1c2a6be 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -255,7 +255,7 @@ static inline void ima_process_queued_keys(void) {}
 #endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS */
 
 /* LIM API function definitions */
-int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
+u64 ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
@@ -286,7 +286,7 @@ void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
-int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
+u64 ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 2c6c3a5228b5..bd9316d89243 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -185,7 +185,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * Returns IMA_MEASURE, IMA_APPRAISE mask.
  *
  */
-int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
+u64 ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d33765c7aaa7..fe1f4ef1bb9d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -208,7 +208,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
 	const char *pathname = NULL;
-	int rc = 0, action, must_appraise = 0;
+	u64 action;
+	int rc = 0, must_appraise = 0;
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 	struct evm_ima_xattr_data *xattr_value = NULL;
 	struct modsig *modsig = NULL;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8d6f5d85dfa4..084b5d9257da 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -74,7 +74,7 @@ struct ima_rule_opt_list {
 struct ima_rule_entry {
 	struct list_head list;
 	int action;
-	unsigned int flags;
+	u64 flags;
 	enum ima_hooks func;
 	int mask;
 	unsigned long fsmagic;
@@ -702,14 +702,14 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * list when walking it.  Reads are many orders of magnitude more numerous
  * than writes so ima_match_policy() is classical RCU candidate.
  */
-int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
+u64 ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data, unsigned int *allowed_algos)
 {
 	struct ima_rule_entry *entry;
-	int action = 0, actmask = flags | (flags << 1);
+	u64 action = 0, actmask = flags | (flags << 1);
 	struct list_head *ima_rules_tmp;
 
 	if (template_desc && !*template_desc)
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 2ab85f286d17..cb4a8cd2a213 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -23,27 +23,27 @@
 #include <crypto/hash_info.h>
 
 /* iint action cache flags */
-#define IMA_MEASURE		0x00000001
-#define IMA_MEASURED		0x00000002
-#define IMA_APPRAISE		0x00000004
-#define IMA_APPRAISED		0x00000008
-/*#define IMA_COLLECT		0x00000010  do not use this flag */
-#define IMA_COLLECTED		0x00000020
-#define IMA_AUDIT		0x00000040
-#define IMA_AUDITED		0x00000080
-#define IMA_HASH		0x00000100
-#define IMA_HASHED		0x00000200
+#define IMA_MEASURE		0x0000000000000001
+#define IMA_MEASURED		0x0000000000000002
+#define IMA_APPRAISE		0x0000000000000004
+#define IMA_APPRAISED		0x0000000000000008
+/*#define IMA_COLLECT		0x0000000000000010  do not use this flag */
+#define IMA_COLLECTED		0x0000000000000020
+#define IMA_AUDIT		0x0000000000000040
+#define IMA_AUDITED		0x0000000000000080
+#define IMA_HASH		0x0000000000000100
+#define IMA_HASHED		0x0000000000000200
 
 /* iint cache flags */
-#define IMA_ACTION_FLAGS	0xff000000
-#define IMA_DIGSIG_REQUIRED	0x01000000
-#define IMA_PERMIT_DIRECTIO	0x02000000
-#define IMA_NEW_FILE		0x04000000
-#define EVM_IMMUTABLE_DIGSIG	0x08000000
-#define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
-#define IMA_MODSIG_ALLOWED	0x20000000
-#define IMA_CHECK_BLACKLIST	0x40000000
-#define IMA_META_IMMUTABLE_REQUIRED	0x80000000
+#define IMA_ACTION_FLAGS	0xffffffffff000000
+#define IMA_DIGSIG_REQUIRED	0x0000000001000000
+#define IMA_PERMIT_DIRECTIO	0x0000000002000000
+#define IMA_NEW_FILE		0x0000000004000000
+#define EVM_IMMUTABLE_DIGSIG	0x0000000008000000
+#define IMA_FAIL_UNVERIFIABLE_SIGS	0x0000000010000000
+#define IMA_MODSIG_ALLOWED	0x0000000020000000
+#define IMA_CHECK_BLACKLIST	0x0000000040000000
+#define IMA_META_IMMUTABLE_REQUIRED	0x0000000080000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
@@ -52,16 +52,16 @@
 				 IMA_APPRAISED_SUBMASK)
 
 /* iint subaction appraise cache flags */
-#define IMA_FILE_APPRAISE	0x00001000
-#define IMA_FILE_APPRAISED	0x00002000
-#define IMA_MMAP_APPRAISE	0x00004000
-#define IMA_MMAP_APPRAISED	0x00008000
-#define IMA_BPRM_APPRAISE	0x00010000
-#define IMA_BPRM_APPRAISED	0x00020000
-#define IMA_READ_APPRAISE	0x00040000
-#define IMA_READ_APPRAISED	0x00080000
-#define IMA_CREDS_APPRAISE	0x00100000
-#define IMA_CREDS_APPRAISED	0x00200000
+#define IMA_FILE_APPRAISE	0x0000000000001000
+#define IMA_FILE_APPRAISED	0x0000000000002000
+#define IMA_MMAP_APPRAISE	0x0000000000004000
+#define IMA_MMAP_APPRAISED	0x0000000000008000
+#define IMA_BPRM_APPRAISE	0x0000000000010000
+#define IMA_BPRM_APPRAISED	0x0000000000020000
+#define IMA_READ_APPRAISE	0x0000000000040000
+#define IMA_READ_APPRAISED	0x0000000000080000
+#define IMA_CREDS_APPRAISE	0x0000000000100000
+#define IMA_CREDS_APPRAISED	0x0000000000200000
 #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
 				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE | \
 				 IMA_CREDS_APPRAISE)
@@ -133,7 +133,7 @@ struct integrity_iint_cache {
 	struct mutex mutex;	/* protects: version, flags, digest */
 	struct inode *inode;	/* back pointer to inode in question */
 	u64 version;		/* track inode changes */
-	unsigned long flags;
+	u64 flags;
 	unsigned long measured_pcrs;
 	unsigned long atomic_flags;
 	enum integrity_status ima_file_status:4;
-- 
2.32.0

