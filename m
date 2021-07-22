Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739813D1B1B
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 03:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhGVAVy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Jul 2021 20:21:54 -0400
Received: from sonic313-16.consmr.mail.ne1.yahoo.com ([66.163.185.39]:40937
        "EHLO sonic313-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229953AbhGVAVx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jul 2021 20:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915749; bh=whNleagmPbVrZg9/Fuf5mW+JpWC5kGDHMi1mup7addo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=R5YkLCKy9fIvnoaEzpQ9cxEwjgu508ecn3ffYLWT5OtOFMsOoa4lO10qI4bhQqqx8aqPymWi8wQXxNMFQ+IoTzS45aQOSPyCyaDfauzopr5D21nwhFbJuOJ7JeWYcDacDokQ6CFhLGU8aYIGoEaTdObk7eTSbhrdmVoUcqraFIo0VSfYvfGhgSsigJBrIfFxJU85mXa+dVGlAn+W8y2mf+0JYfj9Ws1KpYT3hl+2+tSKuMuSEx6R6/VDYhVmXJ3m8lnuxmm3CJh4lnraiyvJ8nR/UyJhLWGD8At5CJuTG8qDugxHdYVT3CHkyAIBvkSgyG+lxb4xqfq/uLV780HwRA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915749; bh=hJdcpsScFHLxSuD89GezFmntH+BH72yCXfOIskd5CDy=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rmlpRO2rQCrJtG8olmSUglvmw+BLcvYnDn08ixWCBIYsgOf5AQD8wiIdPYGW1HFzAeZ87hSFTi4TtFZImrxBqK5Subn4o+yYpHDCjttM7eV6Cst5C1LA2cWd+Jf304/VpAeELEJ+0jO86a3vNjqEIoi+9JZK5a5z/yZTk1xtDUmG3hNzNXaPGr2dRA8wfdb1ECQnk/WbK06mvGpNhg2sfN8v14yZn0NR7dCrygompbjRled26pWRCXxoSkMPdlKYlVGtM8gQSzh42PJxZwuvMPWMrjOhxkOMxvSKvXVismSYjS8USMdOuNTByCm3pCBd5rfYnxb9roaQ2Ewqmk5R3A==
X-YMail-OSG: cv_56ycVM1miIdP1HW9xti9tB76zi4yRT7zKbK4HgdPHDocgXhwGKT1W1wGhWi4
 ek93MpwV.7iuz4V0cqs12j01yR2jbaySH.G9ZbDcO8X2UKG7MD..UBOwoJMOhQWt6pN6CTV.TIy8
 WMvYwDFeTDuss_LZ2EJkec33nrmWnkseYbSWI94LgE9zKftkFdZmBS_6tE9eWDK7dkGixOCTSy57
 Uy_LcEujsizhyavfjpa5wrv36cArrROTG.ID8yA5bNIHpUMZF4.IhC4HjKye2.C.HdEHI3uZNpkW
 XPplhCsLyn_d0Rd8pRYrf8I_kr6fZ10tMuqNXut7rCo88qACcWDA7Riz08w6AD_JJryRN.3OgHDn
 t4Y1uqVL53Id9gUxFWFYt9h_TdrGiLvomj7RCCGUPN7BgSX9yNv_4hCRFXcVvnbK.pnn3BoIznCQ
 furuYVE_0937pm3xX9fN7npByIQximTm_giJMxgMQzjuUIh5SMkhFlWxxLI.9xXUhDPCbFi_jVmk
 59gAcXCZg9wV4XuLN3W89Q6WxUuzgc4ybNGprfO4mps.CTkMTgE5X81o1ZQNmL8gvxH7cQK_uSHQ
 AF9UQ15YCd6QHj1Qf4FStMHjF_WTEKAvJQnzLW6pdedIK8DQYz8u3jgz0fwxgkLsulqP._EU5NIc
 G3ASnpudAn6a9plkUn9LQPXyf5eKI7uW3abUkD_Lywvjb_.jM9YZ9oIGvPY3PROa28LyUXAaJApE
 sokF0QmIrQZLI6rKD.N_Cnmhbf8ZZzWfZTaBhu0Jb7wAZTWndGec11ee.kxyIc7CCxuNQfgWkdmm
 d69DVU.uqjLFlhVw5FNSE8VYadrv9jiGmAuXfRiDJhp8vLxE8DBwhQuu0JUdW6HOQDtzKtXcShEO
 tsoHQsCScyvh5eaPhUHmVyoK9YqesaWYOW3a1QGpoyg6koSmRlsowjPj.yOdw0h9lksQBGbpGNhZ
 ijg49tJpzRCde0KL1.uqqcNeqW.vsIOkHo3eV301eFgFozQYWdwUHehgNiGEQGVKkC1HBzxdd5hg
 jWe_dx0Z_gj1KJa17DSoTr4RgJoBqMfMwn7kc9D5aJXdNO3XpR1sT2D9qIo9F6zgiSRz_ek0Lfby
 9bNly6mX7CCtnaaUK3PQhz3TLIXuKYNZ9d7MLRyyPOmo6ZaYwqUqMxLHNYZFvWPE2m6V6ZXnTUIt
 hPnfl_YRKHVjJxh7XhJ9HHJZAiTWeOA.g8AwmAHpBpQfUzcHW6xFObsWyQBZp2jueL5r4zlyECAF
 B583GqU1Y8EOGM7qrIibWP4mT717qaLKMTtaN9WkKaDSTBLx6TXw9VMXfbwcUJWO_iTgmvCZQCcI
 XWnQWLuITCZy8a0Q96nZwv45U94TXwzC2jOdfRJ9XApTTSDZEDkX3xtFjj05OnnWNIDk9bQKQtLD
 .qBw8DA19QzQqcy7Pd9wakblbN6gZROM2QHNvWRUWoVgCFalutYnND6QuxbW0Lzev1NT998vKRV9
 bzexr5a7_h_caP0BaRr6ZMDB482ShbVog6Zk79yUT.96BjMbKy6l3ewhmCpcCalJef8WkoUgfOV8
 ivoeTyKFWCHFbKcMAroGRKIM3bhZhvbdTiBirppu2gcNSja4IJzHyDhIdkMOD0IauN8pGMAb3R4b
 jn7vxe0PMaqingFhf9RcsatED_SSi0QAL4jKWaBjYU.wgxj.HLWVxZkRJv6E1C.hHvGbPP97Q2JB
 qFfGI.Xr8vmfm9SVAZZXji_w01SLBdNeJ52dXeBUnwixpgzsTRHSvuOiclzJswPfBz1VD29GK0qQ
 Kxj3XuTZqxvF3lTtP11BYrCNSCIvI9HIC6_sYLPX.NcFW.RQezidgCezTX56yU6Sc0mhstm1jBoN
 kZS_fuH0NIiX44kbeA49uWDK82gspTgrcvKLapoFLVnlj4V4ZD4ZaUCWZ002UpUie7_mcQEdkzp_
 44aqTiR.2DQOHpORattrE9Xp.vcUv2v.jlPxP8Iv9nl4IYH8IFcUH2bcc_A7ipEgV44FSYaWF0ey
 deXtTbJUUdqadbPeA5n7PNXwXj1kMV53bWrM2YW5zKhZHQvYBkQLx2asskHO8I8b4m6wOnXWsFmT
 iwfj70_teL1._Iz3kDivvvEysSDqBTL786BPnM_Pf2DhtXqrtDa9nIpeTvbSvCJrZrfCY5RhAPWu
 N5.IlJHFEbYbI51g0vzwKGiNZfhhaH6S3lxT5EtXI5zFK_UUUcF4ieWmcSKSGa0vjXUIcrObPxfH
 m5mtWuIb4QVmrc.CYjGglXCqjc1vZF6SofKBelLMXO2nf0Ya5tqHO2OccZJMKWZzz78M5rP4Cti0
 .CKaW0OP5RBJ98qAz_zzF3HPovOD0MTYPy63HVCN4Qd_y8KZsZX725H8uNBr7p3s5iVkln9BiScy
 bvfEdm9qViDkN5DvSTa.nE7Uz9i2njU3.3QFg4ZuiFWY1EVgWuVO7lVid07rLmYZpeMEj9FVyoid
 jd21zJMRsTJBFgS5zRjUhTsvrlTdnMvblE3k5ia1jw_Uqe3scSfa_Bwwh0xm4AhNZXZ7fj6dZ6LC
 Rnoz4ABcCuWFPRdkQovdBP0l0veXkFReScoG5rWItQDFf8BJvqCKmZWaOdIADPTVtwYVrtSjEo.z
 5CRou1fEvLYQpokEVADfE.Gz1N_MWm7QNqNND15p.5bOYgdwS9zpwkGJf3fdrwR8SopG6Dv4zhbm
 v6RRbMGbbcmXcAMiBMFBhG2N8JrNq1UAtZgO2.WEjLMWD_KQharxBuxCpBw5ifAxlXIrZnOp6a_j
 4otOWqWvPBrm7LqfbtgG.UMTNdc2CZu22XKjeoogKm1nQUD8u3lGI4zN7VM6dz8o14uR6nYC7Lvo
 _mR5pzLV7V8BdodEFZaZ__7CyShETr0NCnExuO7f1TtfA3Rp7vdYPxY5ApT6AS7jjOw4YLR2Khy_
 Laukq8cIvKaFRwb4iPIlz3Znh7C..UxuJqBzXyVQt6s9k_qk6hYLTfRxv0QYk8nT9oPhCxXjPaQg
 S2iLVbCxOI9_pDjch2dHg75oau3jP1JkcMTSloOORVwLtQp3EGIn1lokX7DIBYAZuO_s_1MXpRze
 _bBs_sUYmRmXPrFancGr1d_ZxiCFNkGvhuyXry1zBPIBnKM439tjLbr5IYDHZyPU51GS4Rpv60XG
 VP4z37n3YWxz7QiUkul4btC8CYjZT6Y_pP5e2T5iCuHjdYkmRt2uPLv7RTPPzUD6kp2yTc.y9ihf
 zyjZj_f7Lm8zXpNpJpVJojdzyAV_zbOQOdEqgTEXFAxLZPiST
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 01:02:29 +0000
Received: by kubenode532.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 10608ef7f8774cba27287058399213ae;
          Thu, 22 Jul 2021 01:02:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v28 13/25] IMA: Change internal interfaces to use lsmblobs
