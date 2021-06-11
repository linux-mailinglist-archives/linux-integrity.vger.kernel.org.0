Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959273A3880
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Jun 2021 02:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhFKAVJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 20:21:09 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:44838
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230205AbhFKAVI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 20:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370751; bh=vmPLppdW1T7Yboao5H0X3j8apQPb/Sk4zDvbIPEe/TI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tsXxso4TIgNVEMnSOI24yvWgyNn+h3CkxOHdzeC+SpNK8ofseVXm4ZzPcLlDZPa5xAzmtmBzVxO+AYJMBURf2U4adiKObwdMk7uQU6HD2LhlkafXohunGEoky/HyCxGKKxfExgrAjvJ32tQuJbKQBlKnLpCX7oFO5LG2h864TCmsuH25CwhPuyDzVtCrJbZPAaoMku1Zsts1Mmkihk3NKXWT7J1bQYKAA6sgk/ur6b+zc5up2gszkrh7RsLo+wKoy2YsraOEgOdEs47x8zQNMtoxEYIoeBXmO0CPiH9YXinBFb2lwlqq8OdPfyfuvcbksCpoc41wmEMq3JyRof2HaA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370751; bh=A2319HHjQIY+ldn6Ez2AzMoO8MBrp9wyPN+lTn4x6xP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EFUcNM5YdkAOxGwxK6YtZ8MKf6K34UrTw3AwZ4qCNSufVQDgXsbjcwFMkegl2ajKIrTAqiBRwtxtpiQUoNFB5D/pnJNeA1geJv5HqQXWCEXkHRYbtlXoZ+x0flV9NxJb1ZCnrX5Xi0SZ53+LN6lAejvx7Df+zXYylwUaJt3xxonqKWyt60GzBiKWgcVHWO8m4VGB9C+pP6wbeIVQypC/TZkeecGI5V4u6kZwSrMBNnLk5iCX3Y3sfNny+/vPeFDbdh8JrIcv0uDY1Qrf+NrQcaVRwnx2nVSn4+rt35vZH2JpF8W8FKsIe9FBVyV6YLJFRf2awIUcPqm3Yn4eaPCbSQ==
X-YMail-OSG: SjJxOGEVM1kOcNGzan87wsOXu2B.ulTZE2v1KqGzbyLUpZKcF8Pe7Ak0CpCPwTE
 vtFX7JXgXekSVnQPjiqBu4I_SLf1unpyOn1Phwoff10Pni90BYujZVuL1_kh64a6HlQy7uNWW_Ff
 nTxuzC62ABGvHdfO1qy_qG09wm1Z7MvNa1ucM9D78GCKglfKmZ6NH.psjxk6rVRruJV3JmV6DEmS
 GBHNaCOYNIlksQXx1YaZtjE1XOWzCS1eAJ69hlIOTl8x4Mn2BK3bsnuE.qZ1VUG1UZVc3CU.r970
 R1AIrOsgyITgpg0GbsMz.WHL8r.FCOJHghTZdVj8GD98IFxydOh4rjrhFCI5GWjPkazjZx2ir_bn
 OhA8sk4eIAG1nwWG6Ybk0KsUWvG.lCX5wjoeLvTcKSKpyjyxzmScZ01JiqQXwk0pxt0DA3p8MXop
 RsxAG.7zDoQilG7cWnXJOuuMyUCGfG2YV2GBBH6VNf_HyePOJVBKaojJQ8lBajI72Gm4ZoHrdmOH
 kZKrplGIMv4CeVLna0T.h1woI2np2MiR9YnXOCFmgztBeKcS6if3IJte3E7Jl1bpGeNNOygr.jQN
 yuA1LtnstjL4KpIeajKAWLrsX_QulF1HPCrJGmB6klYWSZtukj7tKjNSPeymrcPTfIUTcujC70jQ
 05OFZC_VlA8mFLJ9JH8GJDxaHCQISsntWRd4KFC932CbAciDt3ZWsricyVVyqn9GxNoBGmV3EZ6_
 _uy9upNUtVsSQCL8NQcYauG.._K7n5kES8TYR8GgmiAX3M5dGJwrLaoouLX3IM1FhWMgAtGHgmRx
 otDI.4IGzeSacLZ8NR3Qyeq8k1VmkZLoWT_I_HE3jaq9NyU.bmT90v2uu2wYTpcjnfjx8ouS6Xsu
 HfnfYWPdSu4YQLaLHE8B6YKJUpuFlHW6QNRSeC1qGiu6KPKrq94BEo1QfLF3IK7wpQrSzI965JxT
 fPo8rxfaxsJKEjWl4HVI24e4kuQoY6CyFVmgMs8CKZvPQfTEIgo7PNNZGz11bz1v1wdH3G76HvQe
 ci0xfzdj7xCGewLwcd8ThK2AxuJlM3nzdrMaTUekkHPgZPt7kuR0LGZA17hJp3DkpqNjUKiV6jM0
 5lhPZTJUfFbL17ZpKtYuz5QVTeIM.AQ_x2KJzUPWc_YIYTwNK4ngjuxuLb1h7ou5APBlnu5aCCSy
 8JIzW3LNJnh4AT7bGAwSHMyK39VUvPCJQeV5gcYnROy7aOoXapK2JB47MPOYUzBQuvdA_zSyTFhG
 J.byCaL0L0b31FhLlBG2nZIaB1IsuS560wxDJ0KwG4HvE2jvOaSgLUk_6QkTYAdL3pAyMznwOd6l
 NC4OHNKwW.YRF7a9JY_tFdEpVIROGXTqqUJtiO3Rs24.B.PAyqAd77MvjayrU8xL1NYuYYEAWI8z
 C.Jkxde_fvDXjOpUoPcikGey6vOj0cK5A03uVOCuzk9T24dp2_6cXA2bPKTSIxXPep7mXKsKTlbK
 7u5Pecu9_YdhJxxQ9xUHCWrQa7Gj6B0tw0iAURye8yai46rnN9.k2WSoHkmC85Zp0OEy96aJ_LUv
 3LUrko_8p8Mm1YdAGAQtGiHi534Ab5X19ZqPnJxSVOUgVBTH2Y8pJswvZXM_Qgnr7ekAkb.CTWJa
 o4QXEcucCG.iXvzhVs4hgWvq3Y_S0TA5YjFbFrxkFxxD1NVzCeVwrbFaRJorO1zigFeL5rvv071q
 HYp63wBfUyDFfC9Cx9KJRcqsDHf7lf9LLFWHUDWxeY4FCHGteZYGchjXoTv6rM4w04DvAlhXWSwy
 uztINgpS0Vs6Wks_7EwkaqrHnrfOfVz_yTbF6g_e72PRZ1s8cCbxoSIsKapG7dgXV8B.souhjwNx
 _edvtmeA9pj32ZU7YDeiS6_39tFBj8hKdLaqw5xrUnX17.4mPVw4cTUnOsM8GGIOsCo8FAgPXX46
 zHSngeG2sbdNcHJGDZ9AAj9RHYaWcug.DRINQ6NZ2BB3CO8UOfu_JKNebL08es_RiFvTkvv2L_DP
 dHBrrNvcz4yr1tHaLzgXtSJEXFh3ah5PXp2_tVyXIqRFGuucg7MDaponI_uA7TTZ9DpSTCNAOUB0
 rZxfGq8bLvFfEdUphfGzziZ62vGrzxZZ7j6VMJhkwkJ2EYIZooy6K14v82oXzaQCmlo8kitpwdXh
 TXOiZBFehjc5mD.PdPtfTk1NGVh97_hm9UB_DpLyz7r5ADusqBW0BkzNGTxIUbqWyfUrUaCcQl0Q
 H5POlU2bfMAk_4efqZhnJmOzL5DsHnAcrFoiNYMffcOaUX0olMK.UgY2b7wBOhdw4MLve.VOrETX
 Hw4OzNg6veJq7hJfgXFfrLOeGC3KT.xtOeV6TiXAUs8MG9f9s8KZrkEvAOJbMvM9UOOgGrjt0Oms
 AgxqyesIQkMBiPZiHq8ajoh0M4D7b3g8blP6Lww6CbLcmZqvlqDvwn6Etl4ACx9rTgRtchKGF7fF
 wDGoYqfWin1kixU.uFsS9ZypQhEd7kwiaMsuIkxuqG._KvBj5Rut9yuPnPLnFbMoRWd9ZGdIpPHy
 4A2lvZyBBIUGrqQ_BoCmTuWsmZVF.HF7rPlndkehjHh.hueTt88FnP02_DIbAVe5xsSa4pEtr7np
 ENxe2XE7k1kzRnYobCpiIHW61YCcm6_uHsJSoQQ04uT3i5Uoiga9q2aEbb9xnotPYaZOQnUsXTKf
 5XaeWuYG3aWhhRDQ9LhtWCo1wAZr.IJI9GEQJSO.Mllo4QaynG2tvSaB32TeWmv6GLp26TB9.4yu
 BHi5Sdq_oNcLIvRybeG.jcXT1ihwei57BOCdFplE.CU5yawof_yfGYHngjtVyRCHF9UozhkThekF
 3QHeCAuAXoN6Ex1Ru4_l2wK6U8Iz4aGBm4ecevvtJOdC63R_W4wrq7YVoDZqg2xq5wAx8MIMGhgO
 FmaNIdjnkN5_G1EKW9NLR4thJiBgnAXhmlD2Wxd9veJ8ErS3p_SquZ5HFNBaFsUKpY0kbKOms6BW
 NeIOBAbd.Ky0wgeT.UTvlpbtuNuA2C5J29yzS45onXVM65qP1seHm34pHObC6jgKKGXoBBAw1vi7
 Jw0_xnO6VGX_kuMrRkgRSEgg6McvYAdXD.cFST4zR5YJkYPjPbEr0i05wNpFFhmBfm6Zor1MOe63
 PJHkaFfvBEIKz1.VkpONPa_Vi.PDz.C0ePZOyVZDQwYhRG3GR8YoBSsOonxA52ORDyt9kMz0XGKh
 R
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:19:11 +0000
Received: by kubenode563.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b12c21074e4f34f6f43bf842ef07319f;
          Fri, 11 Jun 2021 00:19:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v27 13/25] IMA: Change internal interfaces to use lsmblobs
