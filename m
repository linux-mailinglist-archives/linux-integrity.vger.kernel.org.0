Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F022CFD6
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 22:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGXUqF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 16:46:05 -0400
Received: from sonic311-22.consmr.mail.bf2.yahoo.com ([74.6.131.196]:40930
        "EHLO sonic311-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbgGXUqC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 16:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595623559; bh=b7wuN8afpWNgMv8kzGzPK3VJGEaAT6lmwVX6V51b30s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qNjim3EOaIyIfvQxNtQ99BQYYa2NKH9gS3iS4p5TCje19sI/fY44wVO+AFN2Ztnuk6s/1Umkaua6bE6TXY2Qc47x6ezKbC7fGBBbMSk32dxw0golqk+LIThnTxwzxzb+w5E7/L9pRnmE1XVnWjLIswXRK0ICdoehHNml6wop4IcrR3vB7cCZZEC1Aioq8adIuP/tyQ5gIEU7BDZ2wjmbXCbh5KEAjDKPgXWa+Dg8AxPCOauXeUE5AVPm7+Pg5u5d0vQ18Qt4DWjVfDb6lE+UgCEPJr74EFYNi2CgEoUYjAux6/lr7Bjtt8RyR+rewlRyl0uDVg++JY2njibv7TI2sg==
X-YMail-OSG: 5a6jXtIVM1n2.ErlHez_NHwoGr10NjqnTD3fF5tqv2nqAqGfHsaKqt_egRsBQ.j
 M7UB1lpcAch9boOR.83bRBzxTMMj7LdwbGFjhUwea7hclvinfDdHDLoqX8iwCrBddsmw.adyr6WJ
 ZweAnMeSmrWsqxh2CR4So4xEvmL0Y49HzOXAHen7YmkKvglnmX6_VTgr1JbjtcQTzEuTiO5deZUu
 jHMmiAyaunpUM0IFTmEkkKUfp.QfOdjm5uWE.AZ4e_mcSXMSIgF8Bm0wNnQqDRxRjdt1dBv2Cs5E
 Kerf19zO2qGhE7O3qghOHr0jhwREKWne7x1mUaYjlbxHJTEcuZHqqm1NuF4_wsBUY9fV6Evr.2jc
 50WljIc3SpsCrRYrlNzqsfnqKHrye3E.AUdjBDc.7ETvqfq8oUPHtQvKi0HO0xSr_JgiDFfsQ0.0
 CopXfZWcd.gZ3sjvteiPNv.UTXpaP_wdWWWZcQKiySxKLxSO9dxgLOeJvf0GWDRDYY00SH9pMVsT
 hTpyL_h0bDLhOR4nTYM5LhapeOlUYEb09k_mZovrsjvDsUBR.ZLOxrzV1V9mrQJc9ajkOcYAs8tn
 dAtZHXfgwgvPxDkqdGE9KxEHa7xm0shoI1hYeHpfW4ff4yQJiuNHChszteoyGJU7QHpTjCPUOZtn
 53d1ninvCzAkVl3BLHpGrKowNiMsEvgoH3mhdx1Ll7iXvRT96CCJjk4egQaZy.ht3ZokCgCYcUxJ
 rKS.HcUv8kzpsUlom7tfTUXlDecQuRob8sFpIabkUsNs6SAT1A_b6LkGSYapqVTsA2KQ4Psr9EYC
 7QWvQsd6osMmYV__8pBMtCfNfiwxYQsdvJYpd6YUxzqrtqrQEgKbVzwZW0bJ9e6GhvxrXRHDUj5V
 LfoQ.sUcobpqDayzeo1DrQV5yFKsQoGN56E2cRlbCNCGYRsbfNY90uJ3PW573wMYdC.XLxL1f5ot
 l2AFaM.mB3BL0fQSw2C1p2NR97FS2xF.cZfp3a48WPxOC8MzIn2n.zXQD9WxjeJ69th6OaubyxgQ
 GBs8kCbmziOrWFg0MICJjNWC3TfJCwmPBqzeYd39ynWWRhaLjwFckVujRnjgXY_YlrOQmGamT69f
 3SmlPZpVJEH78j1C8glg5SdSnSbJFvpmlyP9z0R2oKa5Fppn8qieL7KmKPHpouD041hxMDCzfU.F
 Kr_9ekjVuc2Y1dTeJn2E__bh9NcGSESWECOhy78zjnKEpDYdtT3dKBFs_1F_41cefmrqEE0OFXfS
 yxwW1uTiDMsOsji2.Q3Ct8PMlV67CNy4dWOw8HPJf9DVYCOBMkE3.y7VQ9zirCBcDSs_qM6o10FP
 YpcerRH3qvngZRV7c1_3wPITh3dzXGF1sinltKVRRWyHFQ1DeZsaeoLek0PoAQQC2Wa6IKlPHz8e
 N5X_Bm_1QJ25WQK8pwg40mCKNC8MKBDXwtQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 Jul 2020 20:45:59 +0000
Received: by smtp429.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID cac514323d65cabcf7715e3da7c14d39;
          Fri, 24 Jul 2020 20:45:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-integrity@vger.kernel.org
Subject: [PATCH v19 12/23] IMA: Change internal interfaces to use lsmblobs
Date:   Fri, 24 Jul 2020 13:32:15 -0700
Message-Id: <20200724203226.16374-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200724203226.16374-1-casey@schaufler-ca.com>
References: <20200724203226.16374-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA interfaces ima_get_action() and ima_match_policy()
call LSM functions that use lsmblobs. Change the IMA functions
to pass the lsmblob to be compatible with the LSM functions.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-integrity@vger.kernel.org
---
 security/integrity/ima/ima.h          | 11 +++++----
 security/integrity/ima/ima_api.c      | 10 ++++----
 security/integrity/ima/ima_appraise.c |  6 ++---
 security/integrity/ima/ima_main.c     | 35 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 14 +++++------
 5 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d72af93f8d6f..0c4787c71162 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -236,9 +236,9 @@ static inline void ima_process_queued_keys(void) {}
 #endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS */
 
 /* LIM API function definitions */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc,
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *blob, int mask, enum ima_hooks func,
+		   int *pcr, struct ima_template_desc **template_desc,
 		   const char *keyring);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
