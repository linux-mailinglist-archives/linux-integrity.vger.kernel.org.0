Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B462BB6C5
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 21:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgKTU1a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 15:27:30 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:36308
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730598AbgKTU1a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 15:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605904048; bh=XWyk0JADyyo2acfofHqJ2zRfDUHoIQYgdTRToE1kkCw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=TQRrAoVZrb/9Qw1hQGEXz+i6a0m857KW59bEt9qnWwWmwkjdXUHVyBhoZea4nReFqMn6r2yC89rtFd2YXdVfaeRaZVV8GPZisXhQPwbUQ65WBIRTVP1tNHCakagTndaso7OoUKfui94xBqnKSsySpEdVmD+kOmRNpDTogsgtiBzGtTATEDSceDTFPl2Kt5ZxLeRJLFciRQlo1TffX9saxwPV9c6UjP43Im+/PugiDJYQnf9CcMW1ATvPUFO8hNP+Trdu2/pEvKp3IQCU0TBnqlfJdM/zRtGTLU98tTatzfjZESKqxirn9U+AKsLxn40gUAlX6VvKeJl0w1eKwaCAUw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605904048; bh=TESIWD6Pqyx2X94UUuvUrfBMsUY3OOPN8yg97WTt6MV=; h=From:To:Subject:Date:From:Subject; b=kVr8NFFpualmR6hcZ4LtObGAqkjbSbAjXmfcIscc9d70zXBdLjQ9nu/EgVGgxXYMxlhiJEMVYLoJiWZwkaRply8ZPdLgKSJLEPdEOtOLdjmPASyqv36pkQaL+c4EiaTtSCdXGJJn+u06mhss5CsNnKL3JJ5TP6GcVkYtuCaPA0CNy8vjRpoLwGIeF0EB9FS4lflggg1dB+BF1k4HFUWkLOQ8/sqS/o303blMwYJOXkoGhYxEhuWTndmC7aR+Tl9+CsKdxBxh6chcEJIlvg68WxIhMs2QWaPcSokIKNvn4/1s8XmjY+Uqot+1llBtRQZAHmvb1BPfjgMPfq+GByPsjw==
X-YMail-OSG: t7iiHXoVM1nhbuS9swUS0euISNnxLIlp92hVwvwkgxFUc5FedXzj8ndrxFKdYfv
 DNtOXC9ZUYzP4fTI2j3ZfpdYU.9W.027NcE5L1pKoyl8qT8Es6mLfNhBGoNo2gHG.cRCGp8pvNS.
 CFnKNB2sUwZIeqSR9ODer6Z3n3cyFpdIiOdgJ8bROvv6qIqSHB8fjJEBgxOnlH3eFw0pO42Xd2y9
 _zki4q7ieM8xCvAtzptVUYmU7ym1ASY92txd9RrNGme0MF.QErOBivnRJkKXvfwUO7kZpA2syJoY
 mBzVAF26Hdenj2tqywiXhGz5NDkOrdlmk_A1T8Zs0CocpAj79LX5DPZp.UkwnuuU1iIlYapTtCrC
 .U5zdQDeU.KYGqpgm_wKMpi6.5cj8osnTiJFWzrlSEb758MIdVODRiYyBdiTnvaXOA3.GB7H1Mdm
 _jCoezyHMekBu5B8n.N4OhUBSKXV6B.UJEQFU4kcDu9m9RMqeN6lZH4nPRNIeVBFH2V6WDU2YgQQ
 D8UTJx6jwp.hUdh_6eov0CwKC6JzmbW5rVHJrMLJ9iUMxWu9ThXK6FOtwsA6YAn8QdIF09fcAVwD
 jdjf9pPhl3THBB2cd6u6llduUB29VHJOHAlrxqMU09FzE9CYEtqWnESxJ7ObwcVwS22yK0hM7ICI
 i6eZamHWr3_7IZTH7Jv4Jiux3E0_ERi3.gAVuxeyibayyItShSHHLT43IJ3yaCiFoVEogXKTxlAC
 tIKlHJMhGaqZyiWhEwgf9GVomtAmS5KwwN9uvOGMqfjj9e5sYIY4KFkqKkI92rN9e02ywe4fROQF
 lM6gBvIqYEEBL8Mag7zui3d0HnXFEDueSb7j61Dg1LLgimOU7Yqy_cdop8iO7V1.QfbgN1wKsMPN
 GgLe48UU5F0wmnqzpVqG0_mnZCMYiZfx0kRT9sAAWamJi6IVyTn_24msTzwu5Dxd5_f7VpYGoFyY
 204EpjQy9Gq7vb0OtnhCC6T3igJhWrp9klSUC5Y2V2wk9JOIlj1ThXapsR81eQUHguVNFZtbKc1H
 WZ_gCh7ptyP3Ad5bzvYmdaVNZAxd40RR1O8IWLoCr2Y3AXv9jxFzGU6eu5wUB.EdshrFR1kcWrSe
 riKy0X5JpEAu6XzKEme6mL7iJSus9vFW4OBmXh9a0AF_m.21CeZ7z3m6fAvFAvbU23iId.jVi_kG
 Hh5LCzfn0zJsAkQ9NaaigTILC2Sgi5tGG5iWZ2cz2RiitkY.GhIPjbYrJASlPWdmT2jUFKMqSVNV
 OuXLtkGhpabkiks5rBEuS92TVHOJqXKO406VerVI2MQsgTy9x6dlY_R2.iZ8Mg6.X0x4_f9.uNMe
 jDN3IMurIfQiXlK6BDv0Y8SV5vuOJmgSWb6vCGu21ClmxB2IfcASgdO2KpWaK9rQcYizfABVhYkm
 _VmV.Wjq6ofzdLXDygJrPJQ4KQ07pL4hQmrmby59C45_JVqj2TF8U2eeh0HtvmBlEdVsQ9ZudngQ
 UUHHOovHURdk36Yp4Yc4Rkw2D68jm8LJvay_j..3THoWPIWiH7mOIUV2VfYDHpp3UUmpUdSkNh_0
 ooQoMuI6cy41A7z9AgLl7_82J94vmYyx2Ldwk73igx1.YmPNGd8p3kdo95SgJblFU7dZAToOHLEc
 EaV1R4bxs6lpMFiGbDDoG1fZdMkNH6HrcUxc2b.XpGLPLvxqiAOvBlFnX1_KN_i8MU6h6fnZ6QLs
 JTctgTwhw9PV7zoJCiTY29EilLdwh2N_T14ko5xcNyT2FUnvlwMD3tNbR4loNu0NKzvHJ83vWse4
 EUhSl94NvzKJAeliHHeU4sPmU3ecH8RFko2fjYkM6zkvH7c1EbTyh.fyBBMxazab5bIunff6Lsf5
 PE9n0dpxF6beElOFYRdnNkyd98QYxybqRk5IfFQtLC.T0Ltu8dMlt4fnP2aCJ3OQxQ7vgahqABbi
 QW97WkIyZHDQ0k7k_ObXM.a7lKo2ZT6KkWcVhjfxTbxgJv9oYhVfw7ri1ir6bf75rKw75VqYJQuz
 Uh3hXE42HmfVW9fMnkBa57V4MQtkLWbrtSs3V7IlwnRfbbk5N9a4ylbqr1ALK2VlI.YqoQA3ajLZ
 .IcufwymED49_fru1dpEfubrxILqXShsfgV4obF3djco.zrdq8VvQ6lTA6CoN66DmLG8wqOvsos1
 egZMMJW4KCssDBuxiEqWPGXAsLE57YZWrG45TfEAGLigkdjwmCLBV4N2r161hsyvn8jofePuZi8F
 cgMcvRb1uPUwNuzOowcTWmZedzz5btJ10mTAzKWqh.vji5xjLWPnEovUNzI6Oq8Wj_SJGQgiUWoY
 5fazxqN1YQU430xZThGQfIUgq601DIMfBV2d3Fqd.H76NydWfPzD1fS4pl07Waki1PVYi5bZWC2J
 7nYgV7G4kEI.zC5h5ctzDsmNBWXqfLSplshwBJDqj61EL6afrV0unF5SzkHFTz7srAloF8gb319L
 4ikfRUKUTl93S0HGwOgfYPWWxz7f9TLMGs0qiFHvtMftNKyplLcuKD6hJ4eCYawRffsq5WSwWlwE
 tbDT.VnV8stQonVhjb8qAJhNfp14wviOE2vw3_KKxNRls6LciJO3wcFzyzxpP9pAeE1Xcae4FnjG
 TaOhRP.yRCDt9CwVBGm0bjwUnVoos.yTtNfcd96fDEFZiHV8gbT0DeEVL81gqjCl.6cfcCL_yUSd
 Vq7rRaoDxaRYc9N4awNjhU1avScf.lKbm9XuCV.E44cdXbbzraKlrNHutwJzEhIQOGkEeOCNBjUi
 RjH3SHBBO9F4hAXS9vGhHiUxYG.l7FV6waDuthvWyY7SB0JpbdN.ogKO.q22Y9PKBs6iekaciS.H
 4kcSNjXud4VZTiMF2IfQNUK.HQDeEzLAkdWSnlaF6l3Vc3r0g8SUGt92ZgZoiVld4eJm_R6AO7fE
 9U8vVmhOhSblZvLOT_ic8Cj9CdUlQBXTdAbLrjSGcVSUtD60I7K_neRx6zoq9QYzr2sdkDtHe7do
 9q4tozQHdqv4EIYVchFUVumRFktldeUAm2jgJOH49tEcLY3l.bKulajd6pobC8d1QL9Slnu.PpTx
 jQWZ92UXz1BLZ64pddXWH7N53TTmc9LzzN6TJhiLUMwal_5ecvpuvvNb.Av3zzPHDj0IGUyqP_J2
 oW_SA0WlY9OuI
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Nov 2020 20:27:28 +0000
Received: by smtp421.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0b8368fe1fee6c0cc7a1e63711273346;
          Fri, 20 Nov 2020 20:27:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v23 11/23] IMA: Change internal interfaces to use lsmblobs