Date:   Thu, 10 Jun 2021 17:04:23 -0700
Message-Id: <20210611000435.36398-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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
 security/integrity/ima/ima.h          |  6 ++---
 security/integrity/ima/ima_api.c      |  6 ++---
 security/integrity/ima/ima_appraise.c |  5 ++--
 security/integrity/ima/ima_main.c     | 36 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 17 ++++++-------
 5 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 55f3bd4f0b01..a6b59fcaf62a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -251,7 +251,7 @@ static inline void ima_process_queued_keys(void) {}
 
 /* LIM API function definitions */
 int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
-		   const struct cred *cred, u32 secid, int mask,
+		   const struct cred *cred, struct lsmblob *blob, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data);
@@ -282,8 +282,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
 int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
-		     const struct cred *cred, u32 secid, enum ima_hooks func,
-		     int mask, int flags, int *pcr,
+		     const struct cred *cred, struct lsmblob *blob,
+		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data);
 void ima_init_policy(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index d8e321cc6936..691f68d478f1 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -165,7 +165,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode: pointer to the inode associated with the object being validated
  * @cred: pointer to credentials structure to validate
- * @secid: secid of the task being validated
+ * @blob: LSM data of the task being validated
  * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
  *        MAY_APPEND)
  * @func: caller identifier
