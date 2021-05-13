Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A7D37FEE5
	for <lists+linux-integrity@lfdr.de>; Thu, 13 May 2021 22:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhEMUXu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 May 2021 16:23:50 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:46324
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231343AbhEMUXu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 May 2021 16:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937360; bh=vmPLppdW1T7Yboao5H0X3j8apQPb/Sk4zDvbIPEe/TI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Nzr94B0plmXhWvSHvVe6tsVpR/5A/eH7PLnXlZ4g0DuuYPd0Xs97ZDIb0CSjy6+nh8RZx4+co6lfv+aN0/qDeJ9vb81GaOdjIMtRBxYU7wdFJsHOTYzi5jUOSFRUv0p5lWaLgJlp1KXZ4qJ630cSmFoVgb6hkejktzKwl8HxcE1kiuZNBFyJsj08Zg5WLKveb1do7rIUoQQmDpLKPpazBD7mvkSftXPNH0+svbK5QamV0qpUKJa9F2Ud3rkI/WcPM1R9GCRQX/hktinOb4ax5YkgR3fbjYN8itkg6l8wtLWH7SkLyyvI98xDVR4bFY0RkGR7vReq3Br4YjCoOsJQzA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937360; bh=kKK7XGcid1ZQdSCKgsXOWu5Vd1av9IWciSS11b2SlZz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fV3IxsuofQLMo6PNZQaShF4jval0tM7D9xUOn5vNqo/7FPFVII/Ug781RY00VWfPe1nuwKKxqsXjREynB0m5DDCeHprrbh0gtukd+eXml8pA1HsRjMYshXTNgHYWS5Yhfpv2V0wCqw6j/x7PhwgqEfUw2U41oLqn/zrZVa00bQaU/h7YuVZnM192Z9O7VBDTzwceUQdUmldeSbZ+TQiGG/0DAVK8G2+FzLp+IK1/mK4F97ZZXJBnuQWwBWjXinhnSTfZIGepadX/7BjCNfakadVWe8x/h3A/raO1lp/hBVW0KV8skqUn69r86OGYmgOHCK+pilqrmd+Vx0AytaMZcg==
X-YMail-OSG: RLwmkZgVM1l_rvF2S7Nc0QNJciDSv_f0lE8hFU15dfa6qegMeHf8bNoubERbEaB
 dymSJbA7F90t9.YBQF.7X.3Vx5zVMznNCdjdk5lw0Uh3LEd2_dIMiKEysNXLQ1DeHjDTjzIotcqV
 m0TrnoswqHl0TyqDcXpttwnyDVIjZZyDdFoLN8j7YWoylAIYQRisYKxTPCw5.VBo4bFLdHZqd6KR
 AbgcloWlQOA0n4LamA7KhTahLiHCLOnRFveAx7DI_nudShsXJQsIkY5D3xpsn0UbuWWKwW2QopHo
 6kI5zqfe.MjSwbkAwsClDk33BLM64lnp9ws4N_7m_sRFG.LAw7RN0GMuPIgqAnSw7cM4TXgUupH_
 HLg_I.9fJf9cDdzw3e5Ou8OY4TqVv_MsmNvnp.QYIzRDGtraeM67oTx4LHTCBasnCmJta5XqfPWJ
 SZtyRzHKe3rpW5.DeCX6bMe6wVMVDWKXWhO.c20Onfj.2f6h7l20yUIRzWOrgRmqDDpFRD_evtwj
 d4.X9YlNx.zDWsns01eoJ3BgwHcNNxIvvodW8A6S8AjtJ0.N6jlFOZirwDsqk8oEh0pE6f_zQcn0
 IVja534ewDsKzuve6KA7XbqyE.qU3akk6YBfz1oyihB4joNVSCTFcrepTSNqrtdaU.s0QoOyEwck
 bk1_w1dwkZZrpBXi7U67EeesHWfU1a0CNuzqBeQ6wMbXwhl_5yeYP2Hq_Bgk6yNhuILhcseYA6Yj
 LvnEus9oXu009I1WqPkJ0FBW5XSQ6S.DuRFwSmS_36TmSeIBE3L1ALhtRxeIhy3xGW5mAcComr8i
 t.xe1gdyng1QofHu6F3S5Ui6KWmBo_8WyoR5uCtjfrHmpjLU37Pcy7fhZ_1goBj9dFu.STZmust.
 6f4kHjNVvNu3trSPA0v3Jats5XXKB.qAUPuiPQcfgJb_ftQwdSBlPlMtmq6Zi.l3cibuOTi0U2lB
 rEoFPnxy4s4w3dtxY1mxvMbUnlZ5O75tXGx2T.2pUzHOBIpJiutvKoyWsdysYreMStIuO57KJmQp
 q2Qix5ynvomXwYrGUYtmc5U_zcvAVPAc4yh_A8m0Sq9hANRi2.61L5orBkCeX.PRRmPKbrVoto7S
 idrkVo0jS2zFhcpIAW.w6MFTWX3Es0NLZvHrOUn.tnxe6.3_d2lCVwsraEMPz_ZnsOSr4Ada42pU
 8kDxCzDvArwKQGVNNJnTD_7UPEpV6RTQoBI2U.MNyEKsbx5X4wjkICVK7i14nt5o6FI75epgHrH8
 8aI0sBVRiaSvbVj2C1euiVH8oI0Ln6iPBsIZ0PMgzR5T6hSdSQWuITV84ZVp09zrt8mbh3BC1uOb
 rnhslL.evXfjkxx67mTAygtPYTqZ7.kZiFoF5jr6bHHBVTGZs7aQBldInXJj8KJFiVIzR0MMKohP
 KejAZSi0mmJ1_8EixQentuj_K8c8e6olFA0hyCgw._jFBneJaLlh2fClA5je_auhcZI7x9FeQhgg
 KzkadtVdIAnoIeYagr7K7po7sVlllE3EtayM_65ylzU0OKNxxW3iVwetHftZPKk5_Z5gn0vJKdmM
 uOGJC4.aVWwZQWbvCR4j2Xou.s9cqvNuLF8AuLB8R.JQkYinetOOD_9ZodQ72jeeU4pySGCzhvHn
 asdvTQHkN0TVLClYTt8dzjMEMATxyKuDqrkzl2DXbF_5Ehfd4v9WZZeQYXDeiUqBEAaWIUdlNVeH
 jW5MG9IwjkkVrK_F.Kcxn0JJpejDdl3.uI6o95VD0jtRdkBKfMhii0Hh_iTwHSfM86094GWIuA.6
 NB8LTWWHLJCylHXnQYlugSJYbKbDo5IpU8Sa462IT_B0.WC62yc3uYuoQbz27q.a12H6EeeeZzN6
 rwzouiwX0X0gmEphEjICX7SZUCYnoQSwzyi2YXXZb3nUwe0eWHvWVBYuR2F.wb9pmtRLwBOpbp0I
 1YtN5B_IpdZS8xyaXcczvKqLBahyOoeh_7AgAJ3KMNr4X0ud_Xf9fTxQLszWwOZu5esZS0AImCCB
 vSuF5PAEB1o0VQ5OcbJsUtkqCQN2nyCFdoW58QHMHFqWtLieklmP4QXIpo25h1HpEOOjcHGxMfui
 jdwpJyqOYg7a9Qe0LpYOqyvAdpGYodnQ_Hw9zC.6Oo6VFouIGKrgeuvhuLHKUsAJzSVhyuONDXa0
 ECzaNlFT3baMGotQxmKkpmPkDiJCiMVMgYmxsEXJGrfWf2naPnYWS1LPj5XJNkAYS7cTQ4L2bvtV
 ckJEwljlI0QWxPBSV4wdxboBsTaYR4jMQFW0Xju9Y4JXV2V.HKp5JzTei3ZsNtWOdDChc0YI1lpu
 Kj_XVzeNoBdV4lCYXaMW8JyB0APRhKY6vZgXFoqzdoh7Ch8LPj20Bg_L2Q0epsJ.A8SeVSFkjZwb
 u4TNIAKPRYzrRcDZfFtcxhnJU2jdI2.FkzPU4PDQPVBhtRxmOF_lrzc6yRHTcG6LIup.16kSQVDb
 an0cZDfrs.DymTpC5MBhCZbqPVAHNdi5gtKYgWm7fgPfb5KUcv.0_J7xOTm_xx3g4S1tb2Oks7Mr
 8CrEPh71jAf1bxCLIEGQB894M7x.QsT.32rdRukyIGW8a.T2eRxXi9.T5Ra25Oldoc6VM6982Ebi
 sde8mTcNXCO_5.dpj6vyZjg1N0BamzK9fM5YfNBYOVHz1LKWRJH4IRwBjNd8laiAC5OHRSgEcJyw
 .FDQWuY4KzenR5TJhOdH47Je5KvJdh6SKsHWtai1tVAubpAtxE_u3FoMtPaP5JMto86wd6vCDVIV
 ZiSbGGVSyhPKtCOMvWczHHMJWATaYYRh0tD1.noD4DVRoM10fgxRSFA99hLlFEoiTCfpo7Ldu.pf
 2Z3HnkvvqcirLaNzvCvHra14XEwvHotapffPkbAAOsQWFa6fGbqeGvQAt54E4ug5_O46W.XiDc14
 TbqIdB9J7i94K2MA6u8HKymmuGk3v8NOOWjEfGfDdVeHUoS56ycjZAUGFHhDtcmtDQE66Jhuog2W
 moMTQ2bfZ80L6YFI9Zj0DdGXYXwK4qrtH7r7_BrA5MwCNMd5sHwMTHg9aG.NErPfvTtwJ9P.V95I
 UwEhnUQZpbKrNxJZ1hmIgR2Gvu3zfrL3VwSi4eyo7AkC6TRnMs3ssSJq6b7OFr4vTQPkAKB2ORYt
 0ivqdaXlJ1z6cnjKiuG4X3njK32lPyAFb4JyZOmCe45ZqxgOeYhHRBipAdwbfyffr4pD4erOSDmK
 azfv2Eb7kcvykiX28gxxaJqtf5eXC0foRfYXZPd_WyAPEJdyDFBCTieGK
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:22:40 +0000
Received: by kubenode563.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2c2e2ab30ddd755d1597eb2aefb2afac;
          Thu, 13 May 2021 20:22:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v26 13/25] IMA: Change internal interfaces to use lsmblobs
Date:   Thu, 13 May 2021 13:07:55 -0700
Message-Id: <20210513200807.15910-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
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

