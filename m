Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B294B28C26C
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Oct 2020 22:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgJLUbj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 16:31:39 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:44083
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbgJLUbj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 16:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534697; bh=vVAwaQ/x03aXipfIdVlCB2SBwQLx1UNVfpY6RXv3qZ8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Pc9tYWRAlvME8qtnyltz/AqSPABvz/cDwxKYPw8kwB7IOdu8umCda06deP3zlpPuhpMUIgx/2gpcSG7rOrb9eIn+XwpypWGyjsE1ra2AP3+SlxDyiDOgNkft9+fNEdMJdMBa3fXdwi8PZj+KquPFlpAhDCQkdLWo274JIkyWP3W7GDl532SIl0naUmGlvVNCNJUY2JfkHz7vbtN6+1uBgS55HwFE/6DMABGte3QKscmB5IoajRaFK/5bOULnKxm+zc88h9KCqpvW3R7k/XpiTSTgvn/8FXrrRpkSkBDF/n3WIrjKMzOjt2mzz79RnFS0snIIZzCE5apuj42EhMDFKA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534697; bh=R75PYXL/sAM/xyEKvnQl5fepkY9TJQkter2761hJsaJ=; h=From:To:Subject:Date; b=GhtJdaEjNXpDGmjpdmcfD22nvpVjX8368B02aFepthkFoRLd2N88aGWeJikQTRZ7qMCDZDRVxfmaY9DXz+bilkziYG7vhoblDWgQmW2CCe0PMJ9gOtvFsfjcMau6Vs7XHbLh0PRgx5gWyrufMP8NedfqyNlQuLAVmsg1//P9cfq7B1EKNR53nq5Oqk/J5z9GzGkNO+S/WCKxCeLfb+BdWwkdX0ilnsN3pupXFuO4aGhu1JlrpJssjGrptXkjTYSCq1HbLtLLDn0wRvZFqBipcc3k136r9upFMiGpxhVyXp9+ovTmM1THu0fyzUwAZrGMqBxQta9kuUszS2ZvdoaOYw==
X-YMail-OSG: k.jWv80VM1mf84CacHQDk7W1D0pmZf6RiZlEggr6XCmP.PW8laIEqNGQgIuibLx
 cJ9DKSJDjKcTmS5_rZRcM6AF8YNHjze470.zbcvl7PM_brtQty7Xd1rKVg0gZIWbcDQgcqRF.xiG
 ZlzK41uaW.XkspJpa664WzemOXm4FaAbcpmSLfVbfuRoy4Zkn0QmxgTH9YkS9zz9pKMSi5K6whYC
 ZBB6m4w_RzBW2SIlO9Ncd_15u.Wz0ISSr6kT_vZt327mh_szW2o3l_yW0sKhtbxgYLuiXxcYn32W
 B_5u3ii8w26wewVnUcSz_gfQztoI86Vc440CIxJrow1Lvk06xWtl7zTX5UHCr7EycqrjI.OjQNzN
 RzHZmQDeFvTXSVUV4IXbOVkz7qk2MmGM17mz6xuZiBJ5c.Y.LA9eBM9sZy9pBpbqVVxG7MWQ27MI
 yskEP9CVdgJinFTkIdHPKqNYUKSK6YwDVZPVGiIhRQla3RD6wLP7WqFLnUhtr0gORS1ah.OLYdvr
 aTDWlWtYxlFb0umA1.3w4merDs5bzd0_4GXwmovHyCFK211qLIUnlwWGgK.CuLX4Cha3B1hbUgb7
 UnWrpLvW_8XQ_r8lW9NGzwDq8UhHAbBzy5yu0ySuJFLeGA3gS8tElY4JpP3rn_pfnLU7w.Z3VxgV
 UodDf2j1vPauUGJ0aUBtoDy77431eW7_UJyLblJrwKtfjANT8IUsmKpZv54_AuikwsdpbXcEuAM7
 P.A_ERi3vDZL0.Q7Q2HPA6gdF1CCjWI2Jhzj.7ZTelxsirJUY_NQ3malZonpMcJrh5FPFAUnQJE2
 hy86g7vfPlYUtMGDCzdczKoFU8tIXN7DnoDnKtGoToS32RFJ1TS5LeLv4yTjZh2f2Jusx1WLErxg
 Ijfk0bERDhtWc84vVZcb1uDdM8i.ufs9vACaxwiPfyOUxrreuwYJFDs3NpIHs0Yi0vVRHWLqmlV7
 8zcWdGs54ysjG8t6veJbV6yynsD.s57so50Igk0RdGSClEh_Mb5PiXXDiFAVoFgE5T8SQ8pM82.w
 6tIVz5hIET7rYTL42qb2lbMI7kGXKSuO.zcqVHzZEKR_UJIpR71jYV9sfEBAVVCyii9Zhk9bNRgV
 AgePI5P6aD7B01u.yiBGXvgpZH_6Hb5OtQ6fcA7lWbqpT9DC.3XngCFrvfbFBODhO.c.RUfvhH9R
 Nj7._yD30uEuUI39fOt4zzQbh8AXAhTVTJsu21E26r8G9_OI_K8XRj2z0Nj5OYse0qPuie6WUHkL
 BSxQW9SH7eXKT94tl4jxA0he5GLkEhowcIj4oUvqO2BE23a5wWwShwsPwgmnKwPg5IfRgFl2cReX
 DKWgdqVB_YX0oM2qEbbPv2JTrR1KqYBUFL31rEU_unfx6sTyekKFeVzhs0FG0yGlL34CDYUOXrGA
 Rf7sB3ap2qxtES1zU9Kypef8TNx9H2epBn9LZIKufCZWPRPvsHD8i3qdEE52OO2BKpwSCw_D7pFm
 mn_Nud7i7FTioTIKlLWPPff0UeeZTH7toPjH9Jwe0NPwuQXg2a_BKXuH3cIxpPW7C16YncQt1i5K
 0AvdSvFpAIsz.9XrtAVfqxHhWNVN7ZWNBD3vcOWXnsOwRHAzZXzE70zA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 20:31:37 +0000
