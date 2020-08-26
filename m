Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE96625333A
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Aug 2020 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHZPOr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Aug 2020 11:14:47 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com ([66.163.186.153]:41879
        "EHLO sonic302-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbgHZPOq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Aug 2020 11:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598454884; bh=BaOyehg80wFOhSiPHeraW2IfHnvvM8nVE7eT/PRDJX8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qbZhEYaoYuDqKV2K2xEgbIMJrWBpxfVYsQfB7kD+0/7apnfI2FBr5HYlTkkzd55HcK6cHgi1kO6UzjjosL7RExwZVpgtSA1PNCGM0mBunD9slymuaKCW9yAYcSuufZ7rGHHe6uxJB87jzWKONQAgjFSUkaATDbykuB0tmT5iS1Hv5wJQRu8bkqMTXumCoG6SaJU2QETIGbuJ13SX6jRzC68d0gY8EDJX1vJQ/dzSb9S12g7gtjBJRocLieWUdWNm4w/aca2qMt1lQMowBTHubzApq4ViMRp4Sp/8cDPeXisPy4PEelaMht1msU0yvdig/ZO/KSug9WX2lZI1xc5t1g==
X-YMail-OSG: C3e05QAVM1nQCu5XR23jPAh2OXK5.HwtF1zd_1VPSY2NsBDVFF6OKS0lO9U8nNO
 8ChPKeCwgBVbwP6VYwdQy9EBOX8omVtTjW7E_2w2HaTQ7cQDdSduI_25G0SmikrcPYEIvvrO5g7a
 RFkvibTiAlF1hTQX11XswtsA_vuDulzaikRdEreP3oJ_Ty8p07_2l0yOfdP1FgCLM2SgKFDJdmK8
 sXXGEH1BgmwUXPOACgvBRZP6WE0BHwbAvnaAJyZyhQwTigBKYgx3fDxlLvms8RXqI1.nRZB.lkqG
 4d5UW3E56QrXh8DSEBkI2ypQIXKd7pkUBxFZIYwi06eVDIoM_njJcLVOncZQQri5D79zxrkDy3pr
 rxg1bcND3i2faHCeUAGUF3hVfU3uAQxHuQ.eNF82iRax8OO8Zbs6KyYDqSbW4DaYngfE9IsnIjpe
 9bdm0qzKllOHPL.8wDae3bnV3MDq1cOYI2bnTquY9vDsrIgrKR8wK8RNs0UpXW6i4CcIQAxqDkmj
 ESblOXE2JVVmwzA.7i3PpHr84eW1p5Ll.TfQJw39IxjX5JWM20DEyQQClNuvLmwJhPlQTVmp2hwc
 IuvWb9BM7Fz1WW.zADAEGoX.qqtPTBU.Z0qeoED8x4am6JANT4NLvB2sKXCIs36f1.il35DzYbKY
 eT4e74LEa97jzdCDO9KCWySZi4M4q3UyoU.PG0tT_Z7URMSHXLl7SHfll9PdCu.k4CWQ.oQw7Iok
 wYJ2946z_8sX5J3JKfsIOrESQ16Gh2IUe4uEs.v.0llxbViPSZ5xlh3PzwEKF041EjRc087reY2v
 SCM7_jDegAskmEvucoCxX.tnToTOukHbm3VbZuYeB.OcSfJDSvWCtzFPMIfSeBDMihM8bo43mlFk
 F5jSe0yfOA5gcAqtivuL7xHSuYo6WBLra1weseuGRZeFITOwYSXMNdBlyk96pQK19nlwX2YfNkYI
 2.wmoZnE2hCHPrxK_32d76sJWMB_i6rGqMZJyPkLeQb5Q0HuLF_w3xucztK5a8N9Qkd7BkT6VZ4y
 82dw1nbIj_K5G7nZcp5LD3cP6asnThNx8o4kVtBD9czQKE6nrOKbdNc5Rc3T1CwiOvYwmZg_GKKW
 JzWyKIDM_ZceZ1QJpAb.ra4HxIHfB7R5gkxU7NWa1rhlyOerYgdYKr2P0paI1rixfhVroeIgOW6H
 obvCuNpyQBqH4IyO0vX8SA.DHm7yKyTe.q.tqmW3pmGe5eIs89gD1.M652va8._pLgqb4vLBQde3
 1_zw3PKsdysXWGmVnNUdhctRI1PThgGRodKroWq3Y0bw3qzYLhXK5hqmh.MqtLbuH8.64Jj9hZZu
 Vp_m7OOgL4Q.RqYr_rpmOfjtIUhz3f_hC_zeERxhu6fX.j4kKctGGoPHwKPCF3HJ8da_ZSobeXIa
 4p.Hqo9bzLeuE9Ue7v5fRZuvZ3AUKoisVe.ltpnhn9sJE3XZtBAhxRb1sBnSwjLk4AgkfLDcHlT8
 DxKlbpMN9YdQa76cjZIIiWJmRZVMMFEDuewPcbg6GWtnjdzvrSjXlGe1hay4RkcdAoZRBdt2km9D
 yDCTSWAjHxVI1B4TrX.m8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Aug 2020 15:14:44 +0000
Received: by smtp422.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c941a296967fa92c3240eb0ee1b2c3e6;
          Wed, 26 Aug 2020 15:14:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-integrity@vger.kernel.org
Subject: [PATCH v20 12/23] IMA: Change internal interfaces to use lsmblobs
Date:   Wed, 26 Aug 2020 07:52:36 -0700
Message-Id: <20200826145247.10029-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200826145247.10029-1-casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
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
index 8a198fc98ffb..9c22d5410b81 100644
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
index a86b35dad4fa..b057c758b430 100644
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
@@ -519,7 +519,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&lsmdata, secid);
 			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
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