@@ -185,7 +185,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *
  */
 int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
-		   const struct cred *cred, u32 secid, int mask,
+		   const struct cred *cred, struct lsmblob *blob, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data)
@@ -194,7 +194,7 @@ int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(mnt_userns, inode, cred, secid, func, mask,
+	return ima_match_policy(mnt_userns, inode, cred, blob, func, mask,
 				flags, pcr, template_desc, func_data);
 }
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f8c7b593175f..b2af72289f00 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -77,10 +77,9 @@ int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
 		return 0;
 
 	security_task_getsecid_subj(current, &blob);
-	/* scaffolding the .secid[0] */
 	return ima_match_policy(mnt_userns, inode, current_cred(),
-				blob.secid[0], func, mask,
-				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
+				&blob, func, mask, IMA_APPRAISE | IMA_HASH,
+				NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index b3e00340a97c..b63f73d43bd2 100644
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
-	action = ima_get_action(file_mnt_user_ns(file), inode, cred, secid,
+	action = ima_get_action(file_mnt_user_ns(file), inode, cred, blob,
 				mask, func, &pcr, &template_desc, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -392,8 +392,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid_subj(current, &blob);
-		/* scaffolding - until process_measurement changes */
-		return process_measurement(file, current_cred(), blob.secid[0],
+		return process_measurement(file, current_cred(), &blob,
 					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
@@ -434,7 +433,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	inode = file_inode(vma->vm_file);
 	/* scaffolding */
 	action = ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
-				current_cred(), blob.secid[0], MAY_EXEC,
+				current_cred(), &blob, MAY_EXEC,
 				MMAP_CHECK, &pcr, &template, 0);
 
 	/* Is the mmap'ed file in policy? */
@@ -473,16 +472,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	struct lsmblob blob;
 
 	security_task_getsecid_subj(current, &blob);
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
@@ -500,8 +497,7 @@ int ima_file_check(struct file *file, int mask)
 	struct lsmblob blob;
 
 	security_task_getsecid_subj(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -698,9 +694,8 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid_subj(current, &blob);
-	/* scaffolding - until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL,
-				   0, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
+				   MAY_READ, func);
 }
 
 const int read_idmap[READING_MAX_ID] = {
@@ -742,9 +737,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid_subj(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
@@ -889,7 +883,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 		security_task_getsecid_subj(current, &blob);
 		/* scaffolding */
 		action = ima_get_action(mnt_userns, inode, current_cred(),
-					blob.secid[0], 0, func, &pcr, &template,
+					&blob, 0, func, &pcr, &template,
 					func_data);
 		if (!(action & IMA_MEASURE))
 			return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 5ee7629fd782..caacd8bf0462 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -546,7 +546,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
- * @secid: the secid of the task to be validated
+ * @blob: the lsm data of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @func_data: func specific data, may be NULL
@@ -556,8 +556,8 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 static bool ima_match_rules(struct ima_rule_entry *rule,
 			    struct user_namespace *mnt_userns,
 			    struct inode *inode, const struct cred *cred,
-			    u32 secid, enum ima_hooks func, int mask,
-			    const char *func_data)
+			    struct lsmblob *blob, enum ima_hooks func,
+			    int mask, const char *func_data)
 {
 	int i;
 
@@ -626,8 +626,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&lsmdata, secid);
-			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
+			rc = ima_filter_rule_match(blob, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule);
 			break;
@@ -671,7 +670,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -686,8 +685,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * than writes so ima_match_policy() is classical RCU candidate.
  */
 int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
-		     const struct cred *cred, u32 secid, enum ima_hooks func,
-		     int mask, int flags, int *pcr,
+		     const struct cred *cred, struct lsmblob *blob,
+		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data)
 {
@@ -703,7 +702,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, mnt_userns, inode, cred, secid,
+		if (!ima_match_rules(entry, mnt_userns, inode, cred, blob,
 				     func, mask, func_data))
 			continue;
 
-- 
2.29.2