Date:   Fri, 20 Nov 2020 12:14:55 -0800
Message-Id: <20201120201507.11993-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201120201507.11993-1-casey@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
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
To: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h          | 11 ++++----
 security/integrity/ima/ima_api.c      | 10 +++----
 security/integrity/ima/ima_appraise.c |  6 ++---
 security/integrity/ima/ima_main.c     | 38 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 16 +++++------
 5 files changed, 36 insertions(+), 45 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6bae2ee9b251..8812e9b9fc1d 100644
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
index 2a18124af429..7c4e43399269 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -71,10 +71,8 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
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
index e2fd092a1023..39ca17586c6c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -194,8 +194,8 @@ void ima_file_free(struct file *file)
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       struct lsmblob *blob, char *buf, loff_t size,
+			       int mask, enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -218,7 +218,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
+	action = ima_get_action(inode, cred, blob, mask, func, &pcr,
 				&template_desc, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -392,8 +392,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding - until process_measurement changes */
-		return process_measurement(file, current_cred(), blob.secid[0],
+		return process_measurement(file, current_cred(), &blob,
 					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
@@ -432,8 +431,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 
 	security_task_getsecid(current, &blob);
 	inode = file_inode(vma->vm_file);
-	/* scaffolding */
-	action = ima_get_action(NULL, current_cred(), blob.secid[0], 0,
+	action = ima_get_action(NULL, current_cred(), &blob, 0,
 				MMAP_CHECK, &pcr, &template, 0);
 
 	/* Is the mmap'ed file in policy? */
@@ -472,16 +470,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
@@ -499,8 +495,7 @@ int ima_file_check(struct file *file, int mask)
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -655,8 +650,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding - until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL,
+	return process_measurement(file, current_cred(), &blob, NULL,
 				   0, MAY_READ, func);
 }
 
@@ -699,9 +693,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
@@ -830,9 +823,8 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
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
index bbf9fa79740a..a95eb37937dd 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -508,7 +508,7 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * @rule: a pointer to a rule
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
- * @secid: the secid of the task to be validated
+ * @blob: the lsm data of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @keyring: keyring name to check in policy for KEY_CHECK func
@@ -516,7 +516,7 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
-			    const struct cred *cred, u32 secid,
+			    const struct cred *cred, struct lsmblob *blob,
 			    enum ima_hooks func, int mask,
 			    const char *keyring)
 {
@@ -581,8 +581,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&lsmdata, secid);
-			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
+			rc = ima_filter_rule_match(blob, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
 		default:
@@ -624,7 +623,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -639,8 +638,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
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
@@ -656,7 +656,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask,
+		if (!ima_match_rules(entry, inode, cred, blob, func, mask,
 				     keyring))
 			continue;
 
-- 
2.24.1

