Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AA3332959
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Mar 2021 15:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhCIO50 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Mar 2021 09:57:26 -0500
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:35991
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231843AbhCIO5P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Mar 2021 09:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301835; bh=QqERwMgo2btg5WOwgfPE6/j5a3bppCWQVM7Zzy2HQyk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XqtmEPVYsRrNYxDasOlYd6mtl5i+zLB+COC2qmWzXoUOs4O7sW2i5bBx/UYPQVzZmc1Pj6hX24eJDYooTbevzgoyySQlaQf8e7L97iK/BIXHvaLId28UnyS+Grx2vhrKJGgfzTi8Mg1r/plxtKjOOOkZV1ZDL0P4cuyV1vEeV6NKdkNNAROmJDIPkm/pzP/x3SQSiN6sKtT4ThJZEiSrvkK+yjMWXAHVvp2G817nRaTe7SpIu/WB0TDfTHLD54kEVO5sAyHT835VB8N1miNu+btCO6TVZIhyQQsKYCrAVC3wAZ3dBCG9sgfG4kceVUfApmOyuulw9BRmxO3RUPgmgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301835; bh=/gKb/lHhq8VXDJ4L0gy4/zRL2os2W46WVSxQ+L4rrxW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=W7ZIgjzQgriR1mHoQMkcGOVSqxHs5gPmPlWrwXb2KAQYgWuKKWPHfXlE6FLBY8/X6UFRv9BUguC/fy7vcJOkde/w3q1SagnYZiinUQKKnyEwMe7ZMIMYb7JtcgDMtzScZ9W9HlEIUA3WG78Q2gSkj0IiGPLphuinbOeYN/2sfdT1LkrSN+9pvsZKFZWwlGOLD7Ju/syWw+IfFFiXCnA3V1s1wDTP45563HML5kh+HA1CeUwMTnWkiOPBHqLdG7hx5f99GszGo1VSuIrJ7SmGeMHg1PJ5Lr5TafMrhRWRCAGGfziBNBKALKIZ95oBrI5KIUzNdQEup2/6bhjL+ETuqg==
X-YMail-OSG: F0k3vwkVM1mQWVLukyOPgg.qEbath3p6RwYqj1ogcacy1Yc5LPheFwS7IKafHdA
 hYfmaTTUBI589m0XLNK0yxZp8mFYvojfnGfaTmpFx_ja6nvPLR4QeMI2P0PGHGokg5_YnaUSQbIf
 9BmbY7CEQstXwRSIdWXTrvLdnxg2gnCXMHAsN4oCZFOKNsPsR9rBfVFmZc1x5s8Wb8v7cXM13jT7
 bOtYNuAApBa5wYDJHO9tAklnURCVg7XBgWWlDjBHHc8JmMZYo.wT1l7OH6N0rXMtiSyTOxc4QMp6
 6k74BliroRXS9eAqwPUaWg7GhRputn9EWoBheCR4.luErV_osOli93v3mEosmDGoaqBDQidAgW.T
 9AyVomjg0ahJjEKbeYlK4E8VYbmKzBKYqnWE1tUOph_3xumA0fujWryRX9i7ZwmPoQiGhgIwEt51
 WK74bbpX4G6JbLzZ.SczDx8Ekt9AvcFstIVYxDXo5LoCii7hjOBBt1bAjXH9fg8QwvFLsOebrKSa
 zKPzmIKXgS27RK19efrffsbePkMJcReK_eGorexvXahnPALZNwrq4E940ZeR58QGEkjg.F50HB9h
 V36rrmJPSBhbCjaq3W6N8czJNIYD9XYUHHMbmXWvD3SxH07YrR87wLhqRHTx3kNtknJbQ86qgbVp
 dIOHrmrQkfobmg79BqXg5UCMqj9DZ2HF61LzZY0Gh7VBAe5imYw7mo40vKUnf9qGhZpWfWupPUh4
 qWb.6fcxkRVaKjRnq.oTjR8fORXl41WQGxHxrbYQsdb9nZMess3s4qC_wgV.TcoLr3AXik_YfH31
 qIzdlogwvaoAL3mF8MV0Chxn3dSizqc_MfG42bksBlptEt3XMKOHvUQ4qibeHScPOIgAreoVgUqS
 PUfM7K6KZAY36v9.qRFn2P96kRjkhL9pUDxNNipO4wUIHN5nABQKhUaf1pEyz59gCJ8Fde4VO8.u
 4tphYQMVqbkffgzUObAt0xJ70CDXM544uqnAu62BLrJNsTHpB5ZrcglZWQQbBqdtqfQOt_AtYH4_
 WefNQwr0Pgi4IarAMxUS8ENu5M6zN2ehG1rDo4Zn5J6xovmX_EAY3BauVyPuLfq7qws545L9nr.o
 t9jy5kVURrhRtUOVQYS0ykwgBwCc3FidOtBs3byyfLFfAWpIMo0h2x8sazhhhO0bd9bdWefbkwcn
 _diz8wcLajghJxIizjWfhEu3TgyCjs6BUWdTBcl94vFlut04VGXkzJXkTaoR.Zl66lEh11qd3WuI
 1.qgQ9jO7TVeO_MdNKNk2xIS0AJMdHBGiS_KFHN6QSJdCJlf2irgaV4PYgD5_URbKSwTLfXhjPOb
 QBSh7pem4.WKvCpBrRllxnxv1pSTXSjU_TxZZa3UK1lg4lJwChhHHKD5q55qgJzpYQ20fbXpL0ar
 67Jw5xNBdlOhTzjd2MI3TEqbA82rmS54f5p75zY93VZgRxFpHrlsgdVI1E6MrErPq0WY3BGmCzlE
 NfbJ8yf5pGbGRM5SYJnqmRpEBDrHL4xW8u_DG5HXmlug148f3o0SsoFK8VFEMcc9qv1yH9wKdeBJ
 BkulC_7eXuAwiK5C0ONf8qyksTHL4.FsRnaZ5YobG.UM7n3uSDqAxh9W5a3231JmldqgkUmTRrht
 TZFdm7GAG9fcuu_dkrcO8peiiU58r6QGoBTnrvQobQvTaeRq3WfDNWgAvJd91Z6mzmHz1N5y3NlZ
 c5lmbRTC9RX_nJuOF.QwTKmGbeT2lidL_Ba8LvE24OFdxp3I.36uhuQ_YsjQ1ecSNC8o7ngWfJlR
 P0wXYrH0fHAUyb0BDIBwnTWvT87KUo1SRs87jOCWEyQRndDFXzJdWM0Dj6TbV4yUfnvUtxe.NnT8
 sxJqPskBkRrydp8UABsO3KwCEH8wtmIoU6jdKqXB3cg8esmhKkJLOBba3k4DW.8wp13PEphk0W.F
 REMMqayRmhb5fISidZXRHdG6yY.xdQtlXKWhNZXMNPpkfSKgX5GwB0gG6nugbFa0ngD60l3BTXJS
 yqDr1whaM.kb9wcxwWwuaiOlFq4oCuIpHkEIZo6oFlp5.ziIgfIUVW97_O9dnzgmgBZeohKQ5nLe
 HBDeI0WExa69EteGWkd2q1cjicoaSWCGhntAgvD15_ZTgKRx7o7FwGvCMERmrqed45gDedgDwPc_
 Zdlpqrv6XpfzsAY.sko.xAIwbf8RAqQLuCkqQo4ux9CiH_NSsI1Dfa71ycM8SXnROso4VNzNjzn0
 oKBwhSVkqZRTahLz2Z_h1x1aaS02hG8mkyBRO3zb9xyY9IM8YA3PowNQgKs3U2YO_Jschl0ylZab
 2_jrcOenLLZ7Tqh5ql_wUpHTqxXyzWbCp9Bmnp44vpgyyS4nfQyJN99Aw4ovS9GiUt4LmnavDFhW
 6x.8T3SLL7tULKo5mrNj3Sb7G03_eIPjdrN2zSEjfpNyq1oPIAx7IwvPLYAQgAgqwlrsKhy.RCvw
 3.0t1bpznC24fsSBIN568q0HM2fZM144PU2cqxqky_Q848Y9wANFKdW.xtXPqnQtVRjqVIx6tlrZ
 d6I9l4uvVZZ_D_1Yl25F9YkTWdID11plxcnOz0oBbUhcaxAAuoNEM2QtXJOWIGbj_.LBfV0Y4n2u
 u3VxYE6_nOcswDV75CKHTXU_hLESpKeCKCag4Xd.kU9AYLoFSdYUP66YbrZ_N8tPytupkCwmNhMX
 gEInab4bXopDM8tRYUrZ7IorsnJv4_s9g0v6uXCXqLa_W6bqqONJ_X0X_S8JEsfas_OvCnqki2C4
 KfnYAx..KBuNBemoy0YmRUYDXamIovwldhsK5o9KfRYkF6D7c3Kq6OEQXxTzpaOVCklczBjk0k5_
 mGbdWWPKk7OfAKw8p0ZqY7Qm2oX4um8d6NnccFi9as8uXe72UjZaKDdWZ9Y2Wz3Hs1qAQovaqp9a
 M39NLB30YgxOMY26wsKAxA.sulIwFRKkotXxrGjeWhOw6aVwl0mr6kxZlgYikCC50NyWOlcsHdpi
 Y4Xel48yrF4uV2MQh66Drc9NhVFD2Vw1mjFQhJTdiaEPwHKQ2588N7kZHe43nxNx4JOQ3KwsmThw
 SdQBxW4aK9p0g0kVV24BL1_yTdXGhSW4I6nwLoYKQpCGiis2UXhuyEtLaEbo_W8vDDIJZxmptUYV
 InwrC9LW1oZFeNUXVbQMDZ3RsTHtAROVF_pAYbh07WGvPHwCrbcndH4K5khu4XrR1Vhs9I2q6_zW
 sUqt2m0RMRV7xtLl5oLWw9Q7sXQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 14:57:15 +0000