Received: by smtp423.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 80af1f7df6ec7b1180c84c54494b7bc1;
          Mon, 12 Oct 2020 20:31:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-integrity@vger.kernel.org
Subject: [PATCH v21 11/23] IMA: Change internal interfaces to use lsmblobs
Date:   Mon, 12 Oct 2020 13:19:12 -0700
Message-Id: <20201012201924.71463-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201012201924.71463-1-casey@schaufler-ca.com>
References: <20201012201924.71463-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-integrity@vger.kernel.org
---
 security/integrity/ima/ima.h          | 11 +++++----
 security/integrity/ima/ima_api.c      | 10 ++++----
 security/integrity/ima/ima_appraise.c |  6 ++---
 security/integrity/ima/ima_main.c     | 35 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 16 ++++++------
 5 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d7fe1d5ee8c9..81b00d07490f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -252,9 +252,9 @@ static inline void ima_process_queued_keys(void) {}
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
@@ -280,8 +280,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
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
index 4f39fb93f278..e83fa1c32843 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -164,7 +164,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * ima_get_action - appraise & measure decision based on policy.
  * @inode: pointer to the inode associated with the object being validated
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
index a782d8094984..5d821527d7e9 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -60,10 +60,8 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
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
index 97b26c425ac5..4031590b91a6 100644
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
@@ -775,9 +769,8 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	 */
 	if (func) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding */
-		action = ima_get_action(inode, current_cred(), blob.secid[0],
-					0, func, &pcr, &template, keyring);
+		action = ima_get_action(inode, current_cred(), &blob, 0, func,
+					&pcr, &template, keyring);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8218f68e7b96..0dd5730b265d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -446,7 +446,7 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * @rule: a pointer to a rule
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
- * @secid: the secid of the task to be validated
+ * @blob: the lsm data of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @keyring: keyring name to check in policy for KEY_CHECK func
@@ -454,7 +454,7 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
-			    const struct cred *cred, u32 secid,
+			    const struct cred *cred, struct lsmblob *blob,
 			    enum ima_hooks func, int mask,
 			    const char *keyring)
 {
@@ -519,8 +519,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&lsmdata, secid);
-			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
+			rc = ima_filter_rule_match(blob, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
 		default:
@@ -562,7 +561,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -577,8 +576,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
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
@@ -594,7 +594,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask,
+		if (!ima_match_rules(entry, inode, cred, blob, func, mask,
 				     keyring))
 			continue;
 
-- 
2.24.1