Date:   Wed, 21 Jul 2021 17:47:46 -0700
Message-Id: <20210722004758.12371-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
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
index e3d903d6e5e7..de50ed4df878 100644
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
index de084954d0b9..2bcbfb577860 100644
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
 				MMAP_CHECK, &pcr, &template, NULL);
 
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
index 6d112ec89c1b..a2b8c0ad8b74 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -548,7 +548,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
- * @secid: the secid of the task to be validated
+ * @blob: the lsm data of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @func_data: func specific data, may be NULL
@@ -558,8 +558,8 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 static bool ima_match_rules(struct ima_rule_entry *rule,
 			    struct user_namespace *mnt_userns,
 			    struct inode *inode, const struct cred *cred,
-			    u32 secid, enum ima_hooks func, int mask,
-			    const char *func_data)
+			    struct lsmblob *blob, enum ima_hooks func,
+			    int mask, const char *func_data)
 {
 	int i;
 
@@ -628,8 +628,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&lsmdata, secid);
-			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
+			rc = ima_filter_rule_match(blob, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule);
 			break;
@@ -673,7 +672,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -688,8 +687,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
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
@@ -705,7 +704,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, mnt_userns, inode, cred, secid,
+		if (!ima_match_rules(entry, mnt_userns, inode, cred, blob,
 				     func, mask, func_data))
 			continue;
 
-- 
2.31.1