Received: by kubenode504.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID efc2df495bedd108fa3fcdc39bebc0f6;
          Tue, 09 Mar 2021 14:57:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v25 13/25] IMA: Change internal interfaces to use lsmblobs
Date:   Tue,  9 Mar 2021 06:42:31 -0800
Message-Id: <20210309144243.12519-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
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
 security/integrity/ima/ima_main.c     | 34 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 17 +++++++-------
 5 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 475f5622a903..ec3094f6b302 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -255,7 +255,7 @@ static inline void ima_process_queued_keys(void) {}
 
 /* LIM API function definitions */
 int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
-		   const struct cred *cred, u32 secid, int mask,
+		   const struct cred *cred, struct lsmblob *blob, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data);
@@ -286,8 +286,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
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
index ab0557628336..3b2a4d3a2189 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -77,10 +77,9 @@ int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
 		return 0;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding the .secid[0] */
 	return ima_match_policy(mnt_userns, inode, current_cred(),
-				blob.secid[0], func, mask,
-				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
+				&blob, func, mask, IMA_APPRAISE | IMA_HASH,
+				NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5a6ba57beef3..1ca861c5628b 100644
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
 		security_task_getsecid(current, &blob);
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
@@ -500,8 +497,7 @@ int ima_file_check(struct file *file, int mask)
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -692,8 +688,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding - until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL,
+	return process_measurement(file, current_cred(), &blob, NULL,
 				   0, MAY_READ, func);
 }
 
@@ -736,9 +731,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
@@ -882,7 +876,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 		security_task_getsecid(current, &blob);
 		/* scaffolding */
 		action = ima_get_action(mnt_userns, inode, current_cred(),
-					blob.secid[0], 0, func, &pcr, &template,
+					&blob, 0, func, &pcr, &template,
 					func_data);
 		if (!(action & IMA_MEASURE))
 			return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 1cadd61533d7..3ee9f7feca4b 100644
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
 		default:
@@ -670,7 +669,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -685,8 +684,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
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
@@ -702,7 +701,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, mnt_userns, inode, cred, secid,
+		if (!ima_match_rules(entry, mnt_userns, inode, cred, blob,
 				     func, mask, func_data))
 			continue;
 
-- 
2.29.2