@@ -264,8 +264,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
+int ima_match_policy(struct inode *inode, const struct cred *cred,
+		     struct lsmblob *blob, enum ima_hooks func, int mask,
+		     int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *keyring);
 void ima_init_policy(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index bf22de8b7ce0..ea78825e0033 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -164,7 +164,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * ima_get_action - appraise & measure decision based on policy.
  * @inode: pointer to inode to measure
  * @cred: pointer to credentials structure to validate
- * @secid: secid of the task being validated
+ * @blob: LSM data of the task being validated
  * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
  *        MAY_APPEND)
  * @func: caller identifier
@@ -183,16 +183,16 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * Returns IMA_MEASURE, IMA_APPRAISE mask.
  *
  */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc,
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *blob, int mask, enum ima_hooks func,
+		   int *pcr, struct ima_template_desc **template_desc,
 		   const char *keyring)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
+	return ima_match_policy(inode, cred, blob, func, mask, flags, pcr,
 				template_desc, keyring);
 }
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3dfb573c7171..bf66e3e6f398 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -54,10 +54,8 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 		return 0;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding the .secid[0] */
-	return ima_match_policy(inode, current_cred(), blob.secid[0], func,
-				mask, IMA_APPRAISE | IMA_HASH, NULL, NULL,
-				NULL);
+	return ima_match_policy(inode, current_cred(), &blob, func, mask,
+				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e70d8626208c..5093f9b4db8b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -188,8 +188,8 @@ void ima_file_free(struct file *file)
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       struct lsmblob *blob, char *buf, loff_t size,
+			       int mask, enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -212,7 +212,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
+	action = ima_get_action(inode, cred, blob, mask, func, &pcr,
 				&template_desc, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -386,8 +386,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding - until process_measurement changes */
-		return process_measurement(file, current_cred(), blob.secid[0],
+		return process_measurement(file, current_cred(), &blob,
 					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
@@ -426,8 +425,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 
 	security_task_getsecid(current, &blob);
 	inode = file_inode(vma->vm_file);
-	/* scaffolding */
-	action = ima_get_action(NULL, current_cred(), blob.secid[0], 0,
+	action = ima_get_action(NULL, current_cred(), &blob, 0,
 				MMAP_CHECK, &pcr, &template, 0);
 
 	/* Is the mmap'ed file in policy? */
@@ -466,16 +464,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	ret = process_measurement(bprm->file, current_cred(), blob.secid[0],
-				  NULL, 0, MAY_EXEC, BPRM_CHECK);
+	ret = process_measurement(bprm->file, current_cred(), &blob, NULL, 0,
+				  MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(bprm->file, bprm->cred, blob.secid[0],
-				   NULL, 0, MAY_EXEC, CREDS_CHECK);
+	return process_measurement(bprm->file, bprm->cred, &blob, NULL, 0,
+				   MAY_EXEC, CREDS_CHECK);
 }
 
 /**
@@ -493,8 +489,7 @@ int ima_file_check(struct file *file, int mask)
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -675,9 +670,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
@@ -773,9 +767,8 @@ void process_buffer_measurement(const void *buf, int size,
 	 */
 	if (func) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding */
-		action = ima_get_action(NULL, current_cred(), blob.secid[0], 0,
-					func, &pcr, &template, keyring);
+		action = ima_get_action(NULL, current_cred(), &blob, 0, func,
+					&pcr, &template, keyring);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8f9c66a0a612..6a8f347001fd 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -422,7 +422,7 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * @rule: a pointer to a rule
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
- * @secid: the secid of the task to be validated
+ * @blob: the lsm data of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @keyring: keyring name to check in policy for KEY_CHECK func
@@ -430,7 +430,7 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
-			    const struct cred *cred, u32 secid,
+			    const struct cred *cred, struct lsmblob *blob,
 			    enum ima_hooks func, int mask,
 			    const char *keyring)
 {
@@ -500,7 +500,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&lsmdata, secid);
 			rc = security_filter_rule_match(&lsmdata,
 							rule->lsm[i].type,
 							Audit_equal,
@@ -544,7 +543,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -559,8 +558,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * list when walking it.  Reads are many orders of magnitude more numerous
  * than writes so ima_match_policy() is classical RCU candidate.
  */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
+int ima_match_policy(struct inode *inode, const struct cred *cred,
+		     struct lsmblob *blob, enum ima_hooks func, int mask,
+		     int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *keyring)
 {
@@ -576,7 +576,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask,
+		if (!ima_match_rules(entry, inode, cred, blob, func, mask,
 				     keyring))
 			continue;
 
-- 
2.24.1

